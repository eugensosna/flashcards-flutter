import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/repositories/drift_settings_repository.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return DriftSettingsRepository(ref.watch(appDatabaseProvider).settingsDao);
}

/// Theme preference, persisted in the settings table.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  Future<AppThemeMode> build() {
    return ref.watch(settingsRepositoryProvider).getThemeMode();
  }

  Future<void> setMode(AppThemeMode mode) async {
    final previous = state;
    state = AsyncData(mode);
    try {
      await ref.read(settingsRepositoryProvider).setThemeMode(mode);
    } catch (_) {
      state = previous;
      rethrow;
    }
  }
}
