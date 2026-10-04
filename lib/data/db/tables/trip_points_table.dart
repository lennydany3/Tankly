import 'package:drift/drift.dart';

import 'trips_table.dart';

/// Every accepted GPS fix of a ride, in order.
///
/// Local only: these rows are never synced one by one. When a trip completes its
/// points are gzipped into `trips.route_gz` and the rows are pruned, because a
/// year of city riding is tens of thousands of rows the server has no use for.
class TripPoints extends Table {
  @override
  String get tableName => 'trip_points';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get tripId => text().references(Trips, #id)();

  /// Position within the track, so ordering survives a delete/re-insert.
  IntColumn get seq => integer()();

  DateTimeColumn get ts => dateTime()();

  RealColumn get lat => real()();
  RealColumn get lng => real()();
  RealColumn get altitudeM => real().nullable()();
  RealColumn get speedMps => real().withDefault(const Constant(0.0))();
  RealColumn get accuracyM => real().withDefault(const Constant(0.0))();
  BoolColumn get isMoving => boolean().withDefault(const Constant(true))();
}
