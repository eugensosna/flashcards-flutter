import '../entities/app_theme_mode.dart';

/// Persistence contract for user preferences.
abstract interface class SettingsRepository {
  Future<AppThemeMode> getThemeMode();

  Stream<AppThemeMode> watchThemeMode();

  Future<void> setThemeMode(AppThemeMode mode);
}
