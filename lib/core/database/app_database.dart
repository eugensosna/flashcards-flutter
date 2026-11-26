import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/deck_dao.dart';
import 'daos/flashcard_dao.dart';
import 'daos/settings_dao.dart';
import 'daos/stats_dao.dart';
import 'daos/study_dao.dart';
import 'tables/app_settings.dart';
import 'tables/decks.dart';
import 'tables/flashcards.dart';
import 'tables/review_logs.dart';
import 'tables/study_progress.dart';

part 'app_database.g.dart';

/// Offline-first SQLite database for decks, flashcards and study progress.
///
/// Schema history:
/// * v1 – decks, flashcards and study progress.
/// * v2 – add `review_logs` (study history) and `app_settings` (preferences).
@DriftDatabase(
  tables: [Decks, Flashcards, StudyProgress, ReviewLogs, AppSettings],
  daos: [DeckDao, FlashcardDao, StudyDao, StatsDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'flashcards_db'));

  /// Used by tests to inject an in-memory or temporary database.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // v1 databases only know about decks, flashcards and progress. The new
        // tables are additive, so existing rows are preserved untouched.
        await migrator.createTable(reviewLogs);
        await migrator.createIndex(reviewLogsReviewedAtIdx);
        await migrator.createIndex(reviewLogsFlashcardIdIdx);
        await migrator.createIndex(reviewLogsDeckIdIdx);
        await migrator.createTable(appSettings);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
