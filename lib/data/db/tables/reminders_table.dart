import 'package:drift/drift.dart';
import 'package:tankly/domain/models/refuel.dart';

import 'sync_columns.dart';
import 'vehicles_table.dart';

/// A service or document reminder rule.
///
/// One table for both kinds because they share every field except which of
/// `due_km`/`due_date` is set, and the home card needs them counted together.
class Reminders extends Table with SyncColumns {
  @override
  String get tableName => 'reminders';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get vehicleId => text().references(Vehicles, #id)();

  IntColumn get kind => intEnum<ReminderKind>()();

  TextColumn get title => text().withLength(min: 1, max: 80)();

  /// Service only: absolute odometer at which this falls due.
  RealColumn get dueKm => real().nullable()();

  /// Document only.
  DateTimeColumn get dueDate => dateTime().nullable()();

  /// Auto-reschedule interval after being marked done.
  RealColumn get intervalKm => real().nullable()();
  IntColumn get intervalDays => integer().nullable()();

  RealColumn get lastDoneKm => real().nullable()();
  DateTimeColumn get lastDoneDate => dateTime().nullable()();

  /// How early to warn. A service defaults to 500 km, a document to 7 days.
  RealColumn get notifyBeforeKm => real().nullable()();
  IntColumn get notifyBeforeDays => integer().nullable()();

  TextColumn get notes => text().nullable()();
  IntColumn get iconCodePoint => integer().nullable()();
}
