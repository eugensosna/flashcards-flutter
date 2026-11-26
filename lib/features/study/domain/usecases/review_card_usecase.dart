import '../algorithms/sm2_scheduler.dart';
import '../entities/review_rating.dart';
import '../entities/study_card.dart';
import '../entities/study_progress.dart';
import '../repositories/study_repository.dart';

/// Applies SM-2 to a card and persists the resulting schedule.
class ReviewCard {
  const ReviewCard(this._repository, {this.scheduler = const Sm2Scheduler()});

  final StudyRepository _repository;
  final Sm2Scheduler scheduler;

  Future<StudyProgress> call({
    required StudyCard card,
    required ReviewRating rating,
    DateTime? reviewedAt,
  }) {
    final now = reviewedAt ?? DateTime.now();
    final previous = card.progress;
    final schedule = scheduler.schedule(
      rating: rating,
      repetitions: previous?.repetitions ?? 0,
      easeFactor: previous?.easeFactor ?? scheduler.initialEaseFactor,
      interval: previous?.interval ?? 0,
      reviewedAt: now,
    );

    return _repository.saveReview(
      deckId: card.card.deckId,
      card: card,
      rating: rating,
      schedule: schedule,
      reviewedAt: now,
    );
  }
}
