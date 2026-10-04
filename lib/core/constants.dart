/// Every tunable number in one place.
///
/// Section 7.3 of the system design calls these out as "all thresholds in
/// `constants.dart`, tunable". They live here rather than as literals in the
/// domain code so that changing one never means hunting for a magic number.
///
/// Nothing in `domain/` imports Flutter, so these values are testable on a
/// laptop with no device or platform channel involved.
library;

/// ### GPS filtering (system design 7.3)
abstract final class Gps {
  /// Drop a fix whose horizontal accuracy is worse than this.
  static const maxAccuracyM = 25.0;

  /// Drop the reported speed when speed accuracy is worse than this.
  static const maxSpeedAccuracyMps = 2.0;

  /// Implied speed above this between two good points is a GPS jump, not a ride.
  static const maxPlausibleSpeedKmh = 120.0;

  /// Below this the scooter counts as stationary: no distance, no stored point.
  static const idleSpeedKmh = 2.0;

  /// Store a point once the scooter has moved this far.
  static const minStoreDistanceM = 5.0;

  /// ...or once this long has passed, even without movement, to keep the track
  /// continuous enough to draw.
  static const minStoreIntervalMs = 3000;

  /// Weight of the newest sample in the displayed-speed EMA.
  static const displaySpeedWeight = 0.4;

  /// How long to hold the last speed reading before showing "No GPS".
  static const signalHoldMs = 2000;

  /// After this long without a fix, mark a gap and stop accumulating distance.
  static const signalGapMs = 10000;

  /// Fixed recording cadence. DistanceFilter 0 with this interval keeps the
  /// stream cheap enough for a foreground service.
  static const intervalMs = 1000;
}

/// ### Persistence (system design 7.5)
abstract final class Recorder {
  /// Flush buffered points at least this often, so a crash costs seconds.
  static const flushIntervalMs = 5000;

  /// ...or this many points, whichever comes first.
  static const flushPointCount = 20;

  /// Suggest stopping after this long stationary. v1 shows a prompt only;
  /// automatic stopping is v2.
  static const autoStopPromptMs = 300000;

  /// Anything under this is noise, not a ride.
  static const minTripDistanceKm = 0.2;

  /// Anything under this is noise, not a ride.
  static const minTripDurationS = 60;
}

/// ### Fuel estimation (system design 2)
abstract final class Fuel {
  /// Range is quoted at 90 % of real mileage: warn early rather than strand.
  static const defaultSafetyFactor = 0.90;

  /// At or below this the tank is "critical" and the gauge pulses.
  static const defaultLowThresholdL = 0.25;

  /// Amount the app assumes was in the tank when it cannot know.
  static const defaultLeftoverL = 0.0;

  /// Bonus anchor when the estimate hits zero but the scooter keeps running.
  static const stillRunningBonusL = 0.20;

  /// Cold-start mileage before the learner has an observation.
  static const defaultMileageKmpl = 37.5;

  /// Placeholder tank sizes; section 21 asks the owner to confirm.
  static const defaultTankCapacityL = 5.3;
  static const defaultReserveL = 0.8;
}

/// ### Mileage learning (system design 2)
abstract final class Learning {
  /// Ignore samples from shorter trips: too noisy to learn from.
  static const minDistanceKm = 15.0;

  /// Ignore observations this far from the current value.
  static const outlierTolerance = 0.30;

  /// Clamp the learned value into this band.
  static const minKmpl = 25.0;
  static const maxKmpl = 55.0;

  /// Weight of the newest observation in the EMA.
  static const rate = 0.30;
}

/// ### Odometer sync (system design 2)
abstract final class Odometer {
  /// Ignore a check that covers less ground than this.
  static const minGpsKm = 1.0;

  /// GPS can only ever be scaled into this band before it stops being plausible.
  static const minFactor = 0.90;
  static const maxFactor = 1.10;

  /// Weight of the newest sample.
  static const rate = 0.30;
}

/// ### Status bands (system design 2)
abstract final class Bands {
  /// Above half the tank is good.
  static const goodRatio = 0.5;

  /// A quarter or more is medium.
  static const mediumRatio = 0.25;
}

/// ### Sync (system design 8)
abstract final class Sync {
  /// Rows per pull page.
  static const pageSize = 500;

  /// Debounce after an edit before pushing.
  static const debounceMs = 5000;

  /// Periodic background push, roughly every six hours.
  static const periodicMinutes = 360;
}

/// ### Reminders (system design 13)
abstract final class Reminders {
  /// Document reminders fire at these offsets before expiry.
  static const documentLeadDays = <int>[30, 7, 1];

  /// Service reminders default to firing this far ahead, in km.
  static const defaultServiceLeadKm = 500.0;
}
