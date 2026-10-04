import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/domain/fuel/fuel_engine.dart';
import 'package:tankly/domain/fuel/mileage_learner.dart';
import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/domain/models/vehicle.dart';
import 'package:tankly/domain/models/trip.dart';

/// The worked example from `docs/Design.md`, which the whole UI hangs off.
///
///   refuel ₹100 = 0.93 L, then 20.0 km ridden
///   0.93 - 20 / 37.5 = 0.397 L left
///   0.397 x 37.5 x 0.90 = 13.4 km of conservative range
void main() {
  const vehicle = VehicleSpec();
  final anchor = FuelAnchor(
    at: DateTime(2026, 10, 3, 18, 45),
    levelL: 0.93,
    kind: AnchorKind.refuelReset,
  );
  final rides = [
    RideSample(startedAt: DateTime(2026, 10, 3, 19, 12), distanceKm: 16.8),
    RideSample(startedAt: DateTime(2026, 10, 4, 7, 40), distanceKm: 3.2),
  ];

  group('FuelEngine.compute', () {
    test('derives litres left, range and status from the anchor', () {
      final snapshot = FuelEngine.compute(
        vehicle: vehicle,
        anchor: anchor,
        rides: rides,
        now: DateTime(2026, 10, 4, 11, 5),
      );

      expect(snapshot.kmSinceAnchor, closeTo(20.0, 0.0001));
      expect(snapshot.litresLeft, closeTo(0.3967, 0.001));
      expect(snapshot.rangeKm, closeTo(13.39, 0.02));
      expect(snapshot.status, FuelStatus.low);
    });

    test('applies the distance factor before dividing by mileage', () {
      final skewed = const VehicleSpec(distanceFactor: 1.08);
      final snapshot = FuelEngine.compute(
        vehicle: skewed,
        anchor: anchor,
        rides: rides,
        now: DateTime(2026, 10, 4, 11, 5),
      );

      expect(snapshot.litresLeft, lessThan(0.3967));
    });

    test('ignores rides that started before the anchor', () {
      final snapshot = FuelEngine.compute(
        vehicle: vehicle,
        anchor: anchor,
        rides: [
          RideSample(startedAt: DateTime(2026, 10, 1), distanceKm: 400),
          ...rides,
        ],
        now: DateTime(2026, 10, 4, 11, 5),
      );

      expect(snapshot.litresLeft, closeTo(0.3967, 0.001));
    });

    test('ignores rides dated after now', () {
      final snapshot = FuelEngine.compute(
        vehicle: vehicle,
        anchor: anchor,
        rides: [
          ...rides,
          RideSample(startedAt: DateTime(2026, 10, 5), distanceKm: 120),
        ],
        now: DateTime(2026, 10, 4, 11, 5),
      );

      expect(snapshot.litresLeft, closeTo(0.3967, 0.001));
    });

    test('never reports a negative level once the tank is empty', () {
      final snapshot = FuelEngine.compute(
        vehicle: vehicle,
        anchor: anchor,
        rides: [
          RideSample(startedAt: DateTime(2026, 10, 3, 19), distanceKm: 500),
        ],
        now: DateTime(2026, 10, 4, 11, 5),
      );

      expect(snapshot.litresLeft, 0);
      expect(snapshot.rangeKm, 0);
      expect(snapshot.fillRatio, 0);
      expect(snapshot.status, FuelStatus.critical);
    });

    test('a full tank with no rides is Good', () {
      final snapshot = FuelEngine.compute(
        vehicle: vehicle,
        anchor: FuelAnchor(
          at: DateTime(2026, 10, 1, 8, 10),
          levelL: 5.30,
          kind: AnchorKind.refuelFull,
        ),
        rides: const [],
      );

      expect(snapshot.litresLeft, 5.30);
      expect(snapshot.fillRatio, 1.0);
      expect(snapshot.status, FuelStatus.good);
      expect(snapshot.reserveRatio, closeTo(0.8 / 5.3, 0.0001));
    });
  });

  group('FuelEngine.statusFor', () {
    test('critical wins over low once the alert level is crossed', () {
      expect(
        FuelEngine.statusFor(litres: 0.24, capacity: 5.3, thresholdL: 0.25),
        FuelStatus.critical,
      );
      expect(
        FuelEngine.statusFor(litres: 0.30, capacity: 5.3, thresholdL: 0.25),
        FuelStatus.low,
      );
    });

    test('a full tank in a tiny vehicle is still Good', () {
      expect(
        FuelEngine.statusFor(litres: 0.80, capacity: 0.80, thresholdL: 0.25),
        FuelStatus.good,
      );
    });
  });

  group('MileageLearner', () {
    test('blends an observed figure into the current one', () {
      // 100 km on 2.5 L is 40 km/L; blended 70 % old, 30 % new.
      final next = MileageLearner.update(
        currentKmpl: 37.5,
        kmSincePrevRefuel: 100,
        litresBurned: 2.5,
      );

      expect(next, closeTo(38.25, 0.001));
    });

    test('refuses implausible observations', () {
      final next = MileageLearner.update(
        currentKmpl: 37.5,
        kmSincePrevRefuel: 30,
        litresBurned: 4,
      );

      expect(next, 37.5);
    });
  });
}
