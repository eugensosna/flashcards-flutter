import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../flashcards/domain/entities/flashcard.dart';
import 'study_progress.dart';

part 'study_card.freezed.dart';

/// A flashcard together with its scheduling state during a study session.
@freezed
abstract class StudyCard with _$StudyCard {
  const factory StudyCard({required Flashcard card, StudyProgress? progress}) =
      _StudyCard;

  const StudyCard._();

  bool get isNew => progress == null;
}
