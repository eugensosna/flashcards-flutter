import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';

/// A deck as exposed to the domain layer.
@freezed
abstract class Deck with _$Deck {
  const factory Deck({
    required int id,
    required String name,
    String? description,
    String? color,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Deck;

  const Deck._();

  bool get hasDescription => (description?.isNotEmpty ?? false);
}
