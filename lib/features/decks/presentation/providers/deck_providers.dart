import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/repositories/drift_deck_repository.dart';
import '../../domain/entities/deck.dart';
import '../../domain/entities/deck_sort.dart';
import '../../domain/entities/deck_summary.dart';
import '../../domain/repositories/deck_repository.dart';
import '../../domain/usecases/create_deck_usecase.dart';
import '../../domain/usecases/delete_deck_usecase.dart';
import '../../domain/usecases/update_deck_usecase.dart';

part 'deck_providers.g.dart';

@Riverpod(keepAlive: true)
DeckRepository deckRepository(Ref ref) {
  return DriftDeckRepository(ref.watch(appDatabaseProvider).deckDao);
}

@Riverpod(keepAlive: true)
CreateDeck createDeckUseCase(Ref ref) {
  return CreateDeck(ref.watch(deckRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateDeck updateDeckUseCase(Ref ref) {
  return UpdateDeck(ref.watch(deckRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteDeck deleteDeckUseCase(Ref ref) {
  return DeleteDeck(ref.watch(deckRepositoryProvider));
}

@riverpod
class DeckSortController extends _$DeckSortController {
  @override
  DeckSort build() => DeckSort.nameAsc;

  void select(DeckSort sort) => state = sort;
}

@riverpod
class DeckSearchController extends _$DeckSearchController {
  @override
  String build() => '';

  void update(String value) => state = value;

  void clear() => state = '';
}

/// Reactive list of decks, filtered and sorted by the controllers above.
@riverpod
Stream<List<DeckSummary>> deckList(Ref ref) {
  final repository = ref.watch(deckRepositoryProvider);
  final sort = ref.watch(deckSortControllerProvider);
  final query = ref.watch(deckSearchControllerProvider);
  return repository.watchAllDecks(sort: sort, query: query);
}

@riverpod
Stream<List<DeckSummary>> recentDecks(Ref ref) {
  return ref.watch(deckRepositoryProvider).watchRecentDecks();
}

@riverpod
Stream<DeckSummary?> deckDetails(Ref ref, int deckId) {
  return ref.watch(deckRepositoryProvider).watchDeck(deckId);
}

@riverpod
Future<Deck?> deckById(Ref ref, int deckId) {
  return ref.watch(deckRepositoryProvider).getDeck(deckId);
}

/// All decks as a one-shot future, used by pickers and dialogs.
@riverpod
Future<List<Deck>> allDecks(Ref ref) {
  return ref.watch(deckRepositoryProvider).getAllDecks();
}

/// Handles create/edit submissions and exposes their async state.
@Riverpod(keepAlive: true)
class DeckEditorController extends _$DeckEditorController {
  @override
  Future<void> build() async {}

  Future<Deck?> save({
    int? deckId,
    required String name,
    String? description,
    String? color,
  }) async {
    state = const AsyncLoading();
    try {
      final deck = deckId == null
          ? await ref.read(createDeckUseCaseProvider)(
              name: name,
              description: description,
              color: color,
            )
          : await ref.read(updateDeckUseCaseProvider)(
              id: deckId,
              name: name,
              description: description,
              color: color,
            );
      state = const AsyncData(null);
      return deck;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}

/// Destructive deck operations, kept separate from form state.
@Riverpod(keepAlive: true)
class DeckActionsController extends _$DeckActionsController {
  @override
  Future<void> build() async {}

  Future<bool> delete(int deckId) async {
    state = const AsyncLoading();
    try {
      await ref.read(deleteDeckUseCaseProvider)(deckId);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
