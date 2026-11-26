import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../../decks/domain/entities/deck_summary.dart';
import '../../../decks/presentation/providers/deck_providers.dart';
import '../../data/repositories/drift_dashboard_repository.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';

part 'dashboard_providers.g.dart';

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return DriftDashboardRepository(
    database: database,
    statsDao: database.statsDao,
    deckDao: database.deckDao,
  );
}

@riverpod
Stream<DashboardStats> dashboardStats(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).watchStats();
}

/// The deck with the most cards due, used by the dashboard quick action.
@riverpod
DeckSummary? nextStudyDeck(Ref ref) {
  final decks = ref.watch(deckListProvider).value ?? const <DeckSummary>[];
  DeckSummary? best;
  for (final deck in decks) {
    if (deck.dueCount == 0) {
      continue;
    }
    if (best == null || deck.dueCount > best.dueCount) {
      best = deck;
    }
  }
  return best;
}
