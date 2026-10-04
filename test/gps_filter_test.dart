import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/core/constants.dart';
import 'package:tankly/domain/tracking/gps_filter.dart';

/// Degrees of latitude per metre, so a fixture can describe a real track.
const degPerMetre = 1 / 111320;

void main() {
  // Shared clock: fixes must arrive in chronological order, so a rejected fix
  // must not advance time or it would invalidate every fix after it.
  var clock = DateTime.utc(2026, 3, 1, 8);
  var start = clock;

  /// Latitude of the last fix handed out, so a hand-written follow-up fix lands
  /// metres from it rather than kilometres.
  var lastLat = 12.9716;

  DateTime t0() => start;

  /// Advances the clock one second and returns a self-consistent moving fix
  /// [metres] north of the previous one.
  FilterVerdict step(GpsFilter f, {double metres = 20, double speedKmh = 20}) {
    clock = clock.add(const Duration(seconds: 1));
    lastLat += metres * degPerMetre;
    return f.add(
      at: clock,
      lat: lastLat,
      lng: 77.5946,
      accuracyM: 5,
      speedMps: speedKmh / 3.6,
    );
  }

  setUp(() {
    clock = DateTime.utc(2026, 3, 1, 8);
    start = clock;
    lastLat = 12.9716;
  });

  group('GpsFilter accuracy gate', () {
    test('drops a fix worse than the accuracy ceiling', () {
      final f = GpsFilter();
      final v = f.add(
        at: t0(),
        lat: 12.9,
        lng: 77.5,
        accuracyM: 120,
        speedMps: 8,
      );
      expect(v.isAccepted, isFalse);
      expect(v.reason, DropReason.poorAccuracy);
    });

    test('drops a fix whose speed accuracy is meaningless', () {
      final f = GpsFilter();
      final v = f.add(
        at: t0(),
        lat: 12.9,
        lng: 77.5,
        accuracyM: 5,
        speedMps: 8,
        speedAccuracyMps: 4,
      );
      expect(v.reason, DropReason.poorSpeedAccuracy);
    });
  });

  group('GpsFilter teleport rejection', () {
    test('a half-kilometre jump in one second is not a ride', () {
      final f = GpsFilter();
      f.add(at: t0(), lat: 12.9716, lng: 77.5946, accuracyM: 5, speedMps: 5);
      final v = f.add(
        at: t0().add(const Duration(seconds: 1)),
        lat: 12.9800,
        lng: 77.5946,
        accuracyM: 5,
        speedMps: 5,
      );
      expect(v.reason, DropReason.impossibleJump);
      expect(f.distanceKm, 0);
    });

    test('a fix arriving out of order is refused', () {
      final f = GpsFilter();
      f.add(at: t0(), lat: 12.9, lng: 77.5, accuracyM: 5, speedMps: 5);
      final v = f.add(
        at: clock.subtract(const Duration(seconds: 30)),
        lat: 12.9,
        lng: 77.5,
        accuracyM: 5,
        speedMps: 8,
      );
      expect(v.reason, DropReason.outOfOrder);
    });
  });

  group('GpsFilter distance', () {
    test('accumulates distance only from accepted moving fixes', () {
      final f = GpsFilter(now: () => clock);
      step(f); // origin: nothing to measure against yet
      for (var i = 0; i < 9; i++) {
        expect(step(f).isAccepted, isTrue, reason: 'fix $i should be accepted');
      }
      expect(f.distanceKm, closeTo(9 * 20 / 1000, 0.002));
    });

    test('a stationary scooter keeps its position and adds nothing', () {
      final f = GpsFilter(now: () => clock);
      step(f);
      clock = clock.add(const Duration(seconds: 3));
      final v = f.add(
        at: clock,
        lat: lastLat + 1 * degPerMetre,
        lng: 77.5946,
        accuracyM: 5,
        speedMps: 0.2,
      );
      expect(v.isAccepted, isTrue);
      expect(v.distanceKm, 0);
      expect(v.point!.isMoving, isFalse);
      expect(f.distanceKm, 0);
    });

    test('a fix too close to the last one in too short a time is skipped', () {
      final f = GpsFilter(now: () => clock);
      step(f);
      clock = clock.add(const Duration(milliseconds: 200));
      final v = f.add(
        at: clock,
        lat: lastLat + 1 * degPerMetre,
        lng: 77.5946,
        accuracyM: 5,
        speedMps: 20 / 3.6,
      );
      expect(v.reason, DropReason.tooClose);
      expect(f.distanceKm, 0);
    });
  });

  group('GpsFilter signal health', () {
    test('reports signal lost only after the hold window', () {
      final f = GpsFilter(now: () => clock);
      step(f);
      expect(f.signalAge, lessThan(Duration(milliseconds: Gps.signalHoldMs)));
      expect(f.isSignalLost, isFalse);

      clock = clock.add(Duration(milliseconds: Gps.signalHoldMs - 500));
      expect(f.isSignalLost, isFalse);

      clock = clock.add(const Duration(milliseconds: 1000));
      expect(f.isSignalLost, isTrue);
      expect(f.hasSignalGap, isFalse);

      clock = clock.add(const Duration(milliseconds: Gps.signalGapMs));
      expect(f.hasSignalGap, isTrue);
    });

    test('smooths the displayed speed but not the stored value', () {
      final f = GpsFilter(now: () => clock);
      final first = f.add(
        at: clock,
        lat: 12.9716,
        lng: 77.5946,
        accuracyM: 5,
        speedMps: 40 / 3.6,
      );
      expect(first.point!.speedKmh, closeTo(40, 0.001));

      final second = step(f, speedKmh: 10);
      // Raw speed is kept exactly as reported.
      expect(second.point!.speedKmh, closeTo(10, 0.001));
      // The readout lags rather than jumping.
      expect(f.displayedSpeedKmh, greaterThan(10));
      expect(f.displayedSpeedKmh, lessThan(40));
    });
  });
}
