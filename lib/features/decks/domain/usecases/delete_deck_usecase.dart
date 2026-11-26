import '../repositories/deck_repository.dart';

/// Deletes a deck; flashcards and progress are removed by the database
/// cascade rules.
class DeleteDeck {
  const DeleteDeck(this._repository);

  final DeckRepository _repository;

  Future<void> call(int deckId) => _repository.deleteDeck(deckId);
}
