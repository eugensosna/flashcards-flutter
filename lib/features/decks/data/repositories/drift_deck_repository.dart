import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/deck_dao.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/deck.dart';
import '../../domain/entities/deck_sort.dart';
import '../../domain/entities/deck_summary.dart';
import '../../domain/repositories/deck_repository.dart';
import '../mappers/deck_mapper.dart';

class DriftDeckRepository implements DeckRepository {
  DriftDeckRepository(this._dao);

  final DeckDao _dao;

  @override
  Stream<List<DeckSummary>> watchAllDecks({
    DeckSort sort = DeckSort.nameAsc,
    String query = '',
  }) {
    return _dao
        .watchDecks(sort: sort, query: query)
        .map((items) => items.map(mapDeckWithCount).toList());
  }

  @override
  Stream<List<DeckSummary>> watchRecentDecks({int limit = 3}) {
    return _dao
        .watchRecentDecks(limit: limit)
        .map((items) => items.map(mapDeckWithCount).toList());
  }

  @override
  Stream<DeckSummary?> watchDeck(int deckId) {
    return _dao.watchDeckById(deckId).map((items) {
      if (items.isEmpty) {
        return null;
      }
      return mapDeckWithCount(items.first);
    });
  }

  @override
  Future<List<Deck>> getAllDecks({DeckSort sort = DeckSort.nameAsc}) async {
    final rows = await _dao.getAllDecks(sort: sort);
    return rows.map(mapDeckRow).toList();
  }

  @override
  Future<Deck?> getDeck(int deckId) async {
    final row = await _dao.getDeckById(deckId);
    return row == null ? null : mapDeckRow(row);
  }

  @override
  Future<Deck> createDeck({
    required String name,
    String? description,
    String? color,
  }) async {
    final now = DateTime.now();
    final id = await _dao.insertDeck(
      DecksCompanion.insert(
        name: name,
        description: Value(description),
        color: Value(color),
        createdAt: now,
        updatedAt: now,
      ),
    );
    final row = await _dao.getDeckById(id);
    if (row == null) {
      throw const NotFoundException('The deck could not be created.');
    }
    return mapDeckRow(row);
  }

  @override
  Future<Deck> updateDeck({
    required int id,
    required String name,
    String? description,
    String? color,
  }) async {
    await _dao.updateDeck(
      DecksCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        color: Value(color),
        updatedAt: Value(DateTime.now()),
      ),
    );
    final row = await _dao.getDeckById(id);
    if (row == null) {
      throw const NotFoundException('This deck no longer exists.');
    }
    return mapDeckRow(row);
  }

  @override
  Future<void> deleteDeck(int deckId) => _dao.deleteDeck(deckId);

  @override
  Future<int> countDecks() => _dao.countDecks();
}
