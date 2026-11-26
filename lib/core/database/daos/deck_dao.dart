import 'package:drift/drift.dart';

import '../../../features/decks/domain/entities/deck_sort.dart';
import '../app_database.dart';
import '../tables/decks.dart';
import '../tables/flashcards.dart';
import '../tables/study_progress.dart';

part 'deck_dao.g.dart';

/// A deck together with the aggregated numbers shown in deck lists.
class DeckWithCount {
  const DeckWithCount({
    required this.deck,
    required this.cardCount,
    required this.dueCount,
  });

  final DeckRow deck;
  final int cardCount;
  final int dueCount;
}

@DriftAccessor(tables: [Decks, Flashcards, StudyProgress])
class DeckDao extends DatabaseAccessor<AppDatabase> with _$DeckDaoMixin {
  DeckDao(super.db);

  Stream<List<DeckWithCount>> watchDecks({
    DeckSort sort = DeckSort.nameAsc,
    String query = '',
  }) {
    return _watchDecks(sort: sort, query: query);
  }

  Stream<List<DeckWithCount>> watchDeckById(int deckId) {
    return _watchDecks(deckId: deckId);
  }

  /// Decks ordered by their last modification, used on the dashboard.
  Stream<List<DeckWithCount>> watchRecentDecks({int limit = 3}) {
    return _watchDecks(
      sort: DeckSort.createdAtNewest,
      limit: limit,
      byUpdate: true,
    );
  }

  Future<DeckRow?> getDeckById(int deckId) {
    return (select(
      decks,
    )..where((table) => table.id.equals(deckId))).getSingleOrNull();
  }

  Stream<DeckRow?> watchDeckRowById(int deckId) {
    return (select(
      decks,
    )..where((table) => table.id.equals(deckId))).watchSingleOrNull();
  }

  Future<List<DeckRow>> getAllDecks({DeckSort sort = DeckSort.nameAsc}) {
    final statement = select(decks);
    _applySort(statement, decks, sort);
    return statement.get();
  }

  Future<int> countDecks() async {
    final count = decks.id.count();
    final statement = selectOnly(decks)..addColumns([count]);
    final row = await statement.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> insertDeck(DecksCompanion companion) {
    return into(decks).insert(companion);
  }

  Future<void> updateDeck(DecksCompanion companion) async {
    await (update(
      decks,
    )..where((table) => table.id.equals(companion.id.value))).write(companion);
  }

  Future<int> deleteDeck(int deckId) {
    return (delete(decks)..where((table) => table.id.equals(deckId))).go();
  }

  Stream<List<DeckWithCount>> _watchDecks({
    DeckSort sort = DeckSort.nameAsc,
    String query = '',
    int? deckId,
    int? limit,
    bool byUpdate = false,
  }) {
    final now = DateTime.now();
    final cardCount = flashcards.id.count(
      filter: flashcards.isArchived.equals(false),
    );
    final dueCount = flashcards.id.count(
      filter:
          flashcards.isArchived.equals(false) &
          (studyProgress.id.isNull() |
              studyProgress.dueDate.isSmallerOrEqualValue(now)),
    );

    final statement = select(decks).join([
      leftOuterJoin(flashcards, flashcards.deckId.equalsExp(decks.id)),
      leftOuterJoin(
        studyProgress,
        studyProgress.flashcardId.equalsExp(flashcards.id),
      ),
    ])..addColumns([cardCount, dueCount]);

    if (deckId != null) {
      statement.where(decks.id.equals(deckId));
    }

    final term = query.trim();
    if (term.isNotEmpty) {
      statement.where(
        decks.name.like('%$term%') | decks.description.like('%$term%'),
      );
    }

    statement.groupBy([decks.id]);

    switch (sort) {
      case DeckSort.nameAsc:
        statement.orderBy([OrderingTerm.asc(decks.name.lower())]);
      case DeckSort.nameDesc:
        statement.orderBy([OrderingTerm.desc(decks.name.lower())]);
      case DeckSort.createdAtNewest:
        statement.orderBy([
          OrderingTerm.desc(byUpdate ? decks.updatedAt : decks.createdAt),
        ]);
      case DeckSort.createdAtOldest:
        statement.orderBy([
          OrderingTerm.asc(byUpdate ? decks.updatedAt : decks.createdAt),
        ]);
    }

    if (limit != null) {
      statement.limit(limit);
    }

    return statement.watch().map(
      (rows) => rows
          .map(
            (row) => DeckWithCount(
              deck: row.readTable(decks),
              cardCount: row.read(cardCount) ?? 0,
              dueCount: row.read(dueCount) ?? 0,
            ),
          )
          .toList(),
    );
  }

  void _applySort(
    SimpleSelectStatement<$DecksTable, DeckRow> statement,
    $DecksTable table,
    DeckSort sort,
  ) {
    switch (sort) {
      case DeckSort.nameAsc:
        statement.orderBy([(t) => OrderingTerm.asc(t.name.lower())]);
      case DeckSort.nameDesc:
        statement.orderBy([(t) => OrderingTerm.desc(t.name.lower())]);
      case DeckSort.createdAtNewest:
        statement.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      case DeckSort.createdAtOldest:
        statement.orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    }
  }
}
