import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/repositories/drift_flashcard_repository.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../../domain/usecases/create_flashcard_usecase.dart';
import '../../domain/usecases/flashcard_management_usecases.dart';
import '../../domain/usecases/update_flashcard_usecase.dart';

part 'flashcard_providers.g.dart';

@Riverpod(keepAlive: true)
FlashcardRepository flashcardRepository(Ref ref) {
  return DriftFlashcardRepository(ref.watch(appDatabaseProvider).flashcardDao);
}

@Riverpod(keepAlive: true)
CreateFlashcard createFlashcardUseCase(Ref ref) {
  return CreateFlashcard(ref.watch(flashcardRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateFlashcard updateFlashcardUseCase(Ref ref) {
  return UpdateFlashcard(ref.watch(flashcardRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteFlashcard deleteFlashcardUseCase(Ref ref) {
  return DeleteFlashcard(ref.watch(flashcardRepositoryProvider));
}

@Riverpod(keepAlive: true)
MoveFlashcard moveFlashcardUseCase(Ref ref) {
  return MoveFlashcard(ref.watch(flashcardRepositoryProvider));
}

@Riverpod(keepAlive: true)
ArchiveFlashcard archiveFlashcardUseCase(Ref ref) {
  return ArchiveFlashcard(ref.watch(flashcardRepositoryProvider));
}

@Riverpod(keepAlive: true)
ReorderFlashcards reorderFlashcardsUseCase(Ref ref) {
  return ReorderFlashcards(ref.watch(flashcardRepositoryProvider));
}

@riverpod
class FlashcardSearchController extends _$FlashcardSearchController {
  @override
  String build(int deckId) => '';

  void update(String value) => state = value;

  void clear() => state = '';
}

@riverpod
class ArchivedFilterController extends _$ArchivedFilterController {
  @override
  bool build(int deckId) => false;

  void toggle() => state = !state;
}

@riverpod
Stream<List<Flashcard>> flashcardsByDeck(Ref ref, int deckId) {
  final query = ref.watch(flashcardSearchControllerProvider(deckId));
  final includeArchived = ref.watch(archivedFilterControllerProvider(deckId));
  return ref
      .watch(flashcardRepositoryProvider)
      .watchFlashcardsByDeck(
        deckId,
        includeArchived: includeArchived,
        query: query,
      );
}

@riverpod
Stream<Flashcard?> flashcardById(Ref ref, int cardId) {
  return ref.watch(flashcardRepositoryProvider).watchFlashcard(cardId);
}

@riverpod
Future<Flashcard?> flashcardForEditing(Ref ref, int cardId) {
  return ref.watch(flashcardRepositoryProvider).getFlashcard(cardId);
}

@Riverpod(keepAlive: true)
class FlashcardEditorController extends _$FlashcardEditorController {
  @override
  Future<void> build() async {}

  Future<Flashcard?> save({
    int? cardId,
    required int deckId,
    required String front,
    required String back,
  }) async {
    state = const AsyncLoading();
    try {
      final card = cardId == null
          ? await ref.read(createFlashcardUseCaseProvider)(
              deckId: deckId,
              front: front,
              back: back,
            )
          : await ref.read(updateFlashcardUseCaseProvider)(
              id: cardId,
              deckId: deckId,
              front: front,
              back: back,
            );
      state = const AsyncData(null);
      return card;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}

/// Delete, archive, move and reorder operations for a card list.
@Riverpod(keepAlive: true)
class FlashcardActionsController extends _$FlashcardActionsController {
  @override
  Future<void> build() async {}

  Future<bool> delete(int cardId) {
    return _run(() => ref.read(deleteFlashcardUseCaseProvider)(cardId));
  }

  Future<bool> setArchived({required int cardId, required bool archived}) {
    return _run(
      () => ref.read(archiveFlashcardUseCaseProvider)(
        cardId: cardId,
        archived: archived,
      ),
    );
  }

  Future<bool> move({required int cardId, required int targetDeckId}) {
    return _run(
      () => ref.read(moveFlashcardUseCaseProvider)(
        cardId: cardId,
        targetDeckId: targetDeckId,
      ),
    );
  }

  Future<bool> reorder({
    required int deckId,
    required List<int> orderedCardIds,
  }) {
    return _run(
      () => ref.read(reorderFlashcardsUseCaseProvider)(
        deckId: deckId,
        orderedCardIds: orderedCardIds,
      ),
    );
  }

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
