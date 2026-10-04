import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/domain/fuel/distance_calibrator.dart';
import 'package:tankly/domain/models/refuel.dart';
import 'package:tankly/domain/reminders/reminder_rules.dart';

void main() {
  group('DistanceCalibrator', () {
    test('a 10 % under-read corrects to about 1.10', () {
      // Real odometer moved 11 km while the phone logged 10 km.
      final factor = DistanceCalibrator.smooth(currentFactor: 1.0, sample: 1.1);
      expect(factor, closeTo(1.03, 0.001));
      expect(factor, lessThanOrEqualTo(1.10));
    });

    test('clamps wild samples instead of trusting them', () {
      expect(DistanceCalibrator.smooth(currentFactor: 1.0, sample: 3.0), 1.10);
      expect(DistanceCalibrator.smooth(currentFactor: 1.0, sample: 0.2), 0.90);
    });

    test('ignores a check with too little GPS behind it', () {
      // 300 m of real riding: too short to calibrate against.
      final factor = DistanceCalibrator.apply(
        currentFactor: 1.02,
        odometerNowKm: 12000.3,
        odometerAtLastCheckKm: 12000,
        gpsKmSinceLastCheck: 0.3,
      );
      expect(factor, 1.02);
    });

    test('a plausible check nudges the factor towards the sample', () {
      // 11 km real against 10 km of GPS.
      final factor = DistanceCalibrator.apply(
        currentFactor: 1.0,
        odometerNowKm: 12011,
        odometerAtLastCheckKm: 12000,
        gpsKmSinceLastCheck: 10,
      );
      expect(factor, closeTo(1.03, 0.001));
    });

    test('an impossible odometer reading is not applied', () {
      final factor = DistanceCalibrator.apply(
        currentFactor: 1.0,
        odometerNowKm: 1000,
        odometerAtLastCheckKm: 12000,
        gpsKmSinceLastCheck: 500,
      );
      expect(factor, 1.0);
    });

    test('estimated odometer scales every past ride', () {
      expect(
        DistanceCalibrator.estimatedOdometerKm(
          odometerStartKm: 10000,
          rawRideDistancesKm: const [12.0, 8.5],
          distanceFactor: 1.1,
        ),
        closeTo(10022.55, 0.001),
      );
    });
  });

  group('ReminderRules service', () {
    final spec = ReminderSpec(
      id: 'oil',
      vehicleId: 'v1',
      kind: ReminderKind.service,
      title: 'Engine oil change',
      dueKm: 12000,
      notifyBeforeKm: 500,
    );

    test('is on track far from the due odometer', () {
      final r = ReminderRules.evaluate(spec: spec, odometerKm: 10000);
      expect(r.urgency, ReminderUrgency.ok);
      expect(r.isActionable, isFalse);
      expect(r.remainingKm, 2000);
      expect(r.subtitle, 'Due in 2000 km');
    });

    test('is due soon inside the notify window', () {
      final r = ReminderRules.evaluate(spec: spec, odometerKm: 11700);
      expect(r.urgency, ReminderUrgency.dueSoon);
      expect(ReminderRules.shouldNotify(r), isTrue);
    });

    test('is overdue past the due odometer and says by how much', () {
      final r = ReminderRules.evaluate(spec: spec, odometerKm: 12350);
      expect(r.urgency, ReminderUrgency.overdue);
      expect(r.subtitle, 'Overdue by 350 km');
    });

    test('reschedules from the last completed service', () {
      final withInterval = spec.copyWith(
        intervalKm: 1000,
        lastDoneKm: 11500,
        notifyBeforeKm: 500,
      );
      expect(withInterval.nextDueKm, 12500);
      final r = ReminderRules.evaluate(spec: withInterval, odometerKm: 11500);
      expect(r.urgency, ReminderUrgency.ok);
      expect(
        ReminderRules.evaluate(spec: withInterval, odometerKm: 12100).urgency,
        ReminderUrgency.dueSoon,
      );
    });

    test('a rule with no due point is inert rather than broken', () {
      final r = ReminderRules.evaluate(
        spec: const ReminderSpec(
          vehicleId: 'v1',
          kind: ReminderKind.service,
          title: 'Chain lubing',
        ),
        odometerKm: 12345,
      );
      expect(r.urgency, ReminderUrgency.ok);
      expect(r.subtitle, contains('Set a due odometer'));
    });
  });

  group('ReminderRules document', () {
    final today = DateTime(2026, 3, 1);

    test('is due soon inside the notify window', () {
      final r = ReminderRules.evaluate(
        spec: ReminderSpec(
          vehicleId: 'v1',
          kind: ReminderKind.document,
          title: 'Insurance',
          dueDate: DateTime(2026, 3, 5),
          notifyBeforeDays: 7,
        ),
        odometerKm: 0,
        now: today,
      );
      expect(r.urgency, ReminderUrgency.dueSoon);
      expect(r.remainingDays, 4);
      expect(r.subtitle, 'Due in 4 days');
    });

    test('is overdue the day after expiry', () {
      final r = ReminderRules.evaluate(
        spec: ReminderSpec(
          vehicleId: 'v1',
          kind: ReminderKind.document,
          title: 'PUC',
          dueDate: DateTime(2026, 2, 27),
          notifyBeforeDays: 7,
        ),
        odometerKm: 0,
        now: today,
      );
      expect(r.urgency, ReminderUrgency.overdue);
      expect(r.subtitle, 'Expired 2 days ago');
    });

    test('a yearly document rolls forward once marked done', () {
      final r = ReminderRules.evaluate(
        spec: ReminderSpec(
          vehicleId: 'v1',
          kind: ReminderKind.document,
          title: 'Insurance',
          dueDate: DateTime(2026, 3, 20),
          intervalDays: 365,
          lastDoneDate: DateTime(2026, 3, 10),
          notifyBeforeDays: 7,
        ),
        odometerKm: 0,
        now: today,
      );
      expect(r.remainingDays, greaterThan(300));
      expect(r.urgency, ReminderUrgency.ok);
    });
  });

  group('ReminderRules set', () {
    final specs = [
      const ReminderSpec(
        id: 'a',
        vehicleId: 'v1',
        kind: ReminderKind.service,
        title: 'Oil',
        dueKm: 10100,
        notifyBeforeKm: 500,
      ),
      const ReminderSpec(
        id: 'b',
        vehicleId: 'v1',
        kind: ReminderKind.service,
        title: 'Tyres',
        dueKm: 10200,
        notifyBeforeKm: 500,
      ),
      ReminderSpec(
        id: 'c',
        vehicleId: 'v1',
        kind: ReminderKind.document,
        title: 'RC',
        dueDate: DateTime(2026, 4, 1),
        notifyBeforeDays: 7,
      ),
    ];

    final now = DateTime(2026, 3, 1);

    test('counts only what needs attention', () {
      // 1100 km and 1200 km out: nothing due yet.
      expect(
        ReminderRules.actionableCount(specs: specs, odometerKm: 9000, now: now),
        0,
      );
      // Oil is 450 km from due: inside its notify window.
      expect(
        ReminderRules.actionableCount(specs: specs, odometerKm: 9650, now: now),
        1,
      );
      // Both services are past due.
      expect(
        ReminderRules.actionableCount(
          specs: specs,
          odometerKm: 10500,
          now: now,
        ),
        2,
      );
    });

    test('orders overdue before due-soon, then by how close', () {
      // Oil is 50 km past due; Tyres is 50 km short of due.
      final due = ReminderRules.dueSoon(
        specs: specs,
        odometerKm: 10150,
        now: now,
      );
      expect(due.map((r) => r.title), ['Oil', 'Tyres']);
    });

    test('uses a stable notification id per rule', () {
      expect(ReminderRules.notificationId(specs.first), 'tankly.reminder.a');
      expect(
        ReminderRules.notificationId(specs.first),
        ReminderRules.notificationId(specs.first),
      );
    });
  });
}
