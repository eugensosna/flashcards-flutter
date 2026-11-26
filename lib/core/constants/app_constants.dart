/// Application wide constants that are shared between layers.
abstract final class AppConstants {
  static const String appName = 'Flashcards';

  /// Version of the database schema. Keep in sync with [AppDatabase].
  static const int databaseSchemaVersion = 2;

  static const int deckNameMaxLength = 120;
  static const int cardContentMaxLength = 5000;

  static const int recentDeckLimit = 3;

  /// Cards with an interval of at least this many days count as "mature".
  static const int matureCardIntervalDays = 21;

  /// Number of days shown in the statistics history.
  static const int statisticsHistoryDays = 7;

  static const String themeModeKey = 'theme_mode';
}
