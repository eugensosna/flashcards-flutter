import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../decks/domain/entities/deck_summary.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.goNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorStateView(
          error: error,
          onRetry: () => ref.invalidate(dashboardStatsProvider),
        ),
        data: (data) => _DashboardBody(stats: data),
      ),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(nextStudyDeckProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 900 ? 900.0 : null;
        final columns = constraints.maxWidth >= 720 ? 4 : 2;
        const gap = 12.0;
        final available = (contentWidth ?? constraints.maxWidth) - 32;
        final cardWidth = (available - gap * (columns - 1)) / columns;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contentWidth ?? double.infinity,
            ),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _StudyNowCard(target: target, dueCards: stats.dueCards),
                const SizedBox(height: 16),
                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: StatCard(
                        label: 'Decks',
                        value: '${stats.totalDecks}',
                        icon: Icons.style_outlined,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: StatCard(
                        label: 'Flashcards',
                        value: '${stats.totalFlashcards}',
                        icon: Icons.copy_all_outlined,
                        accent: AppColors.easy,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: StatCard(
                        label: 'Due now',
                        value: '${stats.dueCards}',
                        icon: Icons.schedule_outlined,
                        accent: AppColors.hard,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: StatCard(
                        label: 'Studied today',
                        value: '${stats.studiedToday}',
                        icon: Icons.local_fire_department_outlined,
                        accent: AppColors.good,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Recent decks',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(AppRoutes.decks),
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (stats.recentDecks.isEmpty)
                  const _NoDecksHint()
                else
                  for (final summary in stats.recentDecks)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _RecentDeckTile(summary: summary),
                    ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StudyNowCard extends StatelessWidget {
  const _StudyNowCard({required this.target, required this.dueCards});

  final DeckSummary? target;
  final int dueCards;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final deck = target;

    return Card(
      color: colors.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bolt, color: colors.onPrimaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dueCards > 0 ? 'Ready to study' : 'All caught up',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              dueCards > 0
                  ? '$dueCards ${dueCards == 1 ? 'card is' : 'cards are'} due '
                        'for review.'
                  : 'There are no cards due right now. Add more cards or come '
                        'back later.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: deck == null
                      ? null
                      : () => context.pushNamed(
                          AppRoutes.deckStudy,
                          pathParameters: {'deckId': '${deck.deck.id}'},
                        ),
                  icon: const Icon(Icons.play_arrow),
                  label: Text(
                    deck == null
                        ? 'Nothing due now'
                        : 'Study ${deck.deck.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () => context.goNamed(AppRoutes.decks),
                  child: const Text('Browse decks'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentDeckTile extends StatelessWidget {
  const _RecentDeckTile({required this.summary});

  final DeckSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent =
        AppColors.parseHex(summary.deck.color) ?? theme.colorScheme.primary;

    return Card(
      child: ListTile(
        onTap: () => context.pushNamed(
          AppRoutes.deckDetail,
          pathParameters: {'deckId': '${summary.deck.id}'},
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.style_outlined, color: accent, size: 20),
        ),
        title: Text(
          summary.deck.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${summary.cardCount} '
          '${summary.cardCount == 1 ? 'card' : 'cards'}'
          '${summary.hasDueCards ? ' · ${summary.dueCount} due' : ''}',
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _NoDecksHint extends StatelessWidget {
  const _NoDecksHint();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No decks yet', style: theme.textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              'Create a deck to start building your collection.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () => context.pushNamed(AppRoutes.deckCreate),
              child: const Text('Create a deck'),
            ),
          ],
        ),
      ),
    );
  }
}
