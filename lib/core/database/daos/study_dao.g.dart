// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_dao.dart';

// ignore_for_file: type=lint
mixin _$StudyDaoMixin on DatabaseAccessor<AppDatabase> {
  $DecksTable get decks => attachedDatabase.decks;
  $FlashcardsTable get flashcards => attachedDatabase.flashcards;
  $StudyProgressTable get studyProgress => attachedDatabase.studyProgress;
  $ReviewLogsTable get reviewLogs => attachedDatabase.reviewLogs;
  StudyDaoManager get managers => StudyDaoManager(this);
}

class StudyDaoManager {
  final _$StudyDaoMixin _db;
  StudyDaoManager(this._db);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db.attachedDatabase, _db.decks);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db.attachedDatabase, _db.flashcards);
  $$StudyProgressTableTableManager get studyProgress =>
      $$StudyProgressTableTableManager(_db.attachedDatabase, _db.studyProgress);
  $$ReviewLogsTableTableManager get reviewLogs =>
      $$ReviewLogsTableTableManager(_db.attachedDatabase, _db.reviewLogs);
}
