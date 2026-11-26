import 'package:flashcards/core/database/app_database.dart';
import 'package:flashcards/features/decks/data/repositories/drift_deck_repository.dart';
import 'package:flashcards/features/flashcards/data/repositories/drift_flashcard_repository.dart';
import 'package:flashcards/features/study/presentation/screens/study_session_screen.dart';
import 'package:flashcards/features/study/presentation/widgets/flip_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/override.dart';
import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late int deckId;
  late List<int> cardIds;

  setUp(() async {
    db = createTestDatabase();
    final deck = await DriftDeckRepository(db.deckDao).createDeck(name: 'Math');
    deckId = deck.id;
    final cards = DriftFlashcardRepository(db.flashcardDao);
    final first = await cards.createFlashcard(
      deckId: deckId,
      front: 'What is two plus two?',
      back: 'four',
    );
    final second = await cards.createFlashcard(
      deckId: deckId,
      front: 'What is three times three?',
      back: 'nine',
    );
    cardIds = [first.id, second.id];
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('flips the card, records a rating and advances', (tester) async {
    await pumpApp(tester, testApp(StudySessionScreen(deckId: deckId), db));

    expect(find.text('What is two plus two?'), findsOneWidget);
    expect(find.text('four'), findsNothing);
    expect(find.text('1/2'), findsOneWidget);

    await tester.tap(find.byType(FlipCard));
    await settleApp(tester);

    expect(find.text('four'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);

    await tester.tap(find.text('Good'));
    await settleApp(tester);

    expect(find.text('2/2'), findsOneWidget);
    expect(find.text('What is three times three?'), findsOneWidget);

    final progress = await db.studyDao.getProgress(cardIds.first);
    expect(progress, isNotNull);
    expect(progress!.reviewCount, 1);
    expect(progress.interval, 1);

    await disposeApp(tester);
  });

  testWidgets('shows the completion summary after the last card', (
    tester,
  ) async {
    await pumpApp(tester, testApp(StudySessionScreen(deckId: deckId), db));

    for (var index = 0; index < 2; index++) {
      await tester.tap(find.byType(FlipCard));
      await settleApp(tester);
      await tester.tap(find.text('Easy'));
      await settleApp(tester);
    }

    expect(find.text('Session complete'), findsOneWidget);
    expect(find.text('You reviewed 2 of 2 cards.'), findsOneWidget);
    expect(find.text('Study again'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('offers practice mode when nothing is due', (tester) async {
    final emptyDeck = await DriftDeckRepository(db.deckDao)
        .createDeck(name: 'Empty');

    await pumpApp(
      tester,
      testApp(StudySessionScreen(deckId: emptyDeck.id), db),
    );

    expect(find.text('Nothing due right now'), findsOneWidget);
    expect(find.text('Practice all cards'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('does not show rating buttons before the card is flipped', (
    tester,
  ) async {
    await pumpApp(tester, testApp(StudySessionScreen(deckId: deckId), db));

    expect(find.text('Good'), findsNothing);
    expect(find.text('Reveal the answer to rate this card.'), findsOneWidget);

    await disposeApp(tester);
  });
}
