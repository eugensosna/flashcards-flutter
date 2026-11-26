import 'package:flashcards/features/decks/data/repositories/drift_deck_repository.dart';
import 'package:flashcards/features/flashcards/data/repositories/drift_flashcard_repository.dart';
import 'package:flashcards/features/flashcards/presentation/screens/flashcard_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helpers/override.dart';
import '../helpers/test_database.dart';

void main() {
  testWidgets('validates empty content and saves a new card', (tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    final deck = await DriftDeckRepository(db.deckDao)
        .createDeck(name: 'Biology');
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('home')),
        ),
        GoRoute(
          path: '/card',
          builder: (context, state) => FlashcardEditorScreen(deckId: deck.id),
        ),
      ],
    );
    addTearDown(router.dispose);

    await pumpApp(tester, testRouterApp(router, db));
    router.push('/card');
    await settleApp(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Add card'));
    await settleApp(tester);

    expect(find.text('Enter the front of the card.'), findsOneWidget);
    expect(find.text('Enter the back of the card.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Mitochondria');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Powerhouse of the cell',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Add card'));
    await settleApp(tester);

    final cards = await DriftFlashcardRepository(db.flashcardDao)
        .getFlashcardsByDeck(deck.id);
    expect(cards, hasLength(1));
    expect(cards.single.front, 'Mitochondria');
    expect(cards.single.back, 'Powerhouse of the cell');
    expect(find.text('home'), findsOneWidget);

    await disposeApp(tester);
  });
}
