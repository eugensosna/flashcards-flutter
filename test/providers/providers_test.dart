import 'package:flashcards/core/errors/app_exception.dart';
import 'package:flashcards/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:flashcards/features/decks/domain/entities/deck_sort.dart';
import 'package:flashcards/features/decks/presentation/providers/deck_providers.dart';
import 'package:flashcards/features/flashcards/presentation/providers/flashcard_providers.dart';
import 'package:flashcards/features/settings/domain/entities/app_theme_mode.dart';
import 'package:flashcards/features/settings/presentation/providers/settings_providers.dart';
import 'package:flashcards/features/study/domain/entities/review_rating.dart';
import 'package:flashcards/features/study/presentation/providers/study_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/override.dart';
import '../helpers/test_database.dart';

void main() {
  group('deck providers', () {
    test('expose loading then data and react to mutations', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(deckListProvider, (_, _) {});
      addTearDown(subscription.close);

      expect(container.read(deckListProvider).isLoading, isTrue);
      expect(await container.read(deckListProvider.future), isEmpty);

      await container.read(createDeckUseCaseProvider)(name: 'First');

      await waitUntil(
        () => container.read(deckListProvider).value?.length == 1,
      );
      expect(container.read(deckListProvider).value!.single.deck.name, 'First');
    });

    test('sort and search controllers drive the deck list', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(deckListProvider, (_, _) {});
      addTearDown(subscription.close);

      await container.read(createDeckUseCaseProvider)(name: 'Banana');
      await container.read(createDeckUseCaseProvider)(name: 'apple');
      await waitUntil(
        () => container.read(deckListProvider).value?.length == 2,
      );

      container
          .read(deckSortControllerProvider.notifier)
          .select(DeckSort.nameDesc);
      await waitUntil(
        () =>
            container.read(deckListProvider).value?.first.deck.name == 'apple',
      );

      container.read(deckSearchControllerProvider.notifier).update('ban');
      await waitUntil(
        () => container.read(deckListProvider).value?.length == 1,
      );
      expect(
        container.read(deckListProvider).value!.single.deck.name,
        'Banana',
      );
    });

    test('deck editor controller reports validation errors', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);

      final controller = container.read(deckEditorControllerProvider.notifier);
      final created = await controller.save(name: '  Deck  ');
      expect(created, isNotNull);
      expect(created!.name, 'Deck');
      expect(container.read(deckEditorControllerProvider).hasError, isFalse);

      final invalid = await controller.save(name: '   ');
      expect(invalid, isNull);
      expect(
        container.read(deckEditorControllerProvider).error,
        isA<ValidationException>(),
      );
    });
  });

  group('dashboard providers', () {
    test('picks the deck with the most due cards', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(deckListProvider, (_, _) {});
      addTearDown(subscription.close);

      final big = await container.read(createDeckUseCaseProvider)(name: 'Big');
      final small = await container.read(createDeckUseCaseProvider)(
        name: 'Small',
      );
      final cards = container.read(flashcardRepositoryProvider);

      for (final front in ['a', 'b', 'c']) {
        await cards.createFlashcard(
          deckId: big.id,
          front: front,
          back: 'answer',
        );
      }
      await cards.createFlashcard(
        deckId: small.id,
        front: 'only',
        back: 'answer',
      );

      await waitUntil(
        () => container.read(nextStudyDeckProvider)?.deck.id == big.id,
      );
      expect(container.read(nextStudyDeckProvider)!.dueCount, 3);
    });
  });

  group('theme controller', () {
    test('loads system theme and persists changes', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);

      expect(
        await container.read(themeModeControllerProvider.future),
        AppThemeMode.system,
      );

      await container
          .read(themeModeControllerProvider.notifier)
          .setMode(AppThemeMode.dark);

      expect(
        container.read(themeModeControllerProvider).value,
        AppThemeMode.dark,
      );

      final secondContainer = createContainer(db);
      addTearDown(secondContainer.dispose);
      expect(
        await secondContainer.read(themeModeControllerProvider.future),
        AppThemeMode.dark,
      );
    });
  });

  group('study session controller', () {
    test('flips, rates and advances through the session', () async {
      final db = createTestDatabase();
      addTearDown(db.close);
      final container = createContainer(db);
      addTearDown(container.dispose);

      final deck = await container.read(createDeckUseCaseProvider)(
        name: 'Deck',
      );
      final cards = container.read(flashcardRepositoryProvider);
      await cards.createFlashcard(
        deckId: deck.id,
        front: 'first',
        back: 'answer',
      );
      await cards.createFlashcard(
        deckId: deck.id,
        front: 'second',
        back: 'answer',
      );

      final provider = studySessionControllerProvider(deck.id);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);
      final session = await container.read(provider.future);
      expect(session.total, 2);
      expect(session.isFlipped, isFalse);

      container.read(provider.notifier).flip();
      expect(container.read(provider).value!.isFlipped, isTrue);

      await container.read(provider.notifier).rate(ReviewRating.good);

      final advanced = container.read(provider).value!;
      expect(advanced.currentIndex, 1);
      expect(advanced.reviewedCount, 1);
      expect(advanced.isFlipped, isFalse);

      final progress = await container
          .read(studyRepositoryProvider)
          .getProgress(session.cards.first.card.id);
      expect(progress!.interval, 1);
    });
  });
}
