import '../entities/review_rating.dart';

/// Result of applying the SM-2 algorithm to a single answer.
class Sm2Result {
  const Sm2Result({
    required this.repetitions,
    required this.interval,
    required this.easeFactor,
    required this.dueDate,
  });

  final int repetitions;
  final int interval;
  final double easeFactor;
  final DateTime dueDate;

  @override
  String toString() =>
      'Sm2Result(repetitions: $repetitions, interval: $interval, '
      'easeFactor: $easeFactor, dueDate: $dueDate)';
}

/// SuperMemo 2 scheduling, kept free of Flutter and Drift.
///
/// Implementation notes:
/// * The four ratings map to SM-2 qualities `0, 3, 4, 5`.
/// * The ease factor is adjusted after every answer with
///   `EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))` and clamped to
///   [minimumEaseFactor].
/// * A failed recall (`q < 3`) resets the repetition count and schedules the
///   card for the next day.
/// * Successful recalls use intervals of 1 day, 6 days and then
///   `previous interval * ease factor`.
/// * Due dates are normalised to midnight so that "due today" is stable
///   regardless of the time a session happened.
class Sm2Scheduler {
  const Sm2Scheduler({
    this.minimumEaseFactor = 1.3,
    this.initialEaseFactor = 2.5,
    this.graduatingIntervalDays = 6,
  });

  final double minimumEaseFactor;
  final double initialEaseFactor;
  final int graduatingIntervalDays;

  Sm2Result schedule({
    required ReviewRating rating,
    required int repetitions,
    required double easeFactor,
    required int interval,
    required DateTime reviewedAt,
  }) {
    final quality = rating.quality;
    final nextEase = _nextEaseFactor(easeFactor, quality);
    final baseDate = DateTime(
      reviewedAt.year,
      reviewedAt.month,
      reviewedAt.day,
    );

    if (!rating.isSuccessful) {
      const relearnInterval = 1;
      return Sm2Result(
        repetitions: 0,
        interval: relearnInterval,
        easeFactor: nextEase,
        dueDate: baseDate.add(const Duration(days: relearnInterval)),
      );
    }

    final nextRepetitions = repetitions + 1;
    final int nextInterval;
    if (nextRepetitions == 1) {
      nextInterval = 1;
    } else if (nextRepetitions == 2) {
      nextInterval = graduatingIntervalDays;
    } else {
      final grown = (interval * nextEase).round();
      nextInterval = grown < 1 ? 1 : grown;
    }

    return Sm2Result(
      repetitions: nextRepetitions,
      interval: nextInterval,
      easeFactor: nextEase,
      dueDate: baseDate.add(Duration(days: nextInterval)),
    );
  }

  double _nextEaseFactor(double current, int quality) {
    final delta = 5 - quality;
    final adjusted = current + (0.1 - delta * (0.08 + delta * 0.02));
    return adjusted < minimumEaseFactor ? minimumEaseFactor : adjusted;
  }
}
