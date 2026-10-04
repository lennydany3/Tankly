import 'dart:ui' show Offset;

import 'package:flutter/material.dart' show Icons;

import '../domain/fuel.dart';
import 'models.dart';

/// Single source of truth for every number and label in the prototype.
///
/// The fuel figures are not typed in by hand: [fuelNow] and its siblings come
/// out of [FuelEngine.compute], so the gauge, the Live Trip strip, the
/// foreground notification and the refuel preview all agree with the domain
/// rules in `docs/Architecture.md`.
///
/// Worked example this file reproduces (the spec's own unit test):
///   refuel ₹100 = 0.93 L, then 20.0 km ridden
///   0.93 − 20 / 37.5 = 0.397 L left
///   0.397 × 37.5 × 0.90 = 13.4 km of conservative range
abstract final class DemoData {
  /// Fixed "now" so the prototype renders identically on every launch.
  static final now = DateTime(2026, 10, 4, 11, 5);

  static const tankCapacityL = 5.3;
  static const reserveL = 0.8;
  static const safetyFactor = 0.90;
  static const alertL = 0.25;

  static const vehicle = VehicleSpec(
    name: 'Activa 6G',
    tankCapacityL: tankCapacityL,
    reserveL: reserveL,
    defaultMileageKmpl: 37.5,
    learnedMileageKmpl: 37.5,
    safetyFactor: safetyFactor,
    lowFuelThresholdL: alertL,
  );

  static const odometerKm = 18358.0;

  /// Most recent anchor: the tank ran dry and the rider put in exactly ₹100.
  static final anchor = FuelAnchor(
    at: DateTime(2026, 10, 3, 18, 45),
    levelL: 0.93,
    kind: AnchorKind.refuelReset,
  );

  // ---------------------------------------------------------------- rides ---

  static final eveningRide = TripRecord(
    id: 'trip-evening',
    title: 'Evening ride',
    startedAt: DateTime(2026, 10, 3, 19, 12),
    endedAt: DateTime(2026, 10, 3, 19, 53),
    distanceKm: 16.8,
    durationS: 41 * 60,
    movingS: 37 * 60 + 20,
    avgKmph: 24.6,
    maxKmph: 46,
    elevationGainM: 62,
    fuelUsedL: 0.45,
    startLabel: 'Home',
    endLabel: 'Marina',
    route: const [
      Offset(0.12, 0.86),
      Offset(0.18, 0.78),
      Offset(0.14, 0.68),
      Offset(0.22, 0.60),
      Offset(0.34, 0.62),
      Offset(0.40, 0.50),
      Offset(0.36, 0.38),
      Offset(0.48, 0.32),
      Offset(0.62, 0.36),
      Offset(0.70, 0.24),
      Offset(0.82, 0.26),
      Offset(0.88, 0.16),
    ],
  );

  static final marketRun = TripRecord(
    id: 'trip-market',
    title: 'Market run',
    startedAt: DateTime(2026, 10, 4, 7, 40),
    endedAt: DateTime(2026, 10, 4, 7, 51),
    distanceKm: 3.2,
    durationS: 11 * 60,
    movingS: 9 * 60 + 10,
    avgKmph: 17.5,
    maxKmph: 28,
    elevationGainM: 8,
    fuelUsedL: 0.09,
    startLabel: 'Home',
    endLabel: 'Market',
    route: const [
      Offset(0.20, 0.70),
      Offset(0.32, 0.64),
      Offset(0.44, 0.68),
      Offset(0.52, 0.56),
      Offset(0.64, 0.60),
      Offset(0.72, 0.48),
      Offset(0.84, 0.52),
    ],
  );

  static final homeToCollege = TripRecord(
    id: 'trip-college',
    title: 'Home to college',
    startedAt: DateTime(2026, 10, 1, 8, 5),
    endedAt: DateTime(2026, 10, 1, 8, 29),
    distanceKm: 8.4,
    durationS: 24 * 60,
    movingS: 21 * 60,
    avgKmph: 21.0,
    maxKmph: 34,
    elevationGainM: 14,
    fuelUsedL: 0.22,
    startLabel: 'Home',
    endLabel: 'College',
    route: const [
      Offset(0.16, 0.80),
      Offset(0.24, 0.70),
      Offset(0.34, 0.74),
      Offset(0.40, 0.62),
      Offset(0.50, 0.66),
      Offset(0.58, 0.54),
      Offset(0.70, 0.58),
      Offset(0.78, 0.46),
      Offset(0.86, 0.40),
    ],
  );

