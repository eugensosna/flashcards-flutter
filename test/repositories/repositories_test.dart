import 'package:flashcards/core/database/app_database.dart';
import 'package:flashcards/features/decks/data/repositories/drift_deck_repository.dart';
import 'package:flashcards/features/decks/domain/entities/deck_sort.dart';
import 'package:flashcards/features/decks/domain/usecases/create_deck_usecase.dart';
import 'package:flashcards/features/decks/domain/usecases/delete_deck_usecase.dart';
import 'package:flashcards/features/decks/domain/usecases/update_deck_usecase.dart';
import 'package:flashcards/features/flashcards/data/repositories/drift_flashcard_repository.dart';
import 'package:flashcards/features/flashcards/domain/usecases/create_flashcard_usecase.dart';
import 'package:flashcards/features/flashcards/domain/usecases/update_flashcard_usecase.dart';
import 'package:flashcards/features/study/data/repositories/drift_study_repository.dart';
import 'package:flashcards/features/study/domain/algorithms/sm2_scheduler.dart';
import 'package:flashcards/features/study/domain/entities/review_rating.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftDeckRepository deckRepository;
  late DriftFlashcardRepository flashcardRepository;
  late DriftStudyRepository studyRepository;

  setUp(() {
    db = createTestDatabase();
    deckRepository = DriftDeckRepository(db.deckDao);
    flashcardRepository = DriftFlashcardRepository(db.flashcardDao);
    studyRepository = DriftStudyRepository(
      database: db,
      studyDao: db.studyDao,
      statsDao: db.statsDao,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('deck repository', () {
    test('creates, updates and deletes decks', () async {
      final deck = await deckRepository.createDeck(
        name: 'Biology',
        description: 'Cells',
        color: '#FF0000',
      );

      expect(deck.id, greaterThan(0));
      expect(deck.description, 'Cells');

      final updated = await deckRepository.updateDeck(
        id: deck.id,
        name: 'Biology 101',
        description: null,
        color: '#00FF00',
      );
      expect(updated.name, 'Biology 101');
      expect(updated.description, isNull);
      expect(
        updated.updatedAt.isAfter(deck.updatedAt) ||
            updated.updatedAt == deck.updatedAt,
        isTrue,
      );

      await deckRepository.deleteDeck(deck.id);
      expect(await deckRepository.getDeck(deck.id), isNull);
      expect(await deckRepository.countDecks(), 0);
    });

    test('watchDeck emits null after the deck is deleted', () async {
      final deck = await deckRepository.createDeck(name: 'Temporary');
      final emissions = <bool>[];
      final subscription = deckRepository
          .watchDeck(deck.id)
          .listen((summary) => emissions.add(summary != null));

      await waitUntil(() => emissions.isNotEmpty);
      await deckRepository.deleteDeck(deck.id);
      await waitUntil(() => emissions.last == false);
      expect(emissions.last, isFalse);

      await subscription.cancel();
    });

    test('sorts decks case-insensitively by name', () async {
      await deckRepository.createDeck(name: 'Banana');
      await deckRepository.createDeck(name: 'apple');
      await deckRepository.createDeck(name: 'Cherry');

      final ascending = await deckRepository.getAllDecks();
      expect(ascending.map((deck) => deck.name), ['apple', 'Banana', 'Cherry']);

      final descending = await deckRepository.getAllDecks(
        sort: DeckSort.nameDesc,
      );
      expect(descending.map((deck) => deck.name), [
        'Cherry',
        'Banana',
        'apple',
      ]);
    });

    test('create deck use case validates the name', () async {
      final createDeck = CreateDeck(deckRepository);
      expect(() => createDeck(name: '   '), throwsA(isA<Exception>()));
      final deck = await createDeck(name: '  Trimmed  ');
      expect(deck.name, 'Trimmed');
    });

    test('update and delete use cases delegate to the repository', () async {
      final deck = await deckRepository.createDeck(name: 'Deck');
      final updateDeck = UpdateDeck(deckRepository);
      final renamed = await updateDeck(id: deck.id, name: 'Renamed');
      expect(renamed.name, 'Renamed');

      await DeleteDeck(deckRepository)(deck.id);
      expect(await deckRepository.getDeck(deck.id), isNull);
    });
  });

  group('flashcard repository', () {
    test('creates cards with sequential positions', () async {
      final deck = await deckRepository.createDeck(name: 'Deck');
      final createCard = CreateFlashcard(flashcardRepository);

      final first = await createCard(
        deckId: deck.id,
        front: ' front ',
        back: ' back ',
      );
      final second = await createCard(
        deckId: deck.id,
        front: 'second',
        back: 'answer',
      );

      expect(first.front, 'front');
      expect(first.position, 0);
      expect(second.position, 1);
    });

    test('rejects empty card content', () async {
      final deck = await deckRepository.createDeck(name: 'Deck');
      final createCard = CreateFlashcard(flashcardRepository);

      expect(
        () => createCard(deckId: deck.id, front: '', back: 'answer'),
        throwsA(isA<Exception>()),
      );
      expect(
        () => createCard(deckId: deck.id, front: 'question', back: '  '),
        throwsA(isA<Exception>()),
      );
    });

    test('updates, archives, moves and deletes cards', () async {
      final source = await deckRepository.createDeck(name: 'Source');
      final target = await deckRepository.createDeck(name: 'Target');
      final card = await flashcardRepository.createFlashcard(
        deckId: source.id,
        front: 'question',
        back: 'answer',
      );

      final updateCard = UpdateFlashcard(flashcardRepository);
      final updated = await updateCard(
        id: card.id,
        deckId: source.id,
        front: 'new question',
        back: 'new answer',
      );
      expect(updated.front, 'new question');

      await flashcardRepository.setArchived(cardId: card.id, archived: true);
      expect(await flashcardRepository.getFlashcardsByDeck(source.id), isEmpty);
      await flashcardRepository.setArchived(cardId: card.id, archived: false);
      expect(
        await flashcardRepository.getFlashcardsByDeck(source.id),
        hasLength(1),
      );

      await flashcardRepository.moveFlashcard(
        cardId: card.id,
        targetDeckId: target.id,
      );
      expect(await flashcardRepository.getFlashcardsByDeck(source.id), isEmpty);
      final moved = await flashcardRepository.getFlashcard(card.id);
      expect(moved!.deckId, target.id);

      await flashcardRepository.deleteFlashcard(card.id);
      expect(await flashcardRepository.getFlashcard(card.id), isNull);
    });

    test('reorders cards by the given id order', () async {
      final deck = await deckRepository.createDeck(name: 'Deck');
      final first = await flashcardRepository.createFlashcard(
        deckId: deck.id,
        front: 'a',
        back: 'a',
      );
      final second = await flashcardRepository.createFlashcard(
        deckId: deck.id,
        front: 'b',
        back: 'b',
      );

      await flashcardRepository.reorderFlashcards(
        deckId: deck.id,
        orderedCardIds: [second.id, first.id],
      );

      final cards = await flashcardRepository.getFlashcardsByDeck(deck.id);
      expect(cards.map((card) => card.id), [second.id, first.id]);
    });
  });

  group('study repository', () {
    late int deckId;
    late int cardId;

    setUp(() async {
      final deck = await deckRepository.createDeck(name: 'Deck');
      deckId = deck.id;
      final card = await flashcardRepository.createFlashcard(
        deckId: deckId,
        front: 'question',
        back: 'answer',
      );
      cardId = card.id;
    });

    test('exposes due cards until they are reviewed', () async {
      final dueBefore = await studyRepository.getDueFlashcards(deckId: deckId);
      expect(dueBefore, hasLength(1));
      expect(dueBefore.single.isNew, isTrue);

      const scheduler = Sm2Scheduler();
      final reviewedAt = DateTime.now();
      final schedule = scheduler.schedule(
        rating: ReviewRating.good,
        repetitions: 0,
        easeFactor: 2.5,
        interval: 0,
        reviewedAt: reviewedAt,
      );

      final saved = await studyRepository.saveReview(
        deckId: deckId,
        card: dueBefore.single,
        rating: ReviewRating.good,
        schedule: schedule,
        reviewedAt: reviewedAt,
      );

      expect(saved.interval, 1);
      expect(saved.reviewCount, 1);
      // SQLite stores timestamps with second precision.
      expect(
        saved.lastReviewedAt!.millisecondsSinceEpoch ~/ 1000,
        reviewedAt.millisecondsSinceEpoch ~/ 1000,
      );

      final dueAfter = await studyRepository.getDueFlashcards(deckId: deckId);
      expect(dueAfter, isEmpty);

      final all = await studyRepository.getAllStudyCards(deckId);
      expect(all, hasLength(1));
      expect(all.single.progress, isNotNull);
    });

    test('aggregates statistics from the database', () async {
      final before = await studyRepository.getStatistics();
      expect(before.totalCards, 1);
      expect(before.newCards, 1);
      expect(before.dueCards, 1);
      expect(before.totalReviews, 0);
      expect(before.history, hasLength(7));

      const scheduler = Sm2Scheduler();
      final now = DateTime.now();
      final card = (await studyRepository.getDueFlashcards(deckId: deckId))
          .single;
      await studyRepository.saveReview(
        deckId: deckId,
        card: card,
        rating: ReviewRating.easy,
        schedule: scheduler.schedule(
          rating: ReviewRating.easy,
          repetitions: 0,
          easeFactor: 2.5,
          interval: 0,
          reviewedAt: now,
        ),
        reviewedAt: now,
      );

      final after = await studyRepository.getStatistics();
      expect(after.reviewsToday, 1);
      expect(after.studiedToday, 1);
      expect(after.totalReviews, 1);
      expect(after.history.last.count, 1);
      expect(after.averageEaseFactor, closeTo(2.6, 0.001));
    });

    test('watchStatistics emits after a review', () async {
      final emissions = <int>[];
      final subscription = studyRepository.watchStatistics().listen(
        (stats) => emissions.add(stats.totalReviews),
      );

      await waitUntil(() => emissions.isNotEmpty);
      expect(emissions.last, 0);

      final card = (await studyRepository.getDueFlashcards(deckId: deckId))
          .single;
      const scheduler = Sm2Scheduler();
      final now = DateTime.now();
      await studyRepository.saveReview(
        deckId: deckId,
        card: card,
        rating: ReviewRating.good,
        schedule: scheduler.schedule(
          rating: ReviewRating.good,
          repetitions: 0,
          easeFactor: 2.5,
          interval: 0,
          reviewedAt: now,
        ),
        reviewedAt: now,
      );

      await waitUntil(() => emissions.isNotEmpty && emissions.last == 1);
      expect(emissions.last, 1);
      expect(cardId, isPositive);

      // Cancelling before closing avoids waiting on the open update stream.
      await subscription.cancel();
    });
  });
}
