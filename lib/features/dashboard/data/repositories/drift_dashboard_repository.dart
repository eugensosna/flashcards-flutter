import 'dart:async';

import 'package:drift/drift.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/deck_dao.dart';
import '../../../../core/database/daos/stats_dao.dart';
import '../../../../core/utils/date_time_x.dart';
import '../../../decks/data/mappers/deck_mapper.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DriftDashboardRepository implements DashboardRepository {
  DriftDashboardRepository({
    required this.database,
    required this.statsDao,
    required this.deckDao,
  });

  final AppDatabase database;
  final StatsDao statsDao;
  final DeckDao deckDao;

  @override
  Stream<DashboardStats> watchStats() {
    late final StreamController<DashboardStats> controller;
    StreamSubscription<Set<TableUpdate>>? updates;
    var closed = false;

    Future<void> emit() async {
      if (closed) {
        return;
      }
      try {
        final stats = await _load();
        if (!closed) {
          controller.add(stats);
        }
      } catch (error, stackTrace) {
        if (!closed) {
          controller.addError(error, stackTrace);
        }
      }
    }

    controller = StreamController<DashboardStats>(
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

  Future<DashboardStats> _load() async {
    final today = DateTime.now().startOfDay;
    final totalDecks = await statsDao.countDecks();
    final totalFlashcards = await statsDao.countCards();
    final dueCards = await statsDao.countDueCards();
    final studiedToday = await statsDao.countCardsReviewedSince(today);
    final recentDecks = await deckDao
        .watchRecentDecks(limit: AppConstants.recentDeckLimit)
        .first;

    return DashboardStats(
      totalDecks: totalDecks,
      totalFlashcards: totalFlashcards,
      dueCards: dueCards,
      studiedToday: studiedToday,
      recentDecks: recentDecks.map(mapDeckWithCount).toList(),
    );
  }
}