  static final coastalLoop = TripRecord(
    id: 'trip-coast',
    title: 'Coastal loop',
    startedAt: DateTime(2026, 9, 29, 17, 5),
    endedAt: DateTime(2026, 9, 29, 18, 3),
    distanceKm: 31.4,
    durationS: 58 * 60,
    movingS: 54 * 60,
    avgKmph: 32.5,
    maxKmph: 52,
    elevationGainM: 88,
    fuelUsedL: 0.84,
    startLabel: 'Home',
    endLabel: 'Coastal',
    route: const [
      Offset(0.10, 0.72),
      Offset(0.18, 0.60),
      Offset(0.30, 0.62),
      Offset(0.36, 0.48),
      Offset(0.48, 0.44),
      Offset(0.44, 0.30),
      Offset(0.56, 0.22),
      Offset(0.70, 0.28),
      Offset(0.78, 0.40),
      Offset(0.88, 0.34),
      Offset(0.82, 0.18),
      Offset(0.66, 0.12),
      Offset(0.50, 0.16),
      Offset(0.38, 0.10),
      Offset(0.24, 0.20),
      Offset(0.14, 0.36),
    ],
  );

  /// Newest first, which is the order the timeline renders.
  static final trips = <TripRecord>[
    marketRun,
    eveningRide,
    homeToCollege,
    coastalLoop,
  ];

  /// The fuel engine only ever needs distance and start time.
  static List<RideSample> get rides => [
    for (final trip in trips)
      RideSample(
        startedAt: trip.startedAt,
        endedAt: trip.endedAt,
        distanceKm: trip.distanceKm,
      ),
  ];

  // -------------------------------------------------------------- refuels ---

  static final lastRefuel = RefuelRecord(
    at: DateTime(2026, 10, 3, 18, 45),
    litres: 0.93,
    priceTotal: 100,
    odometerKm: 18338,
  );

  static final refuels = <RefuelRecord>[
    lastRefuel,
    RefuelRecord(
      at: DateTime(2026, 9, 24, 18, 20),
      litres: 1.50,
      priceTotal: 180,
      odometerKm: 18282,
      notes: 'Light came on at 18,280 km.',
    ),
    RefuelRecord(
      at: DateTime(2026, 9, 4, 8, 10),
      litres: 5.30,
      priceTotal: 570,
      odometerKm: 18083,
      isFull: true,
    ),
    RefuelRecord(
      at: DateTime(2026, 8, 26, 19, 5),
      litres: 5.30,
      priceTotal: 570,
      odometerKm: 17884,
      isFull: true,
    ),
    RefuelRecord(
      at: DateTime(2026, 8, 18, 8, 40),
      litres: 5.30,
      priceTotal: 570,
      odometerKm: 17685,
      isFull: true,
    ),
  ];

  // ------------------------------------------------------------ reminders ---

  static const reminders = <ReminderRecord>[
    ReminderRecord(
      kind: ReminderKind.service,
      title: 'PUC',
      urgency: ReminderUrgency.overdue,
      detail: 'Overdue by 3 days',
      icon: Icons.assignment_late_outlined,
    ),
    ReminderRecord(
      kind: ReminderKind.service,
      title: 'Chain lube',
      urgency: ReminderUrgency.dueSoon,
      detail: 'Due in 90 km',
    ),
    ReminderRecord(
      kind: ReminderKind.service,
      title: 'Oil change',
      urgency: ReminderUrgency.ok,
      detail: 'Due in 320 km',
    ),
    ReminderRecord(
      kind: ReminderKind.document,
      title: 'Insurance',
      urgency: ReminderUrgency.dueSoon,
      detail: 'Expires in 12 days',
      icon: Icons.verified_user_outlined,
    ),
    ReminderRecord(
      kind: ReminderKind.document,
      title: 'Driving licence',
      urgency: ReminderUrgency.ok,
      detail: 'Expires in 63 days',
      icon: Icons.badge_outlined,
    ),
  ];

  // ---------------------------------------------------------------- stats ---

  /// Stats are framed on a rolling 30 days, so the totals line up with the
  /// refuel log: 18,046 km → 18,358 km and ₹850 of petrol.
  static const monthDistanceKm = 312.0;
  static const monthRides = 31;
  static const monthSpend = 850.0;
  static const costPerKm = 2.7;

