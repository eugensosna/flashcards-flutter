import 'package:drift/drift.dart';

import 'decks.dart';

/// A single question/answer pair belonging to a deck.
@DataClassName('FlashcardRow')
@TableIndex(name: 'flashcards_deck_id_idx', columns: {#deckId})
@TableIndex(name: 'flashcards_deck_position_idx', columns: {#deckId, #position})
class Flashcards extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get deckId => integer().references(
    Decks,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  TextColumn get front => text()();

  TextColumn get back => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  /// Ordering of the card inside its deck (ascending).
  IntColumn get position => integer().withDefault(const Constant(0))();

  /// Archived cards are hidden from study sessions and deck counts.
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}
