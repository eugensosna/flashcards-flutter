import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard.freezed.dart';

/// A single question/answer pair.
@freezed
abstract class Flashcard with _$Flashcard {
  const factory Flashcard({
    required int id,
    required int deckId,
    required String front,
    required String back,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int position,
    @Default(false) bool isArchived,
  }) = _Flashcard;

  const Flashcard._();

  /// A short preview used in list tiles.
  String get preview =>
      front.length <= 80 ? front : '${front.substring(0, 80)}…';
}
