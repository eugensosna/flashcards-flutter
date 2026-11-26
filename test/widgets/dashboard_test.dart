import 'package:flashcards/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flashcards/features/decks/data/repositories/drift_deck_repository.dart';
import 'package:flashcards/features/flashcards/data/repositories/drift_flashcard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/override.dart';
import '../helpers/test_database.dart';

void main() {
  testWidgets('shows totals, due count and recent decks', (tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    final deck = await DriftDeckRepository(db.deckDao)
        .createDeck(name: 'Biology');
    final cards = DriftFlashcardRepository(db.flashcardDao);
    await cards.createFlashcard(
      deckId: deck.id,
      front: 'Mitochondria',
      back: 'Powerhouse of the cell',
    );
    await cards.createFlashcard(
      deckId: deck.id,
      front: 'Nucleus',
      back: 'Stores DNA',
    );

    await pumpApp(tester, testApp(const DashboardScreen(), db));

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Recent decks'), findsOneWidget);
    expect(find.text('Biology'), findsOneWidget);
    expect(find.textContaining('2 cards are due'), findsOneWidget);
    expect(find.text('Studied today'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('shows the empty state when there are no decks', (tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    await pumpApp(tester, testApp(const DashboardScreen(), db));

    expect(find.text('All caught up'), findsOneWidget);
    expect(find.text('No decks yet'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('shows a loading indicator before the first emission', (
    tester,
  ) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    await tester.pumpWidget(testApp(const DashboardScreen(), db));

    expect(find.byType(CircularProgressIndicator), findsWidgets);

    await settleApp(tester);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await disposeApp(tester);
  });
}
