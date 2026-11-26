import 'package:freezed_annotation/freezed_annotation.dart';

import 'deck.dart';

part 'deck_summary.freezed.dart';

/// A deck bundled with the aggregates needed by lists and cards.
@freezed
abstract class DeckSummary with _$DeckSummary {
  const factory DeckSummary({
    required Deck deck,
    required int cardCount,
    required int dueCount,
  }) = _DeckSummary;

  const DeckSummary._();

  bool get isEmpty => cardCount == 0;

  bool get hasDueCards => dueCount > 0;

  /// Share of cards that are due, between 0 and 1.
  double get dueRatio {
    if (cardCount == 0) {
      return 0;
    }
    return (dueCount / cardCount).clamp(0, 1);
  }
}
