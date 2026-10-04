import 'package:drift/drift.dart';

/// Whether a row still needs to reach the server.
///
/// Local only. This column is never synced: the server has its own idea of what
/// it has, and trusting a client-supplied "already synced" flag would let a
/// reinstall silently skip uploading the user's history.
enum SyncStatus {
  /// Changed locally since the server last confirmed it.
  pending,

  /// The server confirmed this exact `updated_at`.
  synced,
}

/// Columns every synced table carries (system design 6).
///
/// Mixed into a table so the convention cannot be forgotten on the tenth table:
/// `id`, `user_id`, timestamps, soft delete, and the local outbox flag.
mixin SyncColumns on Table {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  TextColumn get id => text()();

  /// Null until the rider signs in with Google, then stamped on every row.
  TextColumn get userId => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  DateTimeColumn get updatedAt => dateTime()();

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(const Constant(0))();
}
