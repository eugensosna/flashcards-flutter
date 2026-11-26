import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../../shared/widgets/search_field.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_providers.dart';
import '../../domain/entities/deck_summary.dart';
import '../providers/deck_providers.dart';

class DeckDetailScreen extends ConsumerWidget {
  const DeckDetailScreen({super.key, required this.deckId});

  final int deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(deckDetailsProvider(deckId));

    return summary.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorStateView(
          error: error,
          onRetry: () => ref.invalidate(deckDetailsProvider(deckId)),
        ),
      ),
      data: (value) {
        if (value == null) {
          return Scaffold(
            appBar: AppBar(),
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Deck not found',
              message: 'This deck may have been deleted.',
              actionLabel: 'Back to decks',
              onAction: () => context.goNamed(AppRoutes.decks),
            ),
          );
        }
        return _DeckDetailView(summary: value);
      },
    );
  }
}

class _DeckDetailView extends ConsumerWidget {
  const _DeckDetailView({required this.summary});

  final DeckSummary summary;

  int get _deckId => summary.deck.id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(flashcardsByDeckProvider(_deckId));
    final query = ref.watch(flashcardSearchControllerProvider(_deckId));
    final includeArchived = ref.watch(
      archivedFilterControllerProvider(_deckId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(summary.deck.name),
        actions: [
          IconButton(
            tooltip: 'Edit deck',
            onPressed: () => context.pushNamed(
              AppRoutes.deckEdit,
              pathParameters: {'deckId': '$_deckId'},
            ),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete deck',
            onPressed: () => _deleteDeck(context, ref),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          AppRoutes.cardCreate,
          pathParameters: {'deckId': '$_deckId'},
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add card'),
        tooltip: 'Add a flashcard',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: _DeckHeader(
              summary: summary,
              onStudy: () => context.pushNamed(
                AppRoutes.deckStudy,
                pathParameters: {'deckId': '$_deckId'},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    hintText: 'Search cards',
                    initialValue: query,
                    onChanged: ref
                        .read(
                          flashcardSearchControllerProvider(_deckId).notifier,
                        )
                        .update,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Archived'),
                  selected: includeArchived,
                  onSelected: (_) => ref
                      .read(archivedFilterControllerProvider(_deckId).notifier)
                      .toggle(),
                ),
              ],
            ),
          ),
          Expanded(
            child: cards.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorStateView(
                error: error,
                onRetry: () =>
                    ref.invalidate(flashcardsByDeckProvider(_deckId)),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: query.trim().isEmpty
                        ? Icons.note_add_outlined
                        : Icons.search_off,
                    title: query.trim().isEmpty
                        ? 'No cards in this deck'
                        : 'No matching cards',
                    message: query.trim().isEmpty
                        ? 'Add your first flashcard to start studying.'
                        : 'Nothing matches "$query".',
                    actionLabel: query.trim().isEmpty ? 'Add a card' : null,
                    onAction: query.trim().isEmpty
                        ? () => context.pushNamed(
                            AppRoutes.cardCreate,
                            pathParameters: {'deckId': '$_deckId'},
                          )
                        : null,
                  );
                }

                final canReorder = query.trim().isEmpty && !includeArchived;
                if (!canReorder) {
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                    itemCount: items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildTile(
                        context,
                        ref,
                        items[index],
                        index,
                        reorderable: false,
                      ),
                    ),
                  );
                }

