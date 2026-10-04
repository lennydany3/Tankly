import 'package:drift/drift.dart';

import 'sync_columns.dart';
import 'vehicles_table.dart';

/// An odometer reading the rider typed in, and what it taught the app.
///
/// The GPS-vs-odometer ratio is what calibrates `vehicles.distance_factor`.
class OdometerChecks extends Table with SyncColumns {
  @override
  String get tableName => 'odometer_checks';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get vehicleId => text().references(Vehicles, #id)();

  DateTimeColumn get at => dateTime()();

  RealColumn get odometerKm => real()();

  /// Raw GPS distance since the previous check. Null for the very first check.
  RealColumn get gpsKmSinceLast => real().nullable()();

  /// `real / gps` at the time of the check. Null when there was too little GPS to
  /// compare against.
  RealColumn get factorSample => real().nullable()();
}
