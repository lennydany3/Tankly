import 'package:tankly/core/constants.dart';
import 'package:tankly/core/geo.dart';
import 'package:tankly/domain/models/trip.dart';

/// Why a fix was thrown away. Logged, and asserted on in tests.
enum DropReason {
  /// Accuracy worse than [Gps.maxAccuracyM].
  poorAccuracy,

  /// Speed accuracy worse than [Gps.maxSpeedAccuracyMps].
  poorSpeedAccuracy,

  /// Implied speed above [Gps.maxPlausibleSpeedKmh]. A teleport, not a ride.
  impossibleJump,

  /// Below [Gps.idleSpeedKmh]: counted as idle time, no distance, no point.
  stationary,

  /// Moved less than [Gps.minStoreDistanceM] in less than
  /// [Gps.minStoreIntervalMs]. Nothing to add.
  tooClose,

  /// A fix that arrived before the previous one, or with the same timestamp.
  outOfOrder,
}

/// What the filter decided about one incoming fix.
class FilterVerdict {
  const FilterVerdict.accepted(this.point, {this.distanceKm = 0})
    : reason = null;

  const FilterVerdict.rejected(this.reason) : point = null, distanceKm = 0;

  /// Non-null when the fix is good and worth storing.
  final TrackPoint? point;

  /// Non-null when it was thrown away.
  final DropReason? reason;

  /// Distance added by this fix, in km. Zero for every non-accepted verdict.
  final double distanceKm;

  bool get isAccepted => point != null;
}

/// Stateful GPS filter (system design 7.3).
///
/// Pure Dart and fed one fix at a time, which is what makes it testable: a
/// recorded track can be replayed through it on a laptop and produce the exact
/// point list the app would have stored on the road.
///
/// The filter is what makes a bad track cheap. A phone in a city pocket emits
/// fixes that jump half a kilometre between samples; each one is dropped rather
/// than integrated, so a 20 km ride is not reported as 26 km.
class GpsFilter {
  GpsFilter({this.now});

  /// Injectable clock, so tests do not depend on wall time.
  final DateTime Function()? now;

  TrackPoint? _lastAccepted;
  DateTime? _lastStoredAt;
  double _distanceKm = 0;

  double _shownSpeedKmh = 0;
  DateTime? _lastFixAt;

  double get distanceKm => _distanceKm;

  /// Smoothed speed for the live readout. Held, never negative, zero below the
  /// idle threshold.
  double get displayedSpeedKmh => _shownSpeedKmh;

  DateTime? get lastFixAt => _lastFixAt;

  /// Seconds since the last fix arrived, or null if none has.
  Duration? get signalAge {
    final at = _lastFixAt;
    if (at == null) return null;
    return (now ?? DateTime.now)().difference(at);
  }

  /// Whether the UI should be showing "No GPS" (system design 7.3).
  bool get isSignalLost {
    final age = signalAge;
    return age != null && age.inMilliseconds > Gps.signalHoldMs;
  }

  /// Whether a real gap has opened. No distance is added across a gap.
  bool get hasSignalGap {
    final age = signalAge;
    return age != null && age.inMilliseconds > Gps.signalGapMs;
  }

  /// Feeds one raw fix in and reports what to do with it.
  ///
  /// Rejects are not errors; a dropped fix is the system working. Callers add
  /// [FilterVerdict.distanceKm] to the trip total and store
  /// [FilterVerdict.point] when non-null.
  FilterVerdict add({
    required DateTime at,
    required double lat,
    required double lng,
    required double accuracyM,
    double? altitudeM,
    double? speedMps,
    double? speedAccuracyMps,
  }) {
    _lastFixAt = at;

    // --- 1. accuracy ------------------------------------------------------
    if (accuracyM > Gps.maxAccuracyM) {
      return const FilterVerdict.rejected(DropReason.poorAccuracy);
    }
    if (speedAccuracyMps != null &&
        speedAccuracyMps > Gps.maxSpeedAccuracyMps) {
      return const FilterVerdict.rejected(DropReason.poorSpeedAccuracy);
    }

    final prev = _lastAccepted;

    // --- 2. ordering ------------------------------------------------------
    if (prev != null && !at.isAfter(prev.at)) {
      return const FilterVerdict.rejected(DropReason.outOfOrder);
    }

    var speedKmh = speedMps == null ? 0.0 : speedMps * 3.6;

    // --- 3. impossible jump ------------------------------------------------
    // Checked against the previous accepted point, and only across a gap short
    // enough that a teleport is the only explanation. A genuine gap (tunnel,
    // app backgrounded) must not be reported as 400 km/h.
    if (prev != null) {
      final gapMs = at.difference(prev.at).inMilliseconds;
      final segmentKm = Geo.haversineKm(
        lat1: prev.lat,
        lng1: prev.lng,
        lat2: lat,
        lng2: lng,
      );
      if (gapMs > 0 && gapMs < Gps.signalGapMs && segmentKm > 0) {
        final impliedKmh = segmentKm / (gapMs / 3600000);
        if (impliedKmh > Gps.maxPlausibleSpeedKmh) {
          return const FilterVerdict.rejected(DropReason.impossibleJump);
        }
      }
    }

    // --- 4. stationary -----------------------------------------------------
    final moving = speedKmh >= Gps.idleSpeedKmh;
    if (!moving) speedKmh = 0;

    // --- 5. distance gate --------------------------------------------------
    double segmentKm = 0;
    if (prev != null && moving && !hasSignalGap) {
      segmentKm = Geo.haversineKm(
        lat1: prev.lat,
        lng1: prev.lng,
        lat2: lat,
        lng2: lng,
      );
      final sinceLastMs = _lastStoredAt == null
          ? 1 << 30
          : at.difference(_lastStoredAt!).inMilliseconds;
      if (segmentKm * 1000 < Gps.minStoreDistanceM &&
          sinceLastMs < Gps.minStoreIntervalMs) {
        return const FilterVerdict.rejected(DropReason.tooClose);
      }
      _distanceKm += segmentKm;
    }

    final point = TrackPoint(
      at: at,
      lat: lat,
      lng: lng,
      altitudeM: altitudeM,
      speedMps: speedKmh / 3.6,
      accuracyM: accuracyM,
      speedAccuracyMps: speedAccuracyMps,
      isMoving: moving,
    );

    _lastAccepted = point;
    _lastStoredAt = at;
    _shownSpeedKmh = _smooth(prev, speedKmh, at);

    return FilterVerdict.accepted(point, distanceKm: segmentKm);
  }

  /// EMA for the display only (system design 7.3): `0.4 * latest + 0.6 * prev`.
  ///
  /// The stored track keeps the raw speed; smoothing is a reading comfort, not a
  /// data change. A gap resets the average so a stale reading cannot smear into
  /// a fresh one.
  double _smooth(TrackPoint? prev, double speedKmh, DateTime at) {
    if (prev == null) return speedKmh;
    if (hasSignalGap) return speedKmh;
    final w = Gps.displaySpeedWeight;
    final next = w * speedKmh + (1 - w) * _shownSpeedKmh;
    return next < Gps.idleSpeedKmh ? 0 : next;
  }

  void reset() {
    _lastAccepted = null;
    _lastStoredAt = null;
    _distanceKm = 0;
    _shownSpeedKmh = 0;
    _lastFixAt = null;
  }
}
