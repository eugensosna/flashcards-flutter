import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/decks.dart';
import '../tables/flashcards.dart';
import '../tables/review_logs.dart';
import '../tables/study_progress.dart';

part 'stats_dao.g.dart';

/// Read-only aggregate queries used by the dashboard and statistics screens.
@DriftAccessor(tables: [Decks, Flashcards, StudyProgress, ReviewLogs])
class StatsDao extends DatabaseAccessor<AppDatabase> with _$StatsDaoMixin {
  StatsDao(super.db);

  Future<int> countDecks() async {
    final count = decks.id.count();
    final statement = selectOnly(decks)..addColumns([count]);
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<int> countCards({bool includeArchived = false}) async {
    final count = flashcards.id.count();
    final statement = selectOnly(flashcards)..addColumns([count]);
    if (!includeArchived) {
      statement.where(flashcards.isArchived.equals(false));
    }
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<int> countNewCards() async {
    final count = flashcards.id.count();
    final statement = selectOnly(flashcards)..addColumns([count]);
    statement.join([
      leftOuterJoin(
        studyProgress,
        studyProgress.flashcardId.equalsExp(flashcards.id),
      ),
    ]);
    statement.where(flashcards.isArchived.equals(false));
    statement.where(studyProgress.id.isNull());
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<int> countDueCards({DateTime? now}) async {
    final count = flashcards.id.count();
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
          studyProgress.dueDate.isSmallerOrEqualValue(now ?? DateTime.now()),
    );
    return (await statement.getSingle()).read(count) ?? 0;
  }

  /// Cards with a scheduling interval of at least three weeks.
  Future<int> countMatureCards({int thresholdDays = 21}) async {
    final count = studyProgress.id.count();
    final statement = selectOnly(studyProgress)..addColumns([count]);
    statement.join([
      innerJoin(flashcards, flashcards.id.equalsExp(studyProgress.flashcardId)),
    ]);
    statement.where(flashcards.isArchived.equals(false));
    statement.where(studyProgress.interval.isBiggerOrEqualValue(thresholdDays));
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<int> countReviewsSince(DateTime since) async {
    final count = reviewLogs.id.count();
    final statement = selectOnly(reviewLogs)
      ..addColumns([count])
      ..where(reviewLogs.reviewedAt.isBiggerOrEqualValue(since));
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<int> countCardsReviewedSince(DateTime since) async {
    final count = reviewLogs.flashcardId.count(distinct: true);
    final statement = selectOnly(reviewLogs)
      ..addColumns([count])
      ..where(reviewLogs.reviewedAt.isBiggerOrEqualValue(since));
    return (await statement.getSingle()).read(count) ?? 0;
  }

  Future<double> averageEaseFactor() async {
    final average = studyProgress.easeFactor.avg();
    final statement = selectOnly(studyProgress)..addColumns([average]);
    final row = await statement.getSingle();
    return row.read(average) ?? 0;
  }

  Future<List<ReviewLogRow>> reviewLogsSince(DateTime since) {
    return (select(reviewLogs)
          ..where((t) => t.reviewedAt.isBiggerOrEqualValue(since))
          ..orderBy([(t) => OrderingTerm.asc(t.reviewedAt)]))
        .get();
  }
}
