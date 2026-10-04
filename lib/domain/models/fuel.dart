import 'package:tankly/core/constants.dart';
import 'package:tankly/domain/models/vehicle.dart';

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
    this.id,
  });

  final DateTime at;
  final double levelL;
  final AnchorKind kind;

  /// Database id, when this anchor came from a row rather than a test.
  final String? id;

  /// How the level for this anchor kind is arrived at (system design 2).
  ///
  /// Kept as a static rule rather than a constructor argument so a refuel row
  /// and a fuel-event row can never disagree about what "full" means.
  static FuelAnchor forRefuel({
    required VehicleSpec vehicle,
    required DateTime at,
    required double litresAdded,
    required bool isFull,
    double assumedLeftoverL = Fuel.defaultLeftoverL,
    String? id,
  }) => FuelAnchor(
    at: at,
    levelL: isFull ? vehicle.tankCapacityL : litresAdded + assumedLeftoverL,
    kind: isFull ? AnchorKind.refuelFull : AnchorKind.refuelReset,
    id: id,
  );

  static FuelAnchor reserveLight(
    VehicleSpec vehicle,
    DateTime at, {
    String? id,
  }) => FuelAnchor(
    at: at,
    levelL: vehicle.reserveL,
    kind: AnchorKind.reserveLight,
    id: id,
  );

  static FuelAnchor ranDry(DateTime at, {String? id}) =>
      FuelAnchor(at: at, levelL: 0, kind: AnchorKind.ranDry, id: id);

  static FuelAnchor stillRunning(DateTime at, {String? id}) => FuelAnchor(
    at: at,
    levelL: Fuel.stillRunningBonusL,
    kind: AnchorKind.stillRunning,
    id: id,
  );

  @override
  bool operator ==(Object other) =>
      other is FuelAnchor &&
      other.at == at &&
      other.levelL == levelL &&
      other.kind == kind;

  @override
  int get hashCode => Object.hash(at, levelL, kind);
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
    this.liveTripKm = 0,
  });

  final double litresLeft;
  final double rangeKm;

  /// 0-1 of tank capacity. Drives the gauge arc.
  final double fillRatio;

  /// Position of the reserve notch, 0-1 of tank capacity.
  final double reserveRatio;

  final FuelStatus status;
  final FuelAnchor anchor;

  /// Raw GPS km from completed trips since the anchor.
  final double kmSinceAnchor;

  /// Raw GPS km from the trip currently being recorded.
  final double liveTripKm;

  final double mileageKmpl;

  /// Litres the estimate has burned since the anchor. Can exceed the anchor
  /// level, which is exactly the "ran past empty" case the still-running button
  /// exists for.
  double get usedL => anchor.levelL - litresLeft;

  /// Always true. There is no stored number anywhere in the app, so every figure
  /// on screen is an estimate and the UI says so with a tilde.
  bool get isEstimated => true;

  @override
  bool operator ==(Object other) =>
      other is FuelSnapshot &&
      other.litresLeft == litresLeft &&
      other.rangeKm == rangeKm &&
      other.anchor == anchor;

  @override
  int get hashCode => Object.hash(litresLeft, rangeKm, anchor);
}
