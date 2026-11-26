import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_progress.freezed.dart';

/// Spaced repetition state of one flashcard.
@freezed
abstract class StudyProgress with _$StudyProgress {
  const factory StudyProgress({
    required int id,
    required int flashcardId,
    @Default(0) int repetitions,
    @Default(0) int interval,
    @Default(2.5) double easeFactor,
    required DateTime dueDate,
    DateTime? lastReviewedAt,
    @Default(0) int reviewCount,
  }) = _StudyProgress;

  const StudyProgress._();

  bool isDue(DateTime now) => !dueDate.isAfter(now);

  bool get isNew => reviewCount == 0;
}
