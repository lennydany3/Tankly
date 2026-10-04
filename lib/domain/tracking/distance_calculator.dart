import 'package:tankly/core/constants.dart';
import 'package:tankly/core/geo.dart';
import 'package:tankly/domain/models/trip.dart';

/// Accumulates accepted points into the numbers a trip row needs
/// (system design 7.4).
///
/// Distance comes from the haversine integral that `GpsFilter` already performs,
/// cross-checked against the Doppler speed integral. When the two disagree wildly
/// the Doppler figure wins for that segment: phone speed readings come from the
/// satellite doppler shift and are far more trustworthy than two noisy
/// positions a second apart.
///
/// The result is stored **uncorrected**. `distance_factor` is applied at read
/// time, so one odometer check retroactively fixes every past ride.
class DistanceCalculator {
  DistanceCalculator({this.startedAt});

  final DateTime? startedAt;

  final List<TrackPoint> _points = [];

  /// Per-segment raw distance, parallel to the accepted points.
  final List<double> _segmentKm = [];

  double _rawDistanceKm = 0;
  double _maxSpeedKmh = 0;
  Duration _moving = Duration.zero;
  Duration _idle = Duration.zero;
  double _elevationGainM = 0;
  int _speedDisagreements = 0;

  DateTime? _lastAt;
  double? _lastAltitude;

  List<TrackPoint> get points => List.unmodifiable(_points);
  double get rawDistanceKm => _rawDistanceKm;
  double get maxSpeedKmh => _maxSpeedKmh;
  Duration get movingDuration => _moving;
  Duration get idleDuration => _idle;

  /// How often the doppler cross-check overrode the position integral.
  int get speedDisagreements => _speedDisagreements;

  /// Feeds one accepted point. Callers must pass only points the filter let
  /// through, in time order.
  ///
  /// [segmentKm] is the distance `GpsFilter` already computed for this point.
  /// When supplied it is used instead of recomputing the haversine, so the trip
  /// total and the filter's running total can never drift apart.
  void add(TrackPoint point, {double? segmentKm}) {
    final prevAt = _lastAt;
    if (prevAt != null) {
      final dt = point.at.difference(prevAt);
      final previous = _points.last;
      final haversine =
          segmentKm ??
          Geo.haversineKm(
            lat1: previous.lat,
            lng1: previous.lng,
            lat2: point.lat,
            lng2: point.lng,
          );

      // Doppler integral for this segment, using the previous point's speed
      // held over the gap.
      final dopplerKm = (previous.speedKmh * dt.inMilliseconds) / 3600000;

      // Trust doppler only when the two are far enough apart to matter, and
      // never let it pull the total negative.
      final chosen = _disagree(haversine, dopplerKm) ? dopplerKm : haversine;

      _rawDistanceKm += chosen;
      _segmentKm.add(chosen);
      if (point.isMoving) {
        _moving += dt;
      } else {
        _idle += dt;
      }
    } else {
      _segmentKm.add(0);
    }

    _points.add(point);
    _maxSpeedKmh = _maxSpeedKmh < point.speedKmh
        ? point.speedKmh
        : _maxSpeedKmh;

    final alt = point.altitudeM;
    if (alt != null) {
      final prevAlt = _lastAltitude;
      if (prevAlt != null) {
        final delta = alt - prevAlt;
        // GPS altitude is noisy enough that a 1 m step is not a hill.
        if (delta > 1.0) _elevationGainM += delta;
      }
      _lastAltitude = alt;
    }

    _lastAt = point.at;
  }

  /// More than a 40 % disagreement between the two methods means at least one is
  /// wrong, and the satellite-derived one usually is not.
  bool _disagree(double haversine, double doppler) {
    final hi = haversine > doppler ? haversine : doppler;
    if (hi <= 0) return false;
    final low = haversine > doppler ? doppler : haversine;
    if (hi - low > hi * 0.4 && hi > 0.05) {
      _speedDisagreements++;
      return true;
    }
    return false;
  }

  TripSummary summarise() {
    final end = _lastAt;
    final started = startedAt;
    final duration = (end != null && started != null)
        ? end.difference(started)
        : _moving + _idle;
    return TripSummary(
      distanceKm: _rawDistanceKm,
      duration: duration < Duration.zero ? Duration.zero : duration,
      movingDuration: _moving,
      idleDuration: _idle,
      maxSpeedKmh: _maxSpeedKmh,
      elevationGainM: _points.isEmpty ? null : _elevationGainM,
    );
  }

  /// Whether this is worth saving at all (system design 15).
  ///
  /// A dropped pocket two minutes after starting a ride must not become a
  /// 40-metre "trip" in the timeline.
  bool get isWorthSaving {
    final s = summarise();
    return s.distanceKm >= Recorder.minTripDistanceKm &&
        s.duration.inSeconds >= Recorder.minTripDurationS;
  }

  /// Polyline for the map and for `route_gz`.
  List<({double lat, double lng})> get polyline =>
      _points.map((p) => (lat: p.lat, lng: p.lng)).toList();

  void reset() {
    _points.clear();
    _segmentKm.clear();
    _rawDistanceKm = 0;
    _maxSpeedKmh = 0;
    _moving = Duration.zero;
    _idle = Duration.zero;
    _elevationGainM = 0;
    _speedDisagreements = 0;
    _lastAt = null;
    _lastAltitude = null;
  }
}
