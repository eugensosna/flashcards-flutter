import '../../../../core/database/app_database.dart';
import '../../domain/entities/flashcard.dart';

Flashcard mapFlashcardRow(FlashcardRow row) {
  return Flashcard(
    id: row.id,
    deckId: row.deckId,
    front: row.front,
    back: row.back,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    position: row.position,
    isArchived: row.isArchived,
  );
}
