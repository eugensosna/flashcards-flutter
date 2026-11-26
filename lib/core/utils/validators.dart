import '../constants/app_constants.dart';
import '../errors/app_exception.dart';

/// Validation rules shared by form fields and domain use cases.
abstract final class Validators {
  /// Returns an error message for a deck name, or `null` when valid.
  static String? deckName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Enter a deck name.';
    }
    if (text.length > AppConstants.deckNameMaxLength) {
      return 'Use at most ${AppConstants.deckNameMaxLength} characters.';
    }
    return null;
  }

  /// Returns an error message for flashcard content, or `null` when valid.
  static String? cardContent(String? value, {required String label}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Enter the $label of the card.';
    }
    if (text.length > AppConstants.cardContentMaxLength) {
      return 'Use at most ${AppConstants.cardContentMaxLength} characters.';
    }
    return null;
  }

  /// Trims [value] and throws when the deck name is invalid.
  static String requireDeckName(String? value) {
    final error = deckName(value);
    if (error != null) {
      throw ValidationException(error);
    }
    return value!.trim();
  }

  /// Trims [value] and throws when the card content is invalid.
  static String requireCardContent(String? value, {required String label}) {
    final error = cardContent(value, label: label);
    if (error != null) {
      throw ValidationException(error);
    }
    return value!.trim();
  }

  /// Normalises optional text: blank input becomes `null`.
  static String? optionalText(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
