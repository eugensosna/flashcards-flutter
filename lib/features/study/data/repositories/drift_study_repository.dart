import 'dart:async';

import 'package:drift/drift.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/stats_dao.dart';
import '../../../../core/database/daos/study_dao.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/date_time_x.dart';
import '../../domain/algorithms/sm2_scheduler.dart';
import '../../domain/entities/review_rating.dart';
import '../../domain/entities/study_card.dart';
import '../../domain/entities/study_progress.dart';
import '../../domain/entities/study_statistics.dart';
import '../../domain/repositories/study_repository.dart';
import '../mappers/study_mapper.dart';

class DriftStudyRepository implements StudyRepository {
  DriftStudyRepository({
    required this.database,
    required this.studyDao,
    required this.statsDao,
  });

  final AppDatabase database;
  final StudyDao studyDao;
  final StatsDao statsDao;

  @override
  Stream<List<StudyCard>> watchDueFlashcards({int? deckId}) {
    return studyDao
        .watchDueCards(deckId: deckId)
        .map((cards) => cards.map(mapDueCard).toList());
  }

  @override
  Future<List<StudyCard>> getDueFlashcards({int? deckId}) async {
    final cards = await studyDao.getDueCards(deckId: deckId);
    return cards.map(mapDueCard).toList();
  }

  @override
  Future<List<StudyCard>> getAllStudyCards(int deckId) async {
    final cards = await studyDao.getAllCards(deckId);
    return cards.map(mapDueCard).toList();
  }

  @override
  Future<StudyProgress?> getProgress(int flashcardId) async {
    final row = await studyDao.getProgress(flashcardId);
    return row == null ? null : mapStudyProgressRow(row);
  }

  @override
  Future<StudyProgress> saveReview({
    required int deckId,
    required StudyCard card,
    required ReviewRating rating,
    required Sm2Result schedule,
    required DateTime reviewedAt,
  }) async {
    final previous = card.progress;
    final progress = StudyProgressCompanion(
      flashcardId: Value(card.card.id),
      repetitions: Value(schedule.repetitions),
      interval: Value(schedule.interval),
      easeFactor: Value(schedule.easeFactor),
      dueDate: Value(schedule.dueDate),
      lastReviewedAt: Value(reviewedAt),
      reviewCount: Value((previous?.reviewCount ?? 0) + 1),
    );
    final log = ReviewLogsCompanion.insert(
      flashcardId: card.card.id,
      deckId: deckId,
      rating: rating.index,
      reviewedAt: reviewedAt,
      previousInterval: Value(previous?.interval ?? 0),
      newInterval: Value(schedule.interval),
    );

    await studyDao.saveReview(progress: progress, log: log);

    final saved = await studyDao.getProgress(card.card.id);
    if (saved == null) {
      throw const NotFoundException('The review could not be saved.');
    }
    return mapStudyProgressRow(saved);
  }

  @override
  Stream<StudyStatistics> watchStatistics() {
    return _watchOnTableChanges(getStatistics);
  }

  /// Emits [load] immediately and again whenever a relevant table changes.
  ///
  /// The table update subscription is cancelled explicitly: an `async*`
  /// generator suspended on drift's update stream cannot be cancelled promptly.
  Stream<T> _watchOnTableChanges<T>(Future<T> Function() load) {
    late final StreamController<T> controller;
    StreamSubscription<Set<TableUpdate>>? updates;
    var closed = false;

    Future<void> emit() async {
      if (closed) {
        return;
      }
      try {
        final value = await load();
        if (!closed) {
          controller.add(value);
        }
      } catch (error, stackTrace) {
        if (!closed) {
          controller.addError(error, stackTrace);
        }
      }
    }

    controller = StreamController<T>(
      onListen: () {
        updates = database
            .tableUpdates(
              TableUpdateQuery.onAllTables([
                database.decks,
                database.flashcards,
                database.studyProgress,
                database.reviewLogs,
              ]),
            )
            .listen((_) => emit());
        unawaited(emit());
      },
      onCancel: () async {
        closed = true;
        await updates?.cancel();
        updates = null;
      },
    );

    return controller.stream;
  }

  @override
  Future<StudyStatistics> getStatistics() async {
    final now = DateTime.now();
    final today = now.startOfDay;
    final historyStart = today.subtract(
      const Duration(days: AppConstants.statisticsHistoryDays - 1),
    );

    final totalCards = await statsDao.countCards();
    final dueCards = await statsDao.countDueCards(now: now);
    final newCards = await statsDao.countNewCards();
    final matureCards = await statsDao.countMatureCards(
      thresholdDays: AppConstants.matureCardIntervalDays,
    );
    final reviewsToday = await statsDao.countReviewsSince(today);
    final studiedToday = await statsDao.countCardsReviewedSince(today);
    final totalReviews = await statsDao.countReviewsSince(
      DateTime.fromMillisecondsSinceEpoch(0),
    );
    final averageEase = await statsDao.averageEaseFactor();
    final logs = await statsDao.reviewLogsSince(historyStart);

    final countsByDay = <DateTime, int>{};
    for (final log in logs) {
      final day = log.reviewedAt.startOfDay;
      countsByDay.update(day, (value) => value + 1, ifAbsent: () => 1);
    }

    return StudyStatistics(
      totalCards: totalCards,
      dueCards: dueCards,
      newCards: newCards,
      matureCards: matureCards,
      reviewsToday: reviewsToday,
      studiedToday: studiedToday,
      totalReviews: totalReviews,
      averageEaseFactor: averageEase,
      history: [
        for (var index = 0; index < AppConstants.statisticsHistoryDays; index++)
          DailyReviewCount(
            day: historyStart.add(Duration(days: index)),
            count: countsByDay[historyStart.add(Duration(days: index))] ?? 0,
          ),
      ],
    );
  }
}
