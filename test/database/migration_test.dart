import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flashcards/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test('version 1 schema only contains the original tables', () async {
    final schema = await verifier.schemaAt(1);
    final names = schema.rawDatabase
        .select("SELECT name FROM sqlite_master WHERE type = 'table'")
        .map((row) => row['name'] as String)
        .toSet();

    expect(names, containsAll(['decks', 'flashcards', 'study_progress']));
    expect(names, isNot(contains('review_logs')));
    expect(names, isNot(contains('app_settings')));
  });

  test('upgrade from v1 to v2 preserves all user data', () async {
    final schema = await verifier.schemaAt(1);
    final raw = schema.rawDatabase;
    final createdAt = DateTime(2026, 1, 15, 8, 30);
    final reviewedAt = DateTime(2026, 1, 16, 9);
    final seconds = createdAt.millisecondsSinceEpoch ~/ 1000;
    final reviewedSeconds = reviewedAt.millisecondsSinceEpoch ~/ 1000;

    raw.execute(
      'INSERT INTO decks (id, name, description, color, created_at, '
      'updated_at) VALUES (?, ?, ?, ?, ?, ?)',
      [
        1,
        'Preserved deck',
        'kept after migration',
        '#FF0000',
        seconds,
        seconds,
      ],
    );
    raw.execute(
      'INSERT INTO flashcards (id, deck_id, front, back, created_at, '
      'updated_at, position, is_archived) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [1, 1, 'front text', 'back text', seconds, seconds, 0, 0],
    );
    raw.execute(
      'INSERT INTO study_progress (id, flashcard_id, repetitions, interval, '
      'ease_factor, due_date, last_reviewed_at, review_count) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [1, 1, 2, 6, 2.36, reviewedSeconds, reviewedSeconds, 4],
    );

    final db = AppDatabase.forTesting(schema.newConnection());
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, 2);

    final decks = await db.select(db.decks).get();
    expect(decks, hasLength(1));
    expect(decks.single.name, 'Preserved deck');
    expect(decks.single.description, 'kept after migration');
    expect(decks.single.color, '#FF0000');

    final cards = await db.select(db.flashcards).get();
    expect(cards, hasLength(1));
    expect(cards.single.front, 'front text');
    expect(cards.single.back, 'back text');

    final progress = await db.select(db.studyProgress).get();
    expect(progress, hasLength(1));
    expect(progress.single.repetitions, 2);
    expect(progress.single.interval, 6);
    expect(progress.single.easeFactor, closeTo(2.36, 0.0001));
    expect(progress.single.reviewCount, 4);
    expect(progress.single.lastReviewedAt, isNotNull);
  });

  test('v2 tables are usable after the upgrade', () async {
    final schema = await verifier.schemaAt(1);
    final raw = schema.rawDatabase;
    final now = DateTime(2026, 2, 1).millisecondsSinceEpoch ~/ 1000;
    raw.execute(
      'INSERT INTO decks (id, name, created_at, updated_at) VALUES (?, ?, ?, ?)',
      [1, 'Deck', now, now],
    );
    raw.execute(
      'INSERT INTO flashcards (id, deck_id, front, back, created_at, '
      'updated_at, position, is_archived) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [1, 1, 'f', 'b', now, now, 0, 0],
    );

    final db = AppDatabase.forTesting(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, 2);

    await db
        .into(db.reviewLogs)
        .insert(
          ReviewLogsCompanion.insert(
            flashcardId: 1,
            deckId: 1,
            rating: 3,
            reviewedAt: DateTime(2026, 2, 2),
          ),
        );
    await db.settingsDao.setValue('theme_mode', 'dark');

    expect(await db.select(db.reviewLogs).get(), hasLength(1));
    expect(await db.settingsDao.getValue('theme_mode'), 'dark');
  });

  test('generated schema migration keeps data integrity', () async {
    final seconds = DateTime(2026, 3, 4).millisecondsSinceEpoch ~/ 1000;

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.forTesting,
      createItems: (batch, oldDatabase) {
        batch.insert(
          oldDatabase.decks,
          RawValuesInsertable({
            'id': Variable(1),
            'name': Variable('Generated deck'),
            'created_at': Variable(seconds),
            'updated_at': Variable(seconds),
          }),
        );
        batch.insert(
          oldDatabase.flashcards,
          RawValuesInsertable({
            'id': Variable(1),
            'deck_id': Variable(1),
            'front': Variable('front'),
            'back': Variable('back'),
            'created_at': Variable(seconds),
            'updated_at': Variable(seconds),
            'position': Variable(0),
            'is_archived': Variable(false),
          }),
        );
        batch.insert(
          oldDatabase.studyProgress,
          RawValuesInsertable({
            'id': Variable(1),
            'flashcard_id': Variable(1),
            'repetitions': Variable(2),
            'interval': Variable(6),
            'ease_factor': Variable(2.5),
            'due_date': Variable(seconds),
            'review_count': Variable(3),
          }),
        );
      },
      validateItems: (newDatabase) async {
        // Snapshot tables have no data classes, so read them with raw SQL.
        final decks = await newDatabase
            .customSelect('SELECT name FROM decks')
            .getSingle();
        expect(decks.read<String>('name'), 'Generated deck');

        final cards = await newDatabase
            .customSelect('SELECT front FROM flashcards')
            .getSingle();
        expect(cards.read<String>('front'), 'front');

        final progress = await newDatabase
            .customSelect(
              'SELECT repetitions, interval, review_count FROM study_progress',
            )
            .getSingle();
        expect(progress.read<int>('repetitions'), 2);
        expect(progress.read<int>('interval'), 6);
        expect(progress.read<int>('review_count'), 3);

        final logs = await newDatabase
            .customSelect('SELECT COUNT(*) AS total FROM review_logs')
            .getSingle();
        expect(logs.read<int>('total'), 0);
      },
    );
  });

  test('fresh databases are created with the current schema', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, 2);

    expect(await db.customSelect('SELECT 1').get(), hasLength(1));
  });
}
