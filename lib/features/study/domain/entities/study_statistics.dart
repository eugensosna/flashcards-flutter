import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_statistics.freezed.dart';

/// Number of reviews on a single day.
@freezed
abstract class DailyReviewCount with _$DailyReviewCount {
  const factory DailyReviewCount({required DateTime day, required int count}) =
      _DailyReviewCount;
}

/// Aggregated numbers for the statistics screen.
@freezed
abstract class StudyStatistics with _$StudyStatistics {
  const factory StudyStatistics({
    required int totalCards,
    required int dueCards,
    required int newCards,
    required int matureCards,
    required int reviewsToday,
    required int studiedToday,
    required int totalReviews,
    required double averageEaseFactor,
    @Default(<DailyReviewCount>[]) List<DailyReviewCount> history,
  }) = _StudyStatistics;

  const StudyStatistics._();

  int get maxHistoryCount => history.fold(
    0,
    (previous, entry) => entry.count > previous ? entry.count : previous,
  );
}
