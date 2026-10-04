import 'package:drift/drift.dart';
import 'package:tankly/domain/models/trip.dart';

import 'sync_columns.dart';
import 'vehicles_table.dart';

/// One recorded ride.
///
/// `raw_distance_km` is deliberately uncorrected: `distance_factor` is applied at
/// read time so a single odometer check retroactively fixes every past ride.
class Trips extends Table with SyncColumns {
  @override
  String get tableName => 'trips';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get vehicleId => text().references(Vehicles, #id)();

  /// `recording` while live, `completed` once saved, `interrupted` if the
  /// process died mid-ride.
  IntColumn get status => intEnum<TripStatus>()();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get endedAt => dateTime().nullable()();

  RealColumn get rawDistanceKm => real().withDefault(const Constant(0.0))();

  IntColumn get durationS => integer().withDefault(const Constant(0))();

  IntColumn get movingS => integer().withDefault(const Constant(0))();

  IntColumn get idleS => integer().withDefault(const Constant(0))();

  RealColumn get avgSpeedKmh => real().withDefault(const Constant(0.0))();

  RealColumn get maxSpeedKmh => real().withDefault(const Constant(0.0))();

  /// Informational only. GPS altitude is too noisy to be load-bearing.
  RealColumn get elevationGainM => real().nullable()();

  RealColumn get startLat => real().nullable()();
  RealColumn get startLng => real().nullable()();
  RealColumn get endLat => real().nullable()();
  RealColumn get endLng => real().nullable()();

  TextColumn get title => text().nullable()();
  TextColumn get notes => text().nullable()();

  /// Gzipped JSON polyline, built when the trip completes. This is what goes to
  /// the server: the `trip_points` rows stay on the phone.
  BlobColumn get routeGz => blob().nullable()();
}
