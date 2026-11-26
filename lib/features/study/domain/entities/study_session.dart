import 'package:freezed_annotation/freezed_annotation.dart';

import 'study_card.dart';

part 'study_session.freezed.dart';

/// Immutable snapshot of an in-progress study session.
@freezed
abstract class StudySession with _$StudySession {
  const factory StudySession({
    required int deckId,
    required List<StudyCard> cards,
    @Default(0) int currentIndex,
    @Default(false) bool isFlipped,
    @Default(0) int reviewedCount,
  }) = _StudySession;

  const StudySession._();

  bool get isEmpty => cards.isEmpty;

  bool get isFinished => isEmpty || currentIndex >= cards.length;

  StudyCard? get currentCard => isFinished ? null : cards[currentIndex];

  int get total => cards.length;

  /// Completion between 0 and 1.
  double get progress {
    if (isEmpty) {
      return 1;
    }
    return (currentIndex / cards.length).clamp(0.0, 1.0);
  }

  bool get canGoBack => currentIndex > 0 && !isFinished;

  bool get canGoForward => !isFinished && currentIndex < cards.length - 1;
}
