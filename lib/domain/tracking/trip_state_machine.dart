import 'package:tankly/core/constants.dart';
import 'package:tankly/domain/models/trip.dart';
import 'package:tankly/domain/tracking/distance_calculator.dart';
import 'package:tankly/domain/tracking/gps_filter.dart';

/// What the live trip card should be showing right now.
enum RecorderPhase {
  /// No trip in progress.
  idle,

  /// Started, moving.
  riding,

  /// Started, stationary or no signal.
  idleStopped,

  /// Recording, but no fix for longer than `Gps.signalHoldMs`.
  signalLost,

  /// Below `Recorder.minTripDistanceKm`: shown as a hint, never saved.
  tooShort,
}

/// Why a transition happened, so the UI can explain itself and a test can
/// assert the rule rather than the resulting field.
enum RecorderReason {
  started,
  pointAccepted,
  stoppedMoving,
  resumedMoving,
  signalLost,
  signalRestored,
  belowMinDistance,
  passedMinDistance,
  saved,
  discarded,
}

/// One emitted state.
class RecorderState {
  const RecorderState({
    required this.phase,
    required this.reason,
    required this.distanceKm,
    required this.duration,
    required this.speedKmh,
    required this.since,
  });

  final RecorderPhase phase;
  final RecorderReason reason;

  /// Raw, uncorrected. Corrected distance is a read-time concern.
  final double distanceKm;
  final Duration duration;
  final double speedKmh;

  /// Whether the UI should show "Waiting for GPS" over the map.
  final bool since;

  RecorderState copyWith({
    RecorderPhase? phase,
    RecorderReason? reason,
    double? distanceKm,
    Duration? duration,
    double? speedKmh,
    bool? since,
  }) => RecorderState(
    phase: phase ?? this.phase,
    reason: reason ?? this.reason,
    distanceKm: distanceKm ?? this.distanceKm,
    duration: duration ?? this.duration,
    speedKmh: speedKmh ?? this.speedKmh,
    since: since ?? this.since,
  );

  bool get isRecording => phase != RecorderPhase.idle;
  bool get hasSignal => phase != RecorderPhase.signalLost;
  bool get shouldPromptSave => phase == RecorderPhase.tooShort;
}

/// The one place the live trip's rules live (system design 7.5, 15).
///
/// The recorder itself stays dumb: it feeds fixes in and renders whatever state
/// comes out. Every decision - is this a teleport, has the ride been long enough
/// to keep, has the signal died - is made here, so it can be replayed in a test.
class TripStateMachine {
  TripStateMachine({DateTime Function()? clock}) : _now = clock ?? DateTime.now;

  final DateTime Function() _now;

  DistanceCalculator? _calc;
  DateTime? _startedAt;
  DateTime? _lastFixAt;
  RecorderState _state = const RecorderState(
    phase: RecorderPhase.idle,
    reason: RecorderReason.started,
    distanceKm: 0,
    duration: Duration.zero,
    speedKmh: 0,
    since: false,
  );

  RecorderState get state => _state;
  DistanceCalculator? get calculator => _calc;
  DateTime? get startedAt => _startedAt;

  /// Starts a trip. Any existing one is discarded: the UI asks first.
  RecorderState start() {
    final at = _now();
    _startedAt = at;
    _lastFixAt = at;
    _calc = DistanceCalculator(startedAt: at);
    _state = RecorderState(
      phase: RecorderPhase.tooShort,
      reason: RecorderReason.belowMinDistance,
      distanceKm: 0,
      duration: Duration.zero,
      speedKmh: 0,
      since: false,
    );
    return _state;
  }

  /// Feeds a verdict straight from `GpsFilter`. Rejected fixes update the signal
  /// clock and nothing else.
  RecorderState onVerdict(FilterVerdict verdict) {
    final at = verdict.point?.at ?? _now();
    _lastFixAt = at;
    final point = verdict.point;
    if (point == null) return _tick(at, reason: null);

    _calc!.add(point, segmentKm: verdict.distanceKm);
    return _tick(at, reason: RecorderReason.pointAccepted);
  }

  /// Recomputes the phase. Safe to call on a timer: it emits a state only when
  /// something actually changed, so listeners do not churn.
  RecorderState tick([DateTime? at]) => _tick(at ?? _now(), reason: null);

  RecorderState _tick(DateTime at, {RecorderReason? reason}) {
    if (_calc == null || _startedAt == null) return _state;

    final summary = _calc!.summarise();
    final duration = at.difference(_startedAt!);
    final signalAge = at.difference(_lastFixAt ?? at).inMilliseconds;

    var phase = _state.phase;
    if (signalAge > Gps.signalHoldMs) {
      phase = RecorderPhase.signalLost;
    } else if (_calc!.isWorthSaving) {
      phase = summary.movingDuration.inSeconds > 0
          ? RecorderPhase.riding
          : RecorderPhase.idleStopped;
    } else {
      phase = RecorderPhase.tooShort;
    }

    final why =
        reason ??
        switch (phase) {
          RecorderPhase.signalLost => RecorderReason.signalLost,
          RecorderPhase.riding when _state.phase == RecorderPhase.signalLost =>
            RecorderReason.signalRestored,
          RecorderPhase.riding when _state.phase != RecorderPhase.riding =>
            RecorderReason.resumedMoving,
          RecorderPhase.riding when _state.phase == RecorderPhase.riding =>
            RecorderReason.pointAccepted,
          RecorderPhase.idleStopped => RecorderReason.stoppedMoving,
          _ => RecorderReason.belowMinDistance,
        };

    final unchanged =
        phase == _state.phase &&
        reason == null &&
        summary.distanceKm == _state.distanceKm;
    if (unchanged) return _state;

    _state = _state.copyWith(
      phase: phase,
      reason: why,
      distanceKm: summary.distanceKm,
      duration: duration < Duration.zero ? Duration.zero : duration,
      speedKmh: _calc!.points.isEmpty ? 0 : _calc!.points.last.speedKmh,
      since: signalAge > Gps.signalHoldMs,
    );
    return _state;
  }

  /// Ends the trip. Returns null when it was not worth keeping, which is the
  /// whole point of `minTripDistanceKm`: accidental pockets leave no trace.
  TripSummary? finish([DateTime? at]) {
    if (_calc == null) return null;
    final summary = _calc!.summarise();
    _state = _state.copyWith(
      phase: RecorderPhase.idle,
      reason: _calc!.isWorthSaving
          ? RecorderReason.saved
          : RecorderReason.discarded,
    );
    _calc = null;
    _startedAt = null;
    _lastFixAt = null;
    return summary;
  }

  /// Total track length, used to draw the route.
  double get distanceKm => _calc?.summarise().distanceKm ?? 0;

  /// The polyline to draw, straight from the calculator.
  List<({double lat, double lng})> get route => _calc?.polyline ?? const [];

  void reset() {
    _calc = null;
    _startedAt = null;
    _lastFixAt = null;
    _state = _state.copyWith(
      phase: RecorderPhase.idle,
      reason: RecorderReason.discarded,
      distanceKm: 0,
      duration: Duration.zero,
      speedKmh: 0,
      since: false,
    );
  }
}
