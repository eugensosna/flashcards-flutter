import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/flashcard_dao.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../mappers/flashcard_mapper.dart';

class DriftFlashcardRepository implements FlashcardRepository {
  DriftFlashcardRepository(this._dao);

  final FlashcardDao _dao;

  @override
  Stream<List<Flashcard>> watchFlashcardsByDeck(
    int deckId, {
    bool includeArchived = false,
    String query = '',
  }) {
    return _dao
        .watchByDeck(deckId, includeArchived: includeArchived, query: query)
        .map((rows) => rows.map(mapFlashcardRow).toList());
  }

  @override
  Future<List<Flashcard>> getFlashcardsByDeck(
    int deckId, {
    bool includeArchived = false,
  }) async {
    final rows = await _dao.getByDeck(deckId, includeArchived: includeArchived);
    return rows.map(mapFlashcardRow).toList();
  }

  @override
  Stream<Flashcard?> watchFlashcard(int cardId) {
    return _dao
        .watchById(cardId)
        .map((row) => row == null ? null : mapFlashcardRow(row));
  }

  @override
  Future<Flashcard?> getFlashcard(int cardId) async {
    final row = await _dao.getById(cardId);
    return row == null ? null : mapFlashcardRow(row);
  }

  @override
  Future<Flashcard> createFlashcard({
    required int deckId,
    required String front,
    required String back,
  }) async {
    final now = DateTime.now();
    final position = await _dao.nextPosition(deckId);
    final id = await _dao.insertCard(
      FlashcardsCompanion.insert(
        deckId: deckId,
        front: front,
        back: back,
        createdAt: now,
        updatedAt: now,
        position: Value(position),
      ),
    );
    final row = await _dao.getById(id);
    if (row == null) {
      throw const NotFoundException('The flashcard could not be created.');
    }
    return mapFlashcardRow(row);
  }

  @override
  Future<Flashcard> updateFlashcard({
    required int id,
    required int deckId,
    required String front,
    required String back,
  }) async {
    await _dao.updateCard(
      FlashcardsCompanion(
        id: Value(id),
        front: Value(front),
        back: Value(back),
        updatedAt: Value(DateTime.now()),
      ),
    );
    final row = await _dao.getById(id);
    if (row == null) {
      throw const NotFoundException('This flashcard no longer exists.');
    }
    return mapFlashcardRow(row);
  }

  @override
  Future<void> deleteFlashcard(int cardId) => _dao.deleteCard(cardId);

  @override
  Future<void> moveFlashcard({
    required int cardId,
    required int targetDeckId,
  }) async {
    final row = await _dao.getById(cardId);
    if (row == null) {
      throw const NotFoundException('This flashcard no longer exists.');
    }
    await _dao.moveToDeck(cardId, targetDeckId);
  }

  @override
  Future<void> setArchived({
    required int cardId,
    required bool archived,
  }) async {
    await _dao.setArchived(cardId, archived: archived);
  }

  @override
  Future<void> reorderFlashcards({
    required int deckId,
    required List<int> orderedCardIds,
  }) {
    return _dao.reorder(deckId, orderedCardIds);
  }
}
