import 'package:drift/drift.dart';

/// Small key/value store for user preferences such as the theme mode.
@DataClassName('AppSettingRow')
class AppSettings extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
