import '../repositories/flashcard_repository.dart';

class DeleteFlashcard {
  const DeleteFlashcard(this._repository);

  final FlashcardRepository _repository;

  Future<void> call(int cardId) => _repository.deleteFlashcard(cardId);
}

class MoveFlashcard {
  const MoveFlashcard(this._repository);

  final FlashcardRepository _repository;

  Future<void> call({required int cardId, required int targetDeckId}) {
    return _repository.moveFlashcard(
      cardId: cardId,
      targetDeckId: targetDeckId,
    );
  }
}

class ArchiveFlashcard {
  const ArchiveFlashcard(this._repository);

  final FlashcardRepository _repository;

  Future<void> call({required int cardId, required bool archived}) {
    return _repository.setArchived(cardId: cardId, archived: archived);
  }
}

class ReorderFlashcards {
  const ReorderFlashcards(this._repository);

  final FlashcardRepository _repository;

  Future<void> call({required int deckId, required List<int> orderedCardIds}) {
    return _repository.reorderFlashcards(
      deckId: deckId,
      orderedCardIds: orderedCardIds,
    );
  }
}
