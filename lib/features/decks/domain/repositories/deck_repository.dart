import '../../../../core/constants/app_constants.dart';
import '../entities/deck.dart';
import '../entities/deck_sort.dart';
import '../entities/deck_summary.dart';

/// Persistence contract for decks, expressed only in domain types.
abstract interface class DeckRepository {
  Stream<List<DeckSummary>> watchAllDecks({
    DeckSort sort = DeckSort.nameAsc,
    String query = '',
  });

  Stream<List<DeckSummary>> watchRecentDecks({
    int limit = AppConstants.recentDeckLimit,
  });

  Stream<DeckSummary?> watchDeck(int deckId);

  Future<List<Deck>> getAllDecks({DeckSort sort = DeckSort.nameAsc});

  Future<Deck?> getDeck(int deckId);

  Future<Deck> createDeck({
    required String name,
    String? description,
    String? color,
  });

  Future<Deck> updateDeck({
    required int id,
    required String name,
    String? description,
    String? color,
  });

  Future<void> deleteDeck(int deckId);

  Future<int> countDecks();
}
