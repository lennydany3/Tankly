import 'package:drift/drift.dart';
import 'package:tankly/domain/models/refuel.dart';

import 'sync_columns.dart';
import 'vehicles_table.dart';

/// A manual correction that pins a known fuel level without a refuel: the
/// reserve light came on, the scooter ran dry, or it was still running after the
/// estimate hit zero.
class FuelEvents extends Table with SyncColumns {
  @override
  String get tableName => 'fuel_events';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get vehicleId => text().references(Vehicles, #id)();

  DateTimeColumn get at => dateTime()();

  IntColumn get kind => intEnum<FuelEventKind>()();

  /// The level this event asserts. Stored as well as derived, so a later change
  /// to the vehicle's reserve does not rewrite history.
  RealColumn get levelL => real()();
}
