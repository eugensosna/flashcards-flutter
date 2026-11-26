import '../../../../core/utils/validators.dart';
import '../entities/deck.dart';
import '../repositories/deck_repository.dart';

/// Validates deck input before updating an existing deck.
class UpdateDeck {
  const UpdateDeck(this._repository);

  final DeckRepository _repository;

  Future<Deck> call({
    required int id,
    required String? name,
    String? description,
    String? color,
  }) {
    return _repository.updateDeck(
      id: id,
      name: Validators.requireDeckName(name),
      description: Validators.optionalText(description),
      color: Validators.optionalText(color),
    );
  }
}
