import 'package:drift/drift.dart';

import 'flashcards.dart';

/// SM-2 scheduling state for a single flashcard.
///
/// There is at most one row per flashcard, enforced by a unique key.
@DataClassName('StudyProgressRow')
@TableIndex(name: 'study_progress_due_date_idx', columns: {#dueDate})
class StudyProgress extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get flashcardId => integer().references(
    Flashcards,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  /// Number of consecutive successful repetitions.
  IntColumn get repetitions => integer().withDefault(const Constant(0))();

  /// Current interval in days.
  IntColumn get interval => integer().withDefault(const Constant(0))();

  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();

  DateTimeColumn get dueDate => dateTime()();

  DateTimeColumn get lastReviewedAt => dateTime().nullable()();

  IntColumn get reviewCount => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {flashcardId},
  ];
}
