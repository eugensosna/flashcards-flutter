import '../algorithms/sm2_scheduler.dart';
import '../entities/review_rating.dart';
import '../entities/study_card.dart';
import '../entities/study_progress.dart';
import '../entities/study_statistics.dart';

/// Persistence contract for study sessions and spaced repetition data.
abstract interface class StudyRepository {
  Stream<List<StudyCard>> watchDueFlashcards({int? deckId});

  Future<List<StudyCard>> getDueFlashcards({int? deckId});

  /// All non-archived cards of [deckId], used for optional practice runs.
  Future<List<StudyCard>> getAllStudyCards(int deckId);

  Future<StudyProgress?> getProgress(int flashcardId);

  /// Stores the new scheduling state and the review history entry.
  Future<StudyProgress> saveReview({
    required int deckId,
    required StudyCard card,
    required ReviewRating rating,
    required Sm2Result schedule,
    required DateTime reviewedAt,
  });

  Future<StudyStatistics> getStatistics();

  Stream<StudyStatistics> watchStatistics();
}
