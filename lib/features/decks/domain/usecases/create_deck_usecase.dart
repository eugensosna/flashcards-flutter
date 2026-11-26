import '../../../../core/utils/validators.dart';
import '../entities/deck.dart';
import '../repositories/deck_repository.dart';

/// Validates deck input before handing it to the repository.
class CreateDeck {
  const CreateDeck(this._repository);

  final DeckRepository _repository;

  Future<Deck> call({
    required String? name,
    String? description,
    String? color,
  }) {
    return _repository.createDeck(
      name: Validators.requireDeckName(name),
      description: Validators.optionalText(description),
      color: Validators.optionalText(color),
    );
  }
}
