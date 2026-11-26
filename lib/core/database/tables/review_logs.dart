import 'package:drift/drift.dart';

import 'decks.dart';
import 'flashcards.dart';

/// History of individual ratings, used for daily and lifetime statistics.
///
/// `rating` stores [ReviewRating.index] so that the domain enum stays free of
/// database dependencies.
@DataClassName('ReviewLogRow')
@TableIndex(name: 'review_logs_reviewed_at_idx', columns: {#reviewedAt})
@TableIndex(name: 'review_logs_flashcard_id_idx', columns: {#flashcardId})
@TableIndex(name: 'review_logs_deck_id_idx', columns: {#deckId})
class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get flashcardId => integer().references(
    Flashcards,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  IntColumn get deckId => integer().references(
    Decks,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  IntColumn get rating => integer()();

  DateTimeColumn get reviewedAt => dateTime()();

  IntColumn get previousInterval => integer().withDefault(const Constant(0))();

  IntColumn get newInterval => integer().withDefault(const Constant(0))();
}
