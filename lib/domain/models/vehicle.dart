import 'package:tankly/core/constants.dart';

/// Vehicle configuration. Mirrors the `vehicles` table.
///
/// Every field here has a default from `core/constants.dart` so a half-filled
/// setup form still produces a usable estimate rather than a division by zero.
class VehicleSpec {
  const VehicleSpec({
    this.id,
    this.name = 'Activa 6G',
    this.tankCapacityL = Fuel.defaultTankCapacityL,
    this.reserveL = Fuel.defaultReserveL,
    this.defaultMileageKmpl = Fuel.defaultMileageKmpl,
    this.learnedMileageKmpl,
    this.distanceFactor = 1.0,
    this.safetyFactor = Fuel.defaultSafetyFactor,
    this.lowFuelThresholdL = Fuel.defaultLowThresholdL,
    this.odometerStartKm,
    this.isActive = true,
  });

  final String? id;
  final String name;
  final double tankCapacityL;
  final double reserveL;

  /// Cold-start mileage, and the fallback whenever [learnedMileageKmpl] is null.
  final double defaultMileageKmpl;

  /// Filled in by `MileageLearner` at refuel time. Null until then.
  final double? learnedMileageKmpl;

  /// Scales raw GPS distance. Learned from odometer checks, clamped to
  /// `[Odometer.minFactor, Odometer.maxFactor]`.
  final double distanceFactor;

  /// Range is quoted at `mileage × safetyFactor`: warn early rather than strand.
  final double safetyFactor;

  /// At or below this the gauge is critical and the low-fuel alert fires.
  final double lowFuelThresholdL;

  /// Real odometer at the moment this vehicle was set up.
  final double? odometerStartKm;

  final bool isActive;

  /// Learned value wins; the vehicle default is the cold-start fallback.
  double get mileageKmpl => learnedMileageKmpl ?? defaultMileageKmpl;

  /// Mileage after the safety margin is applied.
  double get safeMileageKmpl => mileageKmpl * safetyFactor;

  /// Where the reserve notch sits on the gauge arc, 0-1.
  double get reserveRatio =>
      tankCapacityL <= 0 ? 0 : (reserveL / tankCapacityL).clamp(0.0, 1.0);

  /// Distance the tank has covered at full, ignoring the safety factor.
  double get fullRangeKm => tankCapacityL * mileageKmpl;

  VehicleSpec copyWith({
    String? id,
    String? name,
    double? tankCapacityL,
    double? reserveL,
    double? defaultMileageKmpl,
    double? learnedMileageKmpl,
    bool clearLearnedMileage = false,
    double? distanceFactor,
    double? safetyFactor,
    double? lowFuelThresholdL,
    double? odometerStartKm,
    bool? isActive,
  }) => VehicleSpec(
    id: id ?? this.id,
    name: name ?? this.name,
    tankCapacityL: tankCapacityL ?? this.tankCapacityL,
    reserveL: reserveL ?? this.reserveL,
    defaultMileageKmpl: defaultMileageKmpl ?? this.defaultMileageKmpl,
    learnedMileageKmpl: clearLearnedMileage
        ? null
        : (learnedMileageKmpl ?? this.learnedMileageKmpl),
    distanceFactor: distanceFactor ?? this.distanceFactor,
    safetyFactor: safetyFactor ?? this.safetyFactor,
    lowFuelThresholdL: lowFuelThresholdL ?? this.lowFuelThresholdL,
    odometerStartKm: odometerStartKm ?? this.odometerStartKm,
    isActive: isActive ?? this.isActive,
  );

  @override
  bool operator ==(Object other) =>
      other is VehicleSpec &&
      other.id == id &&
      other.name == name &&
      other.tankCapacityL == tankCapacityL &&
      other.reserveL == reserveL &&
      other.defaultMileageKmpl == defaultMileageKmpl &&
      other.learnedMileageKmpl == learnedMileageKmpl &&
      other.distanceFactor == distanceFactor &&
      other.safetyFactor == safetyFactor &&
      other.lowFuelThresholdL == lowFuelThresholdL &&
      other.odometerStartKm == odometerStartKm &&
      other.isActive == isActive;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    tankCapacityL,
    reserveL,
    defaultMileageKmpl,
    learnedMileageKmpl,
    distanceFactor,
    safetyFactor,
    lowFuelThresholdL,
    odometerStartKm,
    isActive,
  );
}
