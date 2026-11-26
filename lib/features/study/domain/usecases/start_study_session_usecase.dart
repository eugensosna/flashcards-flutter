import '../entities/study_card.dart';
import '../repositories/study_repository.dart';

/// Loads the cards that are due for a deck.
class StartStudySession {
  const StartStudySession(this._repository);

  final StudyRepository _repository;

  Future<List<StudyCard>> call(int deckId) {
    return _repository.getDueFlashcards(deckId: deckId);
  }
}

/// Loads every card of a deck, ignoring the due date (practice mode).
class LoadPracticeSession {
  const LoadPracticeSession(this._repository);

  final StudyRepository _repository;

  Future<List<StudyCard>> call(int deckId) {
    return _repository.getAllStudyCards(deckId);
  }
}
