import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flashcards/core/database/app_database.dart';
import 'package:flashcards/core/database/daos/deck_dao.dart';
import 'package:flashcards/features/decks/domain/entities/deck_sort.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> addDeck(String name, {DateTime? createdAt}) {
    final now = createdAt ?? DateTime(2026, 1, 1, 12);
    return db.deckDao.insertDeck(
      DecksCompanion.insert(name: name, createdAt: now, updatedAt: now),
    );
  }

  Future<int> addCard(int deckId, String front, {String back = 'back'}) async {
    final now = DateTime(2026, 1, 1, 12);
    final position = await db.flashcardDao.nextPosition(deckId);
    return db.flashcardDao.insertCard(
      FlashcardsCompanion.insert(
        deckId: deckId,
        front: front,
        back: back,
        createdAt: now,
        updatedAt: now,
        position: Value(position),
      ),
    );
  }

  group('decks', () {
    test('inserts, updates and deletes decks', () async {
      final id = await addDeck('Spanish');

      final created = await db.deckDao.getDeckById(id);
      expect(created, isNotNull);
      expect(created!.name, 'Spanish');

      await db.deckDao.updateDeck(
        DecksCompanion(
          id: Value(id),
          name: const Value('Spanish verbs'),
          updatedAt: Value(DateTime(2026, 2, 1)),
        ),
      );
      final updated = await db.deckDao.getDeckById(id);
      expect(updated!.name, 'Spanish verbs');
      expect(updated.description, isNull);

      expect(await db.deckDao.deleteDeck(id), 1);
      expect(await db.deckDao.getDeckById(id), isNull);
    });

    test('sorts by creation date when timestamps differ', () async {
      await addDeck('Oldest', createdAt: DateTime(2026, 1, 1, 8));
      await addDeck('Middle', createdAt: DateTime(2026, 1, 2, 8));
      await addDeck('Newest', createdAt: DateTime(2026, 1, 3, 8));

      final newest = await db.deckDao.getAllDecks(
        sort: DeckSort.createdAtNewest,
      );
      expect(newest.map((deck) => deck.name), ['Newest', 'Middle', 'Oldest']);

      final oldest = await db.deckDao.getAllDecks(
        sort: DeckSort.createdAtOldest,
      );
      expect(oldest.map((deck) => deck.name), ['Oldest', 'Middle', 'Newest']);
    });

    test('searches by name and sorts alphabetically', () async {
      await addDeck('Biology');
      await addDeck('Astronomy');
      await addDeck('Chemistry');

      final all = await db.deckDao.watchDecks().first;
      expect(all.map((entry) => entry.deck.name), [
        'Astronomy',
        'Biology',
        'Chemistry',
      ]);

      final filtered = await db.deckDao.watchDecks(query: 'bio').first;
      expect(filtered, hasLength(1));
      expect(filtered.single.deck.name, 'Biology');
    });

    test('counts cards and due cards per deck', () async {
      final deckId = await addDeck('Deck');
      final otherDeckId = await addDeck('Other');
      final dueCard = await addCard(deckId, 'due');
      await addCard(deckId, 'new');
      await addCard(otherDeckId, 'elsewhere');

      await db.studyDao.upsertProgress(
        StudyProgressCompanion(
          flashcardId: Value(dueCard),
          dueDate: Value(DateTime(2020, 1, 1)),
        ),
      );

      final summary = (await db.deckDao.watchDecks().first).firstWhere(
        (entry) => entry.deck.id == deckId,
      );
      expect(summary.cardCount, 2);
      // The reviewed card is overdue, the untouched card has no progress row.
      expect(summary.dueCount, 2);
    });
  });

  group('flashcards', () {
    test('assigns increasing positions', () async {
      final deckId = await addDeck('Deck');
      final first = await addCard(deckId, 'first');
      final second = await addCard(deckId, 'second');

      final cards = await db.flashcardDao.getByDeck(deckId);
      expect(cards.map((card) => card.id), [first, second]);
      expect(cards.map((card) => card.position), [0, 1]);
    });

    test('reorders cards inside a transaction', () async {
      final deckId = await addDeck('Deck');
      final first = await addCard(deckId, 'first');
      final second = await addCard(deckId, 'second');
      final third = await addCard(deckId, 'third');

      await db.flashcardDao.reorder(deckId, [third, first, second]);

      final cards = await db.flashcardDao.getByDeck(deckId);
      expect(cards.map((card) => card.id), [third, first, second]);
      expect(cards.map((card) => card.position), [0, 1, 2]);
    });

    test('moves cards to another deck at the end', () async {
      final source = await addDeck('Source');
      final target = await addDeck('Target');
      await addCard(target, 'existing');
      final moved = await addCard(source, 'moving');

      await db.flashcardDao.moveToDeck(moved, target);

      final sourceCards = await db.flashcardDao.getByDeck(source);
      expect(sourceCards, isEmpty);
      final targetCards = await db.flashcardDao.getByDeck(target);
      expect(targetCards.last.id, moved);
      expect(targetCards.last.position, 1);
    });

    test('hides archived cards unless requested', () async {
      final deckId = await addDeck('Deck');
      final cardId = await addCard(deckId, 'archived');
      await addCard(deckId, 'visible');

      await db.flashcardDao.setArchived(cardId, archived: true);

      expect(await db.flashcardDao.getByDeck(deckId), hasLength(1));
      expect(
        await db.flashcardDao.getByDeck(deckId, includeArchived: true),
        hasLength(2),
      );
    });

    test('rejects cards that reference a missing deck', () async {
      await expectLater(addCard(404, 'orphan'), throwsA(isA<Exception>()));
    });
  });

  group('study progress', () {
    test('keeps a single progress row per flashcard', () async {
      final deckId = await addDeck('Deck');
      final cardId = await addCard(deckId, 'card');

      await db.studyDao.upsertProgress(
        StudyProgressCompanion(
          flashcardId: Value(cardId),
          dueDate: Value(DateTime(2026, 5, 1)),
        ),
      );
      await db.studyDao.upsertProgress(
        StudyProgressCompanion(
          flashcardId: Value(cardId),
          dueDate: Value(DateTime(2026, 6, 1)),
          repetitions: const Value(3),
        ),
      );

      final rows = await db.select(db.studyProgress).get();
      expect(rows, hasLength(1));
      expect(rows.single.repetitions, 3);
      expect(rows.single.dueDate, DateTime(2026, 6, 1));
    });

    test('saveReview writes progress and history atomically', () async {
      final deckId = await addDeck('Deck');
      final cardId = await addCard(deckId, 'card');
      final now = DateTime(2026, 4, 2, 9);

      await db.studyDao.saveReview(
        progress: StudyProgressCompanion(
          flashcardId: Value(cardId),
          dueDate: Value(DateTime(2026, 4, 3)),
          lastReviewedAt: Value(now),
          repetitions: const Value(1),
          interval: const Value(1),
          reviewCount: const Value(1),
        ),
        log: ReviewLogsCompanion.insert(
          flashcardId: cardId,
          deckId: deckId,
          rating: 2,
          reviewedAt: now,
          newInterval: const Value(1),
        ),
      );

      final progress = await db.studyDao.getProgress(cardId);
      expect(progress, isNotNull);
      expect(progress!.reviewCount, 1);

      final logs = await db.select(db.reviewLogs).get();
      expect(logs, hasLength(1));
      expect(logs.single.rating, 2);
    });

    test('cascade deletes remove progress and history', () async {
      final deckId = await addDeck('Deck');
      final cardId = await addCard(deckId, 'card');
      await db.studyDao.upsertProgress(
        StudyProgressCompanion(
          flashcardId: Value(cardId),
          dueDate: Value(DateTime(2026, 5, 1)),
        ),
      );
      await db
          .into(db.reviewLogs)
          .insert(
            ReviewLogsCompanion.insert(
              flashcardId: cardId,
              deckId: deckId,
              rating: 1,
              reviewedAt: DateTime(2026, 5, 1),
            ),
          );

      await db.deckDao.deleteDeck(deckId);

      expect(await db.select(db.flashcards).get(), isEmpty);
      expect(await db.select(db.studyProgress).get(), isEmpty);
      expect(await db.select(db.reviewLogs).get(), isEmpty);
    });
  });

  group('reactive queries', () {
    test('watchDecks emits updated counts after a card is added', () async {
      final deckId = await addDeck('Deck');
      final emissions = <List<DeckWithCount>>[];
      final subscription = db.deckDao.watchDecks().listen(emissions.add);

      await waitUntil(() => emissions.isNotEmpty);
      expect(emissions.last.single.cardCount, 0);

      await addCard(deckId, 'new card');

      await waitUntil(
        () => emissions.isNotEmpty && emissions.last.single.cardCount == 1,
      );
      expect(emissions.last.single.cardCount, 1);

      await subscription.cancel();
    });

    test('watchDueCount reacts to new progress', () async {
      final deckId = await addDeck('Deck');
      final cardId = await addCard(deckId, 'card');
      final counts = <int>[];
      final subscription = db.studyDao.watchDueCount().listen(counts.add);

      await waitUntil(() => counts.isNotEmpty);
      expect(counts.last, 1);

      await db.studyDao.upsertProgress(
        StudyProgressCompanion(
          flashcardId: Value(cardId),
          dueDate: Value(DateTime.now().add(const Duration(days: 5))),
        ),
      );

      await waitUntil(() => counts.isNotEmpty && counts.last == 0);
      expect(counts.last, 0);

      await subscription.cancel();
    });
  });
}
