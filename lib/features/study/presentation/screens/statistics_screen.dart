import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/date_time_x.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../domain/entities/study_statistics.dart';
import '../providers/study_providers.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statistics = ref.watch(studyStatisticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: statistics.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorStateView(
          error: error,
          onRetry: () => ref.invalidate(studyStatisticsProvider),
        ),
        data: (data) => _StatisticsBody(statistics: data),
      ),
    );
  }
}

class _StatisticsBody extends StatelessWidget {
  const _StatisticsBody({required this.statistics});

  final StudyStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720 ? 3 : 2;
        const gap = 12.0;
        final cardWidth =
            (constraints.maxWidth - 32 - gap * (columns - 1)) / columns;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Today', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'Due now',
                    value: '${statistics.dueCards}',
                    icon: Icons.schedule_outlined,
                    accent: AppColors.hard,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'Studied today',
                    value: '${statistics.studiedToday}',
                    icon: Icons.local_fire_department_outlined,
                    accent: AppColors.good,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'Reviews today',
                    value: '${statistics.reviewsToday}',
                    icon: Icons.repeat,
                    accent: AppColors.easy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Collection', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'Flashcards',
                    value: '${statistics.totalCards}',
                    icon: Icons.copy_all_outlined,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'New cards',
                    value: '${statistics.newCards}',
                    icon: Icons.fiber_new_outlined,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    label: 'Mature cards',
                    value: '${statistics.matureCards}',
                    icon: Icons.workspace_premium_outlined,
                    accent: AppColors.good,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _HistoryCard(statistics: statistics),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.trending_up),
                title: const Text('Average ease factor'),
                subtitle: Text(
                  statistics.totalReviews == 0
                      ? 'No reviews yet'
                      : '${statistics.totalReviews} reviews recorded',
                ),
                trailing: Text(
                  statistics.averageEaseFactor == 0
                      ? '–'
                      : statistics.averageEaseFactor.toStringAsFixed(2),
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.statistics});

  final StudyStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxCount = statistics.maxHistoryCount;
    final today = DateTime.now().startOfDay;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reviews · last 7 days', style: theme.textTheme.titleSmall),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final entry in statistics.history)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${entry.count}',
                              style: theme.textTheme.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: maxCount == 0
                                  ? 4
                                  : 8 + 88 * (entry.count / maxCount),
                              decoration: BoxDecoration(
                                color: entry.day.isSameDayAs(today)
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.primary.withValues(
                                        alpha: 0.35,
                                      ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              Formatters.weekdayShort(entry.day),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