  /// Calendar-month spend for the bar chart. October is four days in.
  static const monthlySpend = <(String, int)>[
    ('Jun', 1140),
    ('Jul', 570),
    ('Aug', 1140),
    ('Sep', 750),
    ('Oct', 100),
  ];

  /// Learned mileage over time, oldest first.
  static const mileageTrend = <(String, double)>[
    ('Jun', 36.2),
    ('Jul', 36.8),
    ('Aug', 37.1),
    ('Sep', 37.3),
    ('Oct', 37.5),
  ];

  /// Cost per km by week, oldest first.
  static const costTrend = <(String, double)>[
    ('W1', 3.1),
    ('W2', 2.9),
    ('W3', 2.8),
    ('W4', 2.7),
    ('W5', 2.7),
  ];

  // ------------------------------------------------------------ ride graphs ---

  /// Speed samples for the Evening ride, km/h, one every two minutes.
  static const eveningSpeed = <double>[
    0, 12, 22, 28, 34, 38, 42, 46, 40, 32, 26, //
    18, 14, 22, 30, 36, 28, 20, 26, 34, 24,
  ];

  /// Index of the fastest sample, marked on the speed graph.
  static const eveningPeakIndex = 7;

  /// Elevation samples for the Evening ride, metres.
  static const eveningElevation = <double>[
    0, 4, 9, 14, 12, 8, 6, 11, 18, 24, 22, //
    17, 14, 19, 26, 31, 27, 21, 25, 30, 26,
  ];

  static const rideTimeLabels = ['0', '10', '20', '30', '40 min'];

  // -------------------------------------------------------- live trip state ---

  static const liveSpeedKmph = 32.0;
  static const liveDistanceKm = 4.7;
  static const liveElapsedS = 12 * 60 + 20;
  static const gpsAccuracyM = 4.0;

  // ----------------------------------------------------------- fuel states ---

  /// Canonical state: right now, on the road.
  static FuelSnapshot get fuelNow => FuelEngine.compute(
    vehicle: vehicle,
    anchor: anchor,
    rides: rides,
    now: now,
  );

  /// A healthy tank, for the Home "normal" state.
  static FuelSnapshot get fuelHealthy => FuelEngine.compute(
    vehicle: vehicle,
    anchor: FuelAnchor(
      at: DateTime(2026, 10, 1, 8, 10),
      levelL: 5.30,
      kind: AnchorKind.refuelFull,
    ),
    rides: const [],
  );

  /// Mid tank, for the gauge component gallery.
  static FuelSnapshot get fuelMedium => FuelEngine.compute(
    vehicle: vehicle,
    anchor: FuelAnchor(
      at: DateTime(2026, 9, 30, 7, 0),
      levelL: 3.00,
      kind: AnchorKind.refuelReset,
    ),
    rides: [
      RideSample(startedAt: DateTime(2026, 9, 30, 12, 0), distanceKm: 37.5),
    ],
  );

  /// At the alert level. Pulses.
  static FuelSnapshot get fuelCritical => FuelEngine.compute(
    vehicle: vehicle,
    anchor: anchor,
    rides: [
      RideSample(startedAt: DateTime(2026, 10, 3, 19, 12), distanceKm: 27.4),
    ],
  );

  /// Live Trip hero state: a little further into the same ride.
  static FuelSnapshot get fuelLive => FuelEngine.compute(
    vehicle: vehicle,
    anchor: anchor,
    rides: [
      RideSample(startedAt: DateTime(2026, 10, 3, 19, 12), distanceKm: 23.3),
    ],
  );

  // ------------------------------------------------------------- formatting ---

  /// Every estimate is prefixed with a tilde. This is the only honest way to
  /// show a derived number.
  static String approx(double value, {int decimals = 2}) {
    return '~${value.toStringAsFixed(decimals)}';
  }

  static String litres(double value, {int decimals = 2}) =>
      '${approx(value, decimals: decimals)} L';

  static String km(double value, {int decimals = 0}) =>
      '${approx(value, decimals: decimals)} km';

  /// `₹2.7` — one decimal, because fuel prices are not round numbers.
  static String rupees(double value, {int decimals = 0}) {
    final fixed = value.toStringAsFixed(decimals);
    final parts = fixed.split('.');
    final grouped = parts.first.replaceAllMapped(
      RegExp(r'(?<=\d)(?=(\d{3})+$)'),
      (_) => ',',
    );
    return parts.length > 1 ? '₹$grouped.${parts[1]}' : '₹$grouped';
  }
}
