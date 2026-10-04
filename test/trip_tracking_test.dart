import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/domain/models/trip.dart';
import 'package:tankly/domain/tracking/distance_calculator.dart';
import 'package:tankly/domain/tracking/gps_filter.dart';
import 'package:tankly/domain/tracking/trip_state_machine.dart';

/// Degrees of latitude per metre, so a test can describe a real track.
const degPerMetre = 1 / 111320;

void main() {
  final t0 = DateTime.utc(2026, 3, 1, 8);

  /// Replays a straight north-bound track at [metresPerSecond].
  List<TrackPoint> track({
    required DateTime start,
    required int samples,
    required double metresPerSecond,
    double speedKmh = 36,
  }) => [
    for (var i = 0; i < samples; i++)
      TrackPoint(
        at: start.add(Duration(milliseconds: (i * 1000).round())),
        lat: 12.9716 + i * metresPerSecond * degPerMetre,
        lng: 77.5946,
        speedMps: speedKmh / 3.6,
        accuracyM: 5,
        isMoving: true,
      ),
  ];

  group('DistanceCalculator', () {
    test('sums the raw distance of the points it is given', () {
      final calc = DistanceCalculator(startedAt: t0);
      for (final p in track(start: t0, samples: 31, metresPerSecond: 10)) {
        calc.add(p);
      }
      final s = calc.summarise();
      expect(s.distanceKm, closeTo(0.300, 0.01));
      expect(s.movingDuration, const Duration(seconds: 30));
      expect(s.maxSpeedKmh, closeTo(36, 0.01));
      expect(s.avgSpeedKmh, closeTo(36, 0.5));
      expect(s.movingRatio, closeTo(1, 0.001));
    });

    test('separates moving time from idle time', () {
      final calc = DistanceCalculator(startedAt: t0);
      calc.add(
        TrackPoint(
          at: t0,
          lat: 12.9716,
          lng: 77.5946,
          speedMps: 0,
          isMoving: false,
        ),
      );
      calc.add(
        TrackPoint(
          at: t0.add(const Duration(minutes: 4)),
          lat: 12.9716,
          lng: 77.5946,
          speedMps: 0,
          isMoving: false,
        ),
      );
      calc.add(
        TrackPoint(
          at: t0.add(const Duration(minutes: 4, seconds: 30)),
          lat: 12.9721,
          lng: 77.5946,
          speedMps: 6,
          isMoving: true,
        ),
      );
      final s = calc.summarise();
      expect(s.idleDuration, const Duration(minutes: 4));
      expect(s.movingDuration, const Duration(seconds: 30));
      expect(s.duration, const Duration(minutes: 4, seconds: 30));
      expect(s.movingRatio, closeTo(30 / 270, 0.001));
    });

    test(
      'never stores a corrected total, so odometer checks stay retroactive',
      () {
        final calc = DistanceCalculator(startedAt: t0);
        for (final p in track(start: t0, samples: 11, metresPerSecond: 10)) {
          calc.add(p);
        }
        expect(calc.summarise().distanceKm, closeTo(0.1, 0.005));
      },
    );

    test('refuses to call a dropped pocket a trip', () {
      final calc = DistanceCalculator(startedAt: t0);
      calc.add(
        TrackPoint(
          at: t0,
          lat: 12.9716,
          lng: 77.5946,
          speedMps: 1,
          isMoving: true,
        ),
      );
      calc.add(
        TrackPoint(
          at: t0.add(const Duration(seconds: 30)),
          lat: 12.97168,
          lng: 77.5946,
          speedMps: 1,
          isMoving: true,
        ),
      );
      expect(calc.isWorthSaving, isFalse);
      expect(calc.summarise().distanceKm, lessThan(0.05));
    });

    test('keeps a 20 minute ride', () {
      final calc = DistanceCalculator(startedAt: t0);
      for (final p in track(start: t0, samples: 1201, metresPerSecond: 10)) {
        calc.add(p);
      }
      expect(calc.isWorthSaving, isTrue);
      expect(calc.summarise().distanceKm, closeTo(12.0, 0.1));
    });
  });

  group('TripStateMachine', () {
    TripStateMachine machineAt(DateTime start) =>
        TripStateMachine(clock: () => start);

    test('a fresh trip starts as too short, not as a saved ride', () {
      final m = machineAt(t0);
      final s = m.start();
      expect(s.phase, RecorderPhase.tooShort);
      expect(s.shouldPromptSave, isTrue);
      expect(s.distanceKm, 0);
    });

    test('keeps the trip in tooShort while the distance gate is unmet', () {
      final m = machineAt(t0);
      m.start();
      final filter = GpsFilter(now: () => t0);
      for (var i = 0; i < 5; i++) {
        final at = t0.add(Duration(seconds: i));
        m.onVerdict(
          filter.add(
            at: at,
            lat: 12.9716 + i * 10 * degPerMetre,
            lng: 77.5946,
            accuracyM: 5,
            speedMps: 36 / 3.6,
          ),
        );
      }
      expect(m.state.phase, RecorderPhase.tooShort);
      expect(m.finish(), isNotNull);
    });

    test('reports signal loss when the fixes stop arriving', () {
      var now = t0;
      final m = TripStateMachine(clock: () => now);
      m.start();
      final filter = GpsFilter(now: () => now);
      for (var i = 0; i < 40; i++) {
        now = t0.add(Duration(seconds: i * 10));
        m.onVerdict(
          filter.add(
            at: now,
            lat: 12.9716 + i * 100 * degPerMetre,
            lng: 77.5946,
            accuracyM: 5,
            speedMps: 36 / 3.6,
          ),
        );
      }
      expect(m.state.phase, RecorderPhase.riding);

      now = now.add(const Duration(seconds: 40));
      final s = m.tick(now);
      expect(s.phase, RecorderPhase.signalLost);
      expect(s.since, isTrue);
      expect(s.hasSignal, isFalse);
    });

    test('finish returns the summary and closes the trip', () {
      var now = t0;
      final m = TripStateMachine(clock: () => now);
      m.start();
      final filter = GpsFilter(now: () => now);
      for (var i = 0; i < 130; i++) {
        now = t0.add(Duration(seconds: i * 10));
        m.onVerdict(
          filter.add(
            at: now,
            lat: 12.9716 + i * 100 * degPerMetre,
            lng: 77.5946,
            accuracyM: 5,
            speedMps: 36 / 3.6,
          ),
        );
      }
      final summary = m.finish(now);
      expect(summary, isNotNull);
      expect(summary!.distanceKm, greaterThan(1));
      expect(m.state.phase, RecorderPhase.idle);
      expect(m.state.reason, RecorderReason.saved);
    });
  });
}
