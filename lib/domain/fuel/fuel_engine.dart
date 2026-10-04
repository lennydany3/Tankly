import 'dart:math' as math;

import 'package:tankly/core/constants.dart';
import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/domain/models/trip.dart';
import 'package:tankly/domain/models/vehicle.dart';

/// Pure fuel arithmetic. No Flutter, no database, no network.
///
/// Fuel is **derived, never stored**. The app keeps a history of events and
/// recomputes the level from scratch on every read, so correcting one refuel
/// automatically fixes everything after it.
///
/// ```
/// fuel_used_l = (raw_distance_km x distance_factor) / mileage_kmpl
/// litres_left = max(0, anchor_level - sum(fuel_used_l))
/// range_km    = litres_left x mileage_kmpl x safety_factor
/// ```
abstract final class FuelEngine {
  /// Recomputes fuel from the latest anchor plus the rides since it.
  ///
  /// [liveTripKm] is the raw distance of the ride being recorded right now, so
  /// the gauge moves while riding rather than snapping when the trip is saved.
  static FuelSnapshot compute({
    required VehicleSpec vehicle,
    required FuelAnchor anchor,
    Iterable<RideSample> rides = const [],
    double liveTripKm = 0,
    DateTime? now,
  }) {
    final cutoff = now ?? anchor.at;

    final kmSinceAnchor = rides
        .where(
          (r) => r.startedAt.isAfter(anchor.at) && !r.startedAt.isAfter(cutoff),
        )
        .fold<double>(0, (sum, r) => sum + r.distanceKm);

    final mileage = vehicle.mileageKmpl;
    final usedL =
        ((kmSinceAnchor + liveTripKm) * vehicle.distanceFactor) / mileage;
    final litresLeft = math.max(0.0, anchor.levelL - usedL);
    final capacity = vehicle.tankCapacityL;

    return FuelSnapshot(
      litresLeft: litresLeft,
      rangeKm: litresLeft * mileage * vehicle.safetyFactor,
      fillRatio: capacity <= 0 ? 0 : (litresLeft / capacity).clamp(0.0, 1.0),
      reserveRatio: vehicle.reserveRatio,
      status: statusFor(
        litres: litresLeft,
        capacity: capacity,
        thresholdL: vehicle.lowFuelThresholdL,
      ),
      anchor: anchor,
      kmSinceAnchor: kmSinceAnchor,
      liveTripKm: liveTripKm,
      mileageKmpl: mileage,
    );
  }

  /// Picks the anchor that wins when refuels and fuel events both exist.
  ///
  /// The most recent one does, always (system design 2). Ties go to the fuel
  /// event: it was observed by a human looking at the scooter, so it is the more
  /// trustworthy of the two facts.
  static FuelAnchor latestAnchor({
    required VehicleSpec vehicle,
    Iterable<FuelAnchor> refuels = const [],
    Iterable<FuelAnchor> events = const [],
  }) {
    final all = [...refuels, ...events];
    if (all.isEmpty) {
      // A vehicle with no anchor at all is assumed to have been filled up, so
      // the app opens showing a full-ish tank rather than a bogus zero.
      return FuelAnchor(
        at: DateTime.fromMillisecondsSinceEpoch(0),
        levelL: vehicle.tankCapacityL,
        kind: AnchorKind.refuelFull,
      );
    }
    final sorted = [...all]
      ..sort((a, b) {
        final byTime = b.at.compareTo(a.at);
        return byTime != 0 ? byTime : b.kind.index.compareTo(a.kind.index);
      });
    return sorted.first;
  }

  /// Thresholds: above 50 % good, 25-50 % medium, below 25 % low, at or below
  /// the alert level critical. Critical wins over the percentage bands.
  static FuelStatus statusFor({
    required double litres,
    required double capacity,
    required double thresholdL,
  }) {
    if (litres <= thresholdL) return FuelStatus.critical;
    if (capacity <= 0) return FuelStatus.low;
    final ratio = litres / capacity;
    if (ratio > Bands.goodRatio) return FuelStatus.good;
    if (ratio >= Bands.mediumRatio) return FuelStatus.medium;
    return FuelStatus.low;
  }

  /// Fuel burned by one ride, for the "fuel used" tile on trip detail.
  static double fuelUsedL(double distanceKm, VehicleSpec vehicle) =>
      (distanceKm * vehicle.distanceFactor) / vehicle.mileageKmpl;

  /// How many litres are left, and nothing else.
  ///
  /// Used by the reminder rules and the low-fuel alert, which do not care about
  /// range or gauge geometry.
  static double litresLeft({
    required VehicleSpec vehicle,
    required FuelAnchor anchor,
    Iterable<RideSample> rides = const [],
    double liveTripKm = 0,
    DateTime? now,
  }) => compute(
    vehicle: vehicle,
    anchor: anchor,
    rides: rides,
    liveTripKm: liveTripKm,
    now: now,
  ).litresLeft;
}
