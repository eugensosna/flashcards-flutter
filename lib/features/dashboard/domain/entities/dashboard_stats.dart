import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../decks/domain/entities/deck_summary.dart';

part 'dashboard_stats.freezed.dart';

/// Everything the dashboard shows at a glance.
@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required int totalDecks,
    required int totalFlashcards,
    required int dueCards,
    required int studiedToday,
    @Default(<DeckSummary>[]) List<DeckSummary> recentDecks,
  }) = _DashboardStats;
}
