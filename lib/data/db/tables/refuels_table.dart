import 'package:drift/drift.dart';
import 'package:tankly/domain/models/refuel.dart';

import 'sync_columns.dart';
import 'vehicles_table.dart';

/// A refuel: the primary kind of fuel anchor.
class Refuels extends Table with SyncColumns {
  @override
  String get tableName => 'refuels';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get vehicleId => text().references(Vehicles, #id)();

  DateTimeColumn get at => dateTime()();

  RealColumn get litres => real()();

  RealColumn get priceTotal => real()();

  /// Nullable: the rider may know the total but not the unit price.
  RealColumn get pricePerL => real().nullable()();

  RealColumn get odometerKm => real().nullable()();

  /// True when the rider filled the tank completely. Only this case yields an
  /// exact mileage observation.
  BoolColumn get isFull => boolean().withDefault(const Constant(false))();

  /// `reset` assumes [assumedLeftoverL] was already in the tank; `full` sets the
  /// level to tank capacity.
  IntColumn get anchorMode =>
      intEnum<AnchorMode>().withDefault(const Constant(0))();

  /// Level assumed to be in the tank before this fill, in `reset` mode.
  RealColumn get assumedLeftoverL => real().withDefault(const Constant(0.0))();

  TextColumn get notes => text().nullable()();
}
