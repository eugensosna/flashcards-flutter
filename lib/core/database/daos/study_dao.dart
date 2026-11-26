import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/flashcards.dart';
import '../tables/review_logs.dart';
import '../tables/study_progress.dart';

part 'study_dao.g.dart';

/// A flashcard paired with its (optional) scheduling state.
class DueCardData {
  const DueCardData({required this.card, required this.progress});

  final FlashcardRow card;
  final StudyProgressRow? progress;
}

@DriftAccessor(tables: [Flashcards, StudyProgress, ReviewLogs])
class StudyDao extends DatabaseAccessor<AppDatabase> with _$StudyDaoMixin {
  StudyDao(super.db);

  Stream<List<DueCardData>> watchDueCards({int? deckId, DateTime? now}) {
    return _dueStatement(deckId: deckId, now: now).watch().map(_mapCards);
  }

  Future<List<DueCardData>> getDueCards({int? deckId, DateTime? now}) async {
    final rows = await _dueStatement(deckId: deckId, now: now).get();
    return _mapCards(rows);
  }

  Stream<int> watchDueCount({int? deckId, DateTime? now}) {
    final count = flashcards.id.count();
    final reference = now ?? DateTime.now();
    final statement = selectOnly(flashcards)..addColumns([count]);
    statement.join([
      leftOuterJoin(
        studyProgress,
        studyProgress.flashcardId.equalsExp(flashcards.id),
      ),
    ]);
    statement.where(flashcards.isArchived.equals(false));
    statement.where(
      studyProgress.id.isNull() |
          studyProgress.dueDate.isSmallerOrEqualValue(reference),
    );
    if (deckId != null) {
      statement.where(flashcards.deckId.equals(deckId));
    }
    return statement.map((row) => row.read(count) ?? 0).watchSingle();
  }

  /// Every non-archived card of [deckId], regardless of its due date.
  Future<List<DueCardData>> getAllCards(int deckId) async {
    final statement = select(flashcards).join([
      leftOuterJoin(
        studyProgress,
        studyProgress.flashcardId.equalsExp(flashcards.id),
      ),
    ])..where(flashcards.isArchived.equals(false));

    statement.where(flashcards.deckId.equals(deckId));
    statement.orderBy([
      OrderingTerm.asc(flashcards.position),
      OrderingTerm.asc(flashcards.id),
    ]);
    return _mapCards(await statement.get());
  }

  Future<StudyProgressRow?> getProgress(int flashcardId) {
    return (select(
      studyProgress,
    )..where((t) => t.flashcardId.equals(flashcardId))).getSingleOrNull();
  }

  /// Inserts or updates the progress row of [companion.flashcardId].
  Future<void> upsertProgress(StudyProgressCompanion companion) async {
    final flashcardId = companion.flashcardId.value;
    final existing = await getProgress(flashcardId);
    if (existing == null) {
      await into(studyProgress).insert(companion);
    } else {
      await (update(
        studyProgress,
      )..where((t) => t.id.equals(existing.id))).write(companion);
    }
  }

  /// Stores the new scheduling state and the review history entry atomically.
  Future<void> saveReview({
    required StudyProgressCompanion progress,
    required ReviewLogsCompanion log,
  }) async {
    await transaction(() async {
      await upsertProgress(progress);
      await into(reviewLogs).insert(log);
    });
  }

  Stream<List<ReviewLogRow>> watchReviewLogs(int flashcardId) {
    return (select(reviewLogs)
          ..where((t) => t.flashcardId.equals(flashcardId))
          ..orderBy([(t) => OrderingTerm.desc(t.reviewedAt)]))
        .watch();
  }

  JoinedSelectStatement<HasResultSet, dynamic> _dueStatement({
    int? deckId,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final statement = select(flashcards).join([
      leftOuterJoin(
        studyProgress,
        studyProgress.flashcardId.equalsExp(flashcards.id),
      ),
    ])..where(flashcards.isArchived.equals(false));

    statement.where(
      studyProgress.id.isNull() |
          studyProgress.dueDate.isSmallerOrEqualValue(reference),
    );
    if (deckId != null) {
      statement.where(flashcards.deckId.equals(deckId));
    }
    statement.orderBy([
      OrderingTerm.asc(studyProgress.dueDate),
      OrderingTerm.asc(flashcards.position),
      OrderingTerm.asc(flashcards.id),
    ]);
    return statement;
  }

  List<DueCardData> _mapCards(List<TypedResult> rows) {
    return rows
        .map(
          (row) => DueCardData(
            card: row.readTable(flashcards),
            progress: row.readTableOrNull(studyProgress),
          ),
        )
        .toList();
  }
}
