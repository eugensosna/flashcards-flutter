import 'package:flashcards/features/decks/data/repositories/drift_deck_repository.dart';
import 'package:flashcards/features/decks/presentation/screens/deck_list_screen.dart';
import 'package:flashcards/features/decks/presentation/widgets/deck_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/override.dart';
import '../helpers/test_database.dart';

void main() {
  testWidgets('lists decks and filters them with the search field', (
    tester,
  ) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    final repository = DriftDeckRepository(db.deckDao);
    await repository.createDeck(name: 'Biology', description: 'Cells');
    await repository.createDeck(name: 'Astronomy');

    await pumpApp(tester, testApp(const DeckListScreen(), db));

    expect(find.byType(DeckTile), findsNWidgets(2));
    expect(find.text('Biology'), findsOneWidget);
    expect(find.text('Astronomy'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'bio');
    await settleApp(tester);

    expect(find.byType(DeckTile), findsOneWidget);
    expect(find.text('Biology'), findsOneWidget);
    expect(find.text('Astronomy'), findsNothing);

    await disposeApp(tester);
  });

  testWidgets('shows an empty state with no decks', (tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    await pumpApp(tester, testApp(const DeckListScreen(), db));

    expect(find.text('No decks yet'), findsOneWidget);
    expect(find.text('Create a deck'), findsWidgets);

    await disposeApp(tester);
  });

  testWidgets('shows a no-results state for unmatched searches', (
    tester,
  ) async {
    final db = createTestDatabase();
    addTearDown(db.close);
    await DriftDeckRepository(db.deckDao).createDeck(name: 'Biology');

    await pumpApp(tester, testApp(const DeckListScreen(), db));

    await tester.enterText(find.byType(TextField), 'zzz');
    await settleApp(tester);

    expect(find.text('No matching decks'), findsOneWidget);
    expect(find.text('Clear search'), findsOneWidget);

    await disposeApp(tester);
  });
}
