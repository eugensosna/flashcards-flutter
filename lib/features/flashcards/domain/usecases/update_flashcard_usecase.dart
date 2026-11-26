import '../../../../core/utils/validators.dart';
import '../entities/flashcard.dart';
import '../repositories/flashcard_repository.dart';

/// Validates card content before saving changes.
class UpdateFlashcard {
  const UpdateFlashcard(this._repository);

  final FlashcardRepository _repository;

  Future<Flashcard> call({
    required int id,
    required int deckId,
    required String? front,
    required String? back,
  }) {
    return _repository.updateFlashcard(
      id: id,
      deckId: deckId,
      front: Validators.requireCardContent(front, label: 'front'),
      back: Validators.requireCardContent(back, label: 'back'),
    );
  }
}
