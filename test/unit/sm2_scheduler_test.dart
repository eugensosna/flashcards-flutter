import 'package:flashcards/features/study/domain/algorithms/sm2_scheduler.dart';
import 'package:flashcards/features/study/domain/entities/review_rating.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const scheduler = Sm2Scheduler();
  final reviewedAt = DateTime(2026, 3, 10, 21, 45);

  group('interval progression', () {
    test('first successful review schedules the card for tomorrow', () {
      final result = scheduler.schedule(
        rating: ReviewRating.good,
        repetitions: 0,
        easeFactor: 2.5,
        interval: 0,
        reviewedAt: reviewedAt,
      );

      expect(result.repetitions, 1);
      expect(result.interval, 1);
      expect(result.dueDate, DateTime(2026, 3, 11));
    });

    test('second successful review graduates to six days', () {
      final result = scheduler.schedule(
        rating: ReviewRating.good,
        repetitions: 1,
        easeFactor: 2.5,
        interval: 1,
        reviewedAt: reviewedAt,
      );

      expect(result.repetitions, 2);
      expect(result.interval, 6);
      expect(result.dueDate, DateTime(2026, 3, 16));
    });

    test('later reviews multiply the interval by the ease factor', () {
      final result = scheduler.schedule(
        rating: ReviewRating.good,
        repetitions: 2,
        easeFactor: 2.5,
        interval: 6,
        reviewedAt: reviewedAt,
      );

      expect(result.repetitions, 3);
      expect(result.interval, 15);
    });
  });

  group('ease factor', () {
    test('stays unchanged for a good answer', () {
      final result = scheduler.schedule(
        rating: ReviewRating.good,
        repetitions: 0,
        easeFactor: 2.5,
        interval: 0,
        reviewedAt: reviewedAt,
      );

      expect(result.easeFactor, closeTo(2.5, 0.0001));
    });

    test('increases for an easy answer', () {
      final result = scheduler.schedule(
        rating: ReviewRating.easy,
        repetitions: 0,
        easeFactor: 2.5,
        interval: 0,
        reviewedAt: reviewedAt,
      );

      expect(result.easeFactor, closeTo(2.6, 0.0001));
    });

    test('decreases for a hard answer', () {
      final result = scheduler.schedule(
        rating: ReviewRating.hard,
        repetitions: 0,
        easeFactor: 2.5,
        interval: 0,
        reviewedAt: reviewedAt,
      );

      expect(result.easeFactor, closeTo(2.36, 0.0001));
    });

    test('never drops below the minimum of 1.3', () {
      final result = scheduler.schedule(
        rating: ReviewRating.again,
        repetitions: 4,
        easeFactor: 1.4,
        interval: 30,
        reviewedAt: reviewedAt,
      );

      expect(result.easeFactor, 1.3);
    });
  });

  group('failed recall', () {
    test('resets repetitions and schedules the next day', () {
      final result = scheduler.schedule(
        rating: ReviewRating.again,
        repetitions: 5,
        easeFactor: 2.5,
        interval: 120,
        reviewedAt: reviewedAt,
      );

      expect(result.repetitions, 0);
      expect(result.interval, 1);
      expect(result.dueDate, DateTime(2026, 3, 11));
    });

    test('hard still counts as a successful recall', () {
      final result = scheduler.schedule(
        rating: ReviewRating.hard,
        repetitions: 2,
        easeFactor: 2.5,
        interval: 6,
        reviewedAt: reviewedAt,
      );

      expect(result.repetitions, 3);
      expect(result.interval, greaterThanOrEqualTo(1));
    });
  });

  test('due dates are normalised to midnight', () {
    final result = scheduler.schedule(
      rating: ReviewRating.easy,
      repetitions: 0,
      easeFactor: 2.5,
      interval: 0,
      reviewedAt: DateTime(2026, 3, 10, 23, 59, 59),
    );

    expect(result.dueDate.hour, 0);
    expect(result.dueDate.minute, 0);
    expect(result.dueDate.day, 11);
  });
}
