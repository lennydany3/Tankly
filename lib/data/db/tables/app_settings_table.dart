import 'package:drift/drift.dart';

/// Local key-value settings. One row per key, local only, never synced.
///
/// Device-scoped choices live here rather than on `vehicles` because they belong
/// to the phone, not the scooter: a theme does not follow you to a second device,
/// and a unit preference should not be pushed from a backup.
class AppSettings extends Table {
  @override
  String get tableName => 'app_settings';

  /// The setting name, e.g. `distance_unit` or `onboarding_complete`.
  TextColumn get key => text()();

  /// Value as JSON text, so a bool, number and list all fit one column.
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
