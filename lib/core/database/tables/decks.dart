import 'package:drift/drift.dart';

/// A deck groups flashcards into a single study unit.
@DataClassName('DeckRow')
@TableIndex(name: 'decks_name_idx', columns: {#name})
class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get description => text().nullable()();

  /// Hex color (for example `#FF5722`) used to visually group decks.
  TextColumn get color => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
