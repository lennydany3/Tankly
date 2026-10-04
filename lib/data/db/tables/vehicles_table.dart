import 'package:drift/drift.dart';
import 'package:tankly/core/constants.dart';

import 'sync_columns.dart';

/// The scooter. Exactly one row has `is_active`, and it is the vehicle every
/// fuel calculation uses.
class Vehicles extends Table with SyncColumns {
  @override
  String get tableName => 'vehicles';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get name => text().withLength(min: 1, max: 60)();

  RealColumn get tankCapacityL =>
      real().withDefault(const Constant(Fuel.defaultTankCapacityL))();

  /// Litres kept in reserve. Below this the gauge shows the reserve notch and
  /// the range estimate is not trusted.
  RealColumn get reserveL =>
      real().withDefault(const Constant(Fuel.defaultReserveL))();

  /// Cold-start mileage. Used until [learnedMileageKmpl] exists.
  RealColumn get defaultMileageKmpl =>
      real().withDefault(const Constant(Fuel.defaultMileageKmpl))();

  /// Filled in by `MileageLearner` at refuel time.
  RealColumn get learnedMileageKmpl => real().nullable()();

  /// Corrects systematic GPS distance error, learned from odometer checks.
  /// Clamped to `[Odometer.minFactor, Odometer.maxFactor]`.
  RealColumn get distanceFactor => real().withDefault(const Constant(1.0))();

  /// Range is quoted at `mileage x safetyFactor`.
  RealColumn get safetyFactor =>
      real().withDefault(const Constant(Fuel.defaultSafetyFactor))();

  RealColumn get lowFuelThresholdL =>
      real().withDefault(const Constant(Fuel.defaultLowThresholdL))();

  /// Real odometer at setup. The basis for the estimated odometer.
  RealColumn get odometerStartKm => real().withDefault(const Constant(0.0))();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
