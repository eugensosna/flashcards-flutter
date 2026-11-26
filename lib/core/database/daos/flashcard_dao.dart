import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/decks.dart';
import '../tables/flashcards.dart';

part 'flashcard_dao.g.dart';

@DriftAccessor(tables: [Decks, Flashcards])
class FlashcardDao extends DatabaseAccessor<AppDatabase>
    with _$FlashcardDaoMixin {
  FlashcardDao(super.db);

  Stream<List<FlashcardRow>> watchByDeck(
    int deckId, {
    bool includeArchived = false,
    String query = '',
  }) {
    final statement = select(flashcards)..where((t) => t.deckId.equals(deckId));
    if (!includeArchived) {
      statement.where((t) => t.isArchived.equals(false));
    }
    final term = query.trim();
    if (term.isNotEmpty) {
      statement.where((t) => t.front.like('%$term%') | t.back.like('%$term%'));
    }
    statement.orderBy([
      (t) => OrderingTerm.asc(t.position),
      (t) => OrderingTerm.asc(t.id),
    ]);
    return statement.watch();
  }

  Future<List<FlashcardRow>> getByDeck(
    int deckId, {
    bool includeArchived = false,
  }) {
    final statement = select(flashcards)..where((t) => t.deckId.equals(deckId));
    if (!includeArchived) {
      statement.where((t) => t.isArchived.equals(false));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.position)]);
    return statement.get();
  }

  Stream<FlashcardRow?> watchById(int cardId) {
    return (select(
      flashcards,
    )..where((t) => t.id.equals(cardId))).watchSingleOrNull();
  }

  Future<FlashcardRow?> getById(int cardId) {
    return (select(
      flashcards,
    )..where((t) => t.id.equals(cardId))).getSingleOrNull();
  }

  /// Returns the next free position inside [deckId].
  Future<int> nextPosition(int deckId) async {
    final maxPosition = flashcards.position.max();
    final statement = selectOnly(flashcards)
      ..addColumns([maxPosition])
      ..where(flashcards.deckId.equals(deckId));
    final row = await statement.getSingle();
    final max = row.read(maxPosition);
    return max == null ? 0 : max + 1;
  }

  Future<int> insertCard(FlashcardsCompanion companion) {
    return into(flashcards).insert(companion);
  }

  Future<void> updateCard(FlashcardsCompanion companion) async {
    await (update(
      flashcards,
    )..where((t) => t.id.equals(companion.id.value))).write(companion);
  }

  Future<int> deleteCard(int cardId) {
    return (delete(flashcards)..where((t) => t.id.equals(cardId))).go();
  }

  Future<int> deleteByDeck(int deckId) {
    return (delete(flashcards)..where((t) => t.deckId.equals(deckId))).go();
  }

  Future<void> setArchived(int cardId, {required bool archived}) async {
    await (update(flashcards)..where((t) => t.id.equals(cardId))).write(
      FlashcardsCompanion(
        isArchived: Value(archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> moveToDeck(int cardId, int targetDeckId) async {
    await transaction(() async {
      final position = await nextPosition(targetDeckId);
      await (update(flashcards)..where((t) => t.id.equals(cardId))).write(
        FlashcardsCompanion(
          deckId: Value(targetDeckId),
          position: Value(position),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Rewrites the `position` column of [deckId] to match [orderedCardIds].
  Future<void> reorder(int deckId, List<int> orderedCardIds) async {
    final now = DateTime.now();
    await transaction(() async {
      for (var index = 0; index < orderedCardIds.length; index++) {
        await (update(
          flashcards,
        )..where((t) => t.id.equals(orderedCardIds[index]))).write(
          FlashcardsCompanion(position: Value(index), updatedAt: Value(now)),
        );
      }
    });
  }
}
