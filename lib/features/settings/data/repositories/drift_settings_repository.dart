import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/daos/settings_dao.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/settings_repository.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._dao);

  final SettingsDao _dao;

  @override
  Future<AppThemeMode> getThemeMode() async {
    final stored = await _dao.getValue(AppConstants.themeModeKey);
    return _parse(stored);
  }

  @override
  Stream<AppThemeMode> watchThemeMode() {
    return _dao.watchValue(AppConstants.themeModeKey).map(_parse);
  }

  @override
  Future<void> setThemeMode(AppThemeMode mode) {
    return _dao.setValue(AppConstants.themeModeKey, mode.name);
  }

  AppThemeMode _parse(String? stored) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => AppThemeMode.system,
    );
  }
}
