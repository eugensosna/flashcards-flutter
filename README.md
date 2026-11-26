# Flashcards

Offline-first flashcard app built with Flutter, Drift (SQLite), Riverpod and
GoRouter. Decks, cards, study schedule and preferences stay on the device.

## Features

- Deck CRUD with search, sorting, per-deck card and due counts.
- Flashcard CRUD with archive/unarchive, move between decks, drag reordering
  and search.
- Study sessions with a 3D card flip, previous/next navigation, progress and
  Again / Hard / Good / Easy ratings.
- SM-2 spaced repetition computed in the domain layer and persisted together
  with a review log.
- Dashboard (decks, cards, due today, studied today, recent decks, study quick
  action) and statistics (7-day history, mature/new cards, average ease).
- Light/dark/system theme persisted in the database.
- Material 3 UI with responsive layouts (bottom bar on phones, navigation rail
  on wide screens).

## Architecture

```
lib/
├── app/            MaterialApp, GoRouter routes, themes
├── core/           database (Drift), errors, utils, constants
├── features/
│   ├── decks/      domain (entities, repository, use cases)
│   │               data (mappers, Drift repository)
│   │               presentation (providers, screens, widgets)
│   ├── flashcards/ same layering
│   ├── study/      SM-2, session state, statistics
│   ├── dashboard/
│   └── settings/
└── shared/         reusable widgets
```

- Domain entities are immutable Freezed classes and know nothing about Flutter
  or Drift.
- Repository interfaces live in `domain/repositories`; Drift implementations
  and row mappers live in `data/`.
- Riverpod providers are generated with `riverpod_generator`; screens watch
  `StreamProvider`s so database changes update the UI automatically.
- `AppDatabase` is injected through `appDatabaseProvider`, which tests override
  with an in-memory database.

## Database

Schema lives in `lib/core/database`:

| Version | Change |
| ------- | ------ |
| 1 | `decks`, `flashcards`, `study_progress` |
| 2 | `review_logs`, `app_settings` (additive, data preserved) |

Foreign keys cascade from decks to cards, progress and review logs.
`study_progress` has a unique key on `flashcard_id`, so a card has at most one
scheduling row.

### Changing the schema

```sh
# 1. edit tables, bump AppDatabase.schemaVersion, add the onUpgrade step
dart run build_runner build

# 2. capture the new snapshot
dart run drift_dev schema dump lib/core/database/app_database.dart drift_schemas/

# 3. regenerate the migration test helpers
dart run drift_dev schema generate drift_schemas/ test/database/generated/

# 4. extend test/database/migration_test.dart, then
flutter test test/database
```

Snapshots are committed in `drift_schemas/`. Migrations are additive and are
verified against real v1 database files by Drift's `SchemaVerifier`.

## Getting started

```sh
flutter pub get
dart run build_runner build   # generated Freezed, Riverpod and Drift code
flutter run
```

## Quality checks

```sh
dart format lib test
flutter analyze          # no issues
flutter test             # 68 unit, database, migration, provider and widget tests
```

## Notes and decisions

- Review dates are normalised to midnight so "due today" does not depend on the
  time a session was completed.
- SQLite stores timestamps with second precision; tests compare at that
  granularity.
- Dashboard and statistics aggregate several tables. They listen to Drift's
  `tableUpdates` and re-run the aggregate queries; the subscription is cancelled
  explicitly so database shutdown never blocks.
- Web builds work, but running on the web additionally needs `sqlite3.wasm` and
  `drift_worker.js` in `web/` (see the Drift web setup guide).
