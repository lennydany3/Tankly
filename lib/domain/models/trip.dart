/// Lifecycle of a recorded ride (system design 7.1).
///
/// `recording` is what a live trip writes. If the process dies, the row stays
/// `recording`; on next launch the app marks it `interrupted` and asks whether
/// to resume or finish it.
enum TripStatus {
  recording,
  completed,
  interrupted;

  String get wire => name;

  static TripStatus parse(String raw) => TripStatus.values.firstWhere(
    (s) => s.name == raw,
    orElse: () => TripStatus.completed,
  );
}

/// A ride reduced to what the fuel maths needs.
///
/// This is deliberately smaller than a stored trip: the engine only ever asks
/// "when did it start and how far did it go".
class RideSample {
  const RideSample({
    required this.startedAt,
    required this.distanceKm,
    this.endedAt,
    this.id,
  });

  final String? id;
  final DateTime startedAt;
  final DateTime? endedAt;

  /// Raw GPS distance, uncorrected. `distanceFactor` is applied at read time.
  final double distanceKm;

  /// True when the ride ended after [cutoff] but started before it. Such a ride
  /// contributes nothing: a trip that is still going cannot have burned a
  /// predictable amount of fuel yet.
  bool isFinishedBefore(DateTime cutoff) =>
      endedAt == null || !endedAt!.isAfter(cutoff);

  @override
  String toString() =>
      'RideSample(${distanceKm.toStringAsFixed(2)} km from '
      '${startedAt.toIso8601String()})';
}

/// One accepted GPS fix, after filtering.
///
/// Pure Dart so the recorder can be replayed from a recorded track in a test
/// with no platform channel involved.
class TrackPoint {
  const TrackPoint({
    required this.at,
    required this.lat,
    required this.lng,
    this.altitudeM,
    this.speedMps = 0,
    this.accuracyM = 0,
    this.speedAccuracyMps,
    this.isMoving = true,
  });

  final DateTime at;
  final double lat;
  final double lng;
  final double? altitudeM;
  final double speedMps;
  final double accuracyM;
  final double? speedAccuracyMps;
  final bool isMoving;

  double get speedKmh => speedMps * 3.6;

  /// What sync stores in `route_gz`: the polyline plus a coarse speed series.
  Map<String, Object?> toWire() => {
    't': at.toUtc().millisecondsSinceEpoch,
    'lat': lat,
    'lng': lng,
    if (altitudeM != null) 'alt': altitudeM,
    's': (speedKmh * 10).round() / 10,
  };

  static TrackPoint fromWire(Map<String, Object?> json) => TrackPoint(
    at: DateTime.fromMillisecondsSinceEpoch(
      (json['t']! as num).toInt(),
      isUtc: true,
    ),
    lat: (json['lat']! as num).toDouble(),
    lng: (json['lng']! as num).toDouble(),
    altitudeM: (json['alt'] as num?)?.toDouble(),
    speedMps: ((json['s'] as num?)?.toDouble() ?? 0) / 3.6,
  );
}

/// Final numbers for a finished ride.
class TripSummary {
  const TripSummary({
    required this.distanceKm,
    required this.duration,
    required this.movingDuration,
    required this.idleDuration,
    required this.maxSpeedKmh,
    this.elevationGainM,
  });

  final double distanceKm;
  final Duration duration;
  final Duration movingDuration;
  final Duration idleDuration;
  final double maxSpeedKmh;
  final double? elevationGainM;

  double get avgSpeedKmh {
    final hours = movingDuration.inSeconds / 3600;
    return hours <= 0 ? 0 : distanceKm / hours;
  }

  /// Share of the trip spent actually moving. A scooter ride that is 40 %
  /// stopped is not the same as a 20 km highway run.
  double get movingRatio {
    if (duration.inSeconds <= 0) return 0;
    return movingDuration.inSeconds / duration.inSeconds;
  }
}
