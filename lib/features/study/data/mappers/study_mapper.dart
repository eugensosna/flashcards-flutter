import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/study_dao.dart';
import '../../../flashcards/data/mappers/flashcard_mapper.dart';
import '../../domain/entities/study_card.dart';
import '../../domain/entities/study_progress.dart';

StudyProgress mapStudyProgressRow(StudyProgressRow row) {
  return StudyProgress(
    id: row.id,
    flashcardId: row.flashcardId,
    repetitions: row.repetitions,
    interval: row.interval,
    easeFactor: row.easeFactor,
    dueDate: row.dueDate,
    lastReviewedAt: row.lastReviewedAt,
    reviewCount: row.reviewCount,
  );
}

StudyCard mapDueCard(DueCardData data) {
  return StudyCard(
    card: mapFlashcardRow(data.card),
    progress: data.progress == null
        ? null
        : mapStudyProgressRow(data.progress!),
  );
}