                return ReorderableListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  buildDefaultDragHandles: false,
                  itemCount: items.length,
                  onReorderItem: (oldIndex, newIndex) =>
                      _reorder(ref, items, oldIndex, newIndex),
                  itemBuilder: (context, index) => Padding(
                    key: ValueKey(items[index].id),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildTile(
                      context,
                      ref,
                      items[index],
                      index,
                      reorderable: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    WidgetRef ref,
    Flashcard card,
    int index, {
    required bool reorderable,
  }) {
    return _FlashcardTile(
      card: card,
      index: index,
      showDragHandle: reorderable,
      onEdit: () => context.pushNamed(
        AppRoutes.cardEdit,
        pathParameters: {'deckId': '$_deckId', 'cardId': '${card.id}'},
      ),
      onMove: () => _moveCard(context, ref, card),
      onToggleArchive: () => _toggleArchive(context, ref, card),
      onDelete: () => _deleteCard(context, ref, card),
    );
  }

  void _reorder(
    WidgetRef ref,
    List<Flashcard> items,
    int oldIndex,
    int newIndex,
  ) {
    final ids = items.map((card) => card.id).toList();
    final moved = ids.removeAt(oldIndex);
    ids.insert(newIndex, moved);
    unawaited(
      ref
          .read(flashcardActionsControllerProvider.notifier)
          .reorder(deckId: _deckId, orderedCardIds: ids),
    );
  }

  Future<void> _deleteDeck(BuildContext context, WidgetRef ref) async {
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
        .delete(_deckId);
    if (!context.mounted) {
      return;
    }
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The deck could not be deleted.')),
      );
      return;
    }
    context.goNamed(AppRoutes.decks);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Deck deleted.')));
  }

  Future<void> _deleteCard(
    BuildContext context,
    WidgetRef ref,
    Flashcard card,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete card?',
      message: 'This card and its study progress will be permanently deleted.',
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    final success = await ref
        .read(flashcardActionsControllerProvider.notifier)
        .delete(card.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Card deleted.' : 'The card could not be deleted.',
        ),
      ),
    );
  }

  Future<void> _toggleArchive(
    BuildContext context,
    WidgetRef ref,
    Flashcard card,
  ) async {
    final archive = !card.isArchived;
    final success = await ref
        .read(flashcardActionsControllerProvider.notifier)
        .setArchived(cardId: card.id, archived: archive);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (archive ? 'Card archived.' : 'Card restored.')
              : 'The card could not be updated.',
        ),
      ),
    );
  }

  Future<void> _moveCard(
    BuildContext context,
    WidgetRef ref,
    Flashcard card,
  ) async {
    final targetDeckId = await showDialog<int>(
      context: context,
      builder: (dialogContext) => _MoveCardDialog(currentDeckId: _deckId),
    );
    if (targetDeckId == null || !context.mounted) {
      return;
    }

    final success = await ref
        .read(flashcardActionsControllerProvider.notifier)
        .move(cardId: card.id, targetDeckId: targetDeckId);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Card moved.' : 'The card could not be moved.'),
      ),
    );
  }
}

class _DeckHeader extends StatelessWidget {
  const _DeckHeader({required this.summary, required this.onStudy});

  final DeckSummary summary;
  final VoidCallback onStudy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent =
        AppColors.parseHex(summary.deck.color) ?? theme.colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (summary.deck.hasDescription) ...[
              Text(
                summary.deck.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${Formatters.cards(summary.cardCount)} · '
                    '${summary.dueCount} due',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: summary.isEmpty ? null : onStudy,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Study'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashcardTile extends StatelessWidget {
  const _FlashcardTile({
    required this.card,
    required this.index,
    required this.showDragHandle,
    required this.onEdit,
    required this.onMove,
    required this.onToggleArchive,
    required this.onDelete,
  });

  final Flashcard card;
  final int index;
  final bool showDragHandle;
  final VoidCallback onEdit;
  final VoidCallback onMove;
  final VoidCallback onToggleArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (card.isArchived) ...[
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          card.front,
                          style: theme.textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.back,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showDragHandle)
              ReorderableDragStartListener(
                index: index,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.drag_indicator),
                ),
              ),
            PopupMenuButton<_CardAction>(
              tooltip: 'Card actions',
              onSelected: (action) {
                switch (action) {
                  case _CardAction.edit:
                    onEdit();
                  case _CardAction.move:
                    onMove();
                  case _CardAction.archive:
                    onToggleArchive();
                  case _CardAction.delete:
                    onDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: _CardAction.edit,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit card'),
                  ),
                ),
                const PopupMenuItem(
                  value: _CardAction.move,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.drive_file_move_outline),
                    title: Text('Move to deck'),
                  ),
                ),
                PopupMenuItem(
                  value: _CardAction.archive,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      card.isArchived
                          ? Icons.unarchive_outlined
                          : Icons.archive_outlined,
                    ),
                    title: Text(card.isArchived ? 'Unarchive' : 'Archive'),
                  ),
                ),
                const PopupMenuItem(
                  value: _CardAction.delete,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.delete_outline),
                    title: Text('Delete card'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _CardAction { edit, move, archive, delete }

class _MoveCardDialog extends ConsumerWidget {
  const _MoveCardDialog({required this.currentDeckId});

  final int currentDeckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(allDecksProvider);

    return AlertDialog(
      title: const Text('Move to deck'),
      content: SizedBox(
        width: 320,
        child: decks.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => ErrorStateView(
            error: error,
            compact: true,
            onRetry: () => ref.invalidate(allDecksProvider),
          ),
          data: (items) {
            final targets = items
                .where((deck) => deck.id != currentDeckId)
                .toList();
            if (targets.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Create another deck first.'),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: [
                for (final deck in targets)
                  ListTile(
                    leading: const Icon(Icons.style_outlined),
                    title: Text(deck.name),
                    onTap: () => Navigator.of(context).pop(deck.id),
                  ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
