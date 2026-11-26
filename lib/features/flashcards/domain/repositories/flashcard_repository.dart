import '../entities/flashcard.dart';

/// Persistence contract for flashcards.
abstract interface class FlashcardRepository {
  Stream<List<Flashcard>> watchFlashcardsByDeck(
    int deckId, {
    bool includeArchived = false,
    String query = '',
  });

  Future<List<Flashcard>> getFlashcardsByDeck(
    int deckId, {
    bool includeArchived = false,
  });

  Stream<Flashcard?> watchFlashcard(int cardId);

  Future<Flashcard?> getFlashcard(int cardId);

  Future<Flashcard> createFlashcard({
    required int deckId,
    required String front,
    required String back,
  });

  Future<Flashcard> updateFlashcard({
    required int id,
    required int deckId,
    required String front,
    required String back,
  });

  Future<void> deleteFlashcard(int cardId);

  Future<void> moveFlashcard({required int cardId, required int targetDeckId});

  Future<void> setArchived({required int cardId, required bool archived});

  Future<void> reorderFlashcards({
    required int deckId,
    required List<int> orderedCardIds,
  });
}
