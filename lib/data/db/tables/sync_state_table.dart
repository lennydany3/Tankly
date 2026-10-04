import 'package:drift/drift.dart';

/// Sync bookkeeping. One row, id always 1, local only.
///
/// Nothing here is synced: it describes this phone's relationship with the
/// server, and a second device has its own.
class SyncStates extends Table {
  @override
  String get tableName => 'sync_state';

  IntColumn get id => integer().withDefault(const Constant(1))();

  DateTimeColumn get lastPulledAt => dateTime().nullable()();
  DateTimeColumn get lastPushAt => dateTime().nullable()();

  /// Last failure, so the settings screen can say why sync stopped instead of
  /// showing a silent spinner forever.
  TextColumn get lastError => text().nullable()();

  DateTimeColumn get lastErrorAt => dateTime().nullable()();
}
