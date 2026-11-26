import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/deck_dao.dart';
import '../../domain/entities/deck.dart';
import '../../domain/entities/deck_summary.dart';

Deck mapDeckRow(DeckRow row) {
  return Deck(
    id: row.id,
    name: row.name,
    description: row.description,
    color: row.color,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  );
}

DeckSummary mapDeckWithCount(DeckWithCount data) {
  return DeckSummary(
    deck: mapDeckRow(data.deck),
    cardCount: data.cardCount,
    dueCount: data.dueCount,
  );
}
