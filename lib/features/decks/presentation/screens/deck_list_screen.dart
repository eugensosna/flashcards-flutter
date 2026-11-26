import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../../shared/widgets/search_field.dart';
import '../../domain/entities/deck_sort.dart';
import '../../domain/entities/deck_summary.dart';
import '../providers/deck_providers.dart';
import '../widgets/deck_tile.dart';

class DeckListScreen extends ConsumerWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(deckListProvider);
    final sort = ref.watch(deckSortControllerProvider);
    final query = ref.watch(deckSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
        actions: [
          PopupMenuButton<DeckSort>(
            tooltip: 'Sort decks',
            icon: const Icon(Icons.sort),
            initialValue: sort,
            onSelected: ref.read(deckSortControllerProvider.notifier).select,
            itemBuilder: (context) => [
              for (final option in DeckSort.values)
                CheckedPopupMenuItem(
                  value: option,
                  checked: option == sort,
                  child: Text(option.label),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.deckCreate),
        icon: const Icon(Icons.add),
        label: const Text('New deck'),
        tooltip: 'Create a deck',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SearchField(
              hintText: 'Search decks',
              initialValue: query,
              onChanged: ref.read(deckSearchControllerProvider.notifier).update,
            ),
          ),
          Expanded(
            child: decks.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorStateView(
                error: error,
                onRetry: () => ref.invalidate(deckListProvider),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return query.trim().isEmpty
                      ? EmptyState(
                          icon: Icons.style_outlined,
                          title: 'No decks yet',
                          message:
                              'Create your first deck to start collecting '
                              'flashcards.',
                          actionLabel: 'Create a deck',
                          onAction: () =>
                              context.pushNamed(AppRoutes.deckCreate),
                        )
                      : EmptyState(
                          icon: Icons.search_off,
                          title: 'No matching decks',
                          message: 'Nothing matches "$query".',
                          actionLabel: 'Clear search',
                          onAction: () => ref
                              .read(deckSearchControllerProvider.notifier)
                              .clear(),
                        );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final summary = items[index];
                    return DeckTile(
                      summary: summary,
                      onTap: () => _openDeck(context, summary),
                      onEdit: () => context.pushNamed(
                        AppRoutes.deckEdit,
                        pathParameters: {'deckId': '${summary.deck.id}'},
                      ),
                      onStudy: () => context.pushNamed(
                        AppRoutes.deckStudy,
                        pathParameters: {'deckId': '${summary.deck.id}'},
                      ),
                      onDelete: () => _deleteDeck(context, ref, summary),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openDeck(BuildContext context, DeckSummary summary) {
    context.pushNamed(
      AppRoutes.deckDetail,
      pathParameters: {'deckId': '${summary.deck.id}'},
    );
  }

  Future<void> _deleteDeck(
    BuildContext context,
    WidgetRef ref,
    DeckSummary summary,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete deck?',
      message:
          '"${summary.deck.name}" and its ${summary.cardCount} '
          '${summary.cardCount == 1 ? 'card' : 'cards'} will be permanently '
          'deleted.',
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    final success = await ref
        .read(deckActionsControllerProvider.notifier)
        .delete(summary.deck.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Deck deleted.' : 'The deck could not be deleted.',
        ),
      ),
    );
  }
}

extension on DeckSort {
  String get label => switch (this) {
    DeckSort.nameAsc => 'Name (A-Z)',
    DeckSort.nameDesc => 'Name (Z-A)',
    DeckSort.createdAtNewest => 'Newest first',
    DeckSort.createdAtOldest => 'Oldest first',
  };
}
