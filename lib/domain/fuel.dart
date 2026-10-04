import 'dart:math' as math;

/// Fuel status. This is Tankly's colour language: green, yellow, orange and red
/// are reserved for these four values and are never used decoratively.
enum FuelStatus {
  /// Above 50 % of tank capacity.
  good,

  /// Between 25 % and 50 %.
  medium,

  /// Below 25 %.
  low,

  /// At or below the configured alert level. Pulses.
  critical,
}

/// Human label. Always rendered next to the number so state never depends on
/// colour alone.
extension FuelStatusLabel on FuelStatus {
  String get label => switch (this) {
    FuelStatus.good => 'Good',
    FuelStatus.medium => 'Medium',
    FuelStatus.low => 'Low',
    FuelStatus.critical => 'Critical',
  };
}

/// The kind of event that pins a known fuel level at a moment in time.
///
/// Fuel is never stored as an editable number. It is derived from the most
/// recent anchor minus the fuel burned by trips since.
enum AnchorKind {
  /// A refuel in `reset` mode: level is `litresAdded + assumedLeftover`.
  refuelReset,

  /// A refuel marked full: level is tank capacity.
  refuelFull,

  /// The reserve light came on.
  reserveLight,

  /// The scooter ran dry.
  ranDry,

  /// The scooter was still running after the estimate hit zero.
  stillRunning,
}

/// A moment in time at which the fuel level is known.
class FuelAnchor {
  const FuelAnchor({
    required this.at,
    required this.levelL,
    required this.kind,
  });

  final DateTime at;
  final double levelL;
  final AnchorKind kind;
}

/// Vehicle configuration. Mirrors the `vehicles` table.
class VehicleSpec {
  const VehicleSpec({
    this.name = 'Activa 6G',
    this.tankCapacityL = 5.3,
    this.reserveL = 0.8,
    this.defaultMileageKmpl = 37.5,
    this.learnedMileageKmpl,
    this.distanceFactor = 1.0,
    this.safetyFactor = 0.90,
    this.lowFuelThresholdL = 0.25,
  });

  final String name;
  final double tankCapacityL;
  final double reserveL;
  final double defaultMileageKmpl;
  final double? learnedMileageKmpl;
  final double distanceFactor;
  final double safetyFactor;
  final double lowFuelThresholdL;

  /// Learned value wins; the vehicle default is the cold-start fallback.
  double get mileageKmpl => learnedMileageKmpl ?? defaultMileageKmpl;

  /// Mileage after the safety margin is applied. Range is quoted with this so
  /// the rider is warned early rather than stranded.
  double get safeMileageKmpl => mileageKmpl * safetyFactor;
}

/// A completed or in-progress ride, reduced to what the fuel maths needs.
class RideSample {
  const RideSample({
    required this.startedAt,
    required this.distanceKm,
    this.endedAt,
  });

  final DateTime startedAt;
  final DateTime? endedAt;
  final double distanceKm;
}

/// The derived fuel state the UI renders. Never persisted.
class FuelSnapshot {
  const FuelSnapshot({
    required this.litresLeft,
    required this.rangeKm,
    required this.fillRatio,
    required this.reserveRatio,
    required this.status,
    required this.anchor,
    required this.kmSinceAnchor,
    required this.mileageKmpl,
  });

  final double litresLeft;
  final double rangeKm;

  /// 0–1 of tank capacity. Drives the gauge arc.
  final double fillRatio;

  /// Position of the reserve notch, 0–1 of tank capacity.
  final double reserveRatio;

  final FuelStatus status;
  final FuelAnchor anchor;
  final double kmSinceAnchor;
  final double mileageKmpl;

  bool get isEstimated => true;
}

/// Pure fuel arithmetic. No Flutter, no database, no network.
abstract final class FuelEngine {
  /// Recomputes fuel from scratch.
  ///
  /// Correcting any single event automatically fixes everything after it,
  /// which is the whole reason fuel is derived rather than stored.
  static FuelSnapshot compute({
    required VehicleSpec vehicle,
    required FuelAnchor anchor,
    required Iterable<RideSample> rides,
    DateTime? now,
  }) {
    final cutoff = now ?? anchor.at;
    final kmSinceAnchor = rides
        .where(
          (r) => r.startedAt.isAfter(anchor.at) && !r.startedAt.isAfter(cutoff),
        )
        .fold<double>(0, (sum, r) => sum + r.distanceKm);

    final mileage = vehicle.mileageKmpl;
    final usedL = (kmSinceAnchor * vehicle.distanceFactor) / mileage;
    final litresLeft = math.max(0.0, anchor.levelL - usedL);
    final rangeKm = litresLeft * mileage * vehicle.safetyFactor;
    final capacity = vehicle.tankCapacityL;

    return FuelSnapshot(
      litresLeft: litresLeft,
      rangeKm: rangeKm,
      fillRatio: (litresLeft / capacity).clamp(0.0, 1.0),
      reserveRatio: (vehicle.reserveL / capacity).clamp(0.0, 1.0),
      status: statusFor(
        litres: litresLeft,
        capacity: capacity,
        thresholdL: vehicle.lowFuelThresholdL,
      ),
      anchor: anchor,
      kmSinceAnchor: kmSinceAnchor,
      mileageKmpl: mileage,
    );
  }

  /// Thresholds: above 50 % good, 25–50 % medium, below 25 % low, at or below
  /// the alert level critical. Critical wins over the percentage bands.
  static FuelStatus statusFor({
    required double litres,
    required double capacity,
    required double thresholdL,
  }) {
    if (litres <= thresholdL) return FuelStatus.critical;
    final ratio = capacity <= 0 ? 0.0 : litres / capacity;
    if (ratio > 0.5) return FuelStatus.good;
    if (ratio >= 0.25) return FuelStatus.medium;
    return FuelStatus.low;
  }

  /// Fuel burned by a ride, for the "fuel used" tile on trip detail.
  static double fuelUsedL(double distanceKm, VehicleSpec vehicle) {
    return (distanceKm * vehicle.distanceFactor) / vehicle.mileageKmpl;
  }
}

/// Exponential moving average over observed mileage at refuel time.
///
/// Guards, all documented in the system design:
/// * ignore anything under [minDistanceKm]
/// * ignore outliers more than [outlierTolerance] from the current value
/// * clamp the result into `[minKmpl, maxKmpl]`
abstract final class MileageLearner {
  static const minDistanceKm = 15.0;
  static const minKmpl = 25.0;
  static const maxKmpl = 55.0;
  static const outlierTolerance = 0.30;
  static const learningRate = 0.30;

  static double update({
    required double currentKmpl,
    required double kmSincePrevRefuel,
    required double litresBurned,
  }) {
    if (kmSincePrevRefuel < minDistanceKm) return currentKmpl;
    if (litresBurned <= 0) return currentKmpl;

    final observed = kmSincePrevRefuel / litresBurned;
    if ((observed - currentKmpl).abs() / currentKmpl > outlierTolerance) {
      return currentKmpl;
    }
    final next = (1 - learningRate) * currentKmpl + learningRate * observed;
    return next.clamp(minKmpl, maxKmpl);
  }
}
