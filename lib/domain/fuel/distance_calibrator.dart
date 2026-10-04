import 'package:tankly/core/constants.dart';

/// Learns the `distance_factor` that corrects GPS drift (system design 2).
///
/// ```
/// factor_sample    = (odometer_now - odometer_at_last_check)
///                    / gps_km_since_last_check
/// distance_factor  = 0.7 * distance_factor + 0.3 * factor_sample   // clamp .90-1.10
/// ```
///
/// GPS under-reads distance on some phones and over-reads on others, usually by
/// a consistent few percent. One odometer reading fixes the whole history,
/// because fuel is computed from `raw_distance_km x distance_factor` on read
/// rather than from a stored total.
abstract final class DistanceCalibrator {
  const DistanceCalibrator._();

  static double factorSample({
    required double odometerNowKm,
    required double odometerAtLastCheckKm,
    required double gpsKmSinceLastCheck,
  }) {
    if (gpsKmSinceLastCheck < Odometer.minGpsKm) return double.nan;
    final real = odometerNowKm - odometerAtLastCheckKm;
    if (real <= 0) return double.nan;
    return real / gpsKmSinceLastCheck;
  }

  static double apply({
    required double currentFactor,
    required double odometerNowKm,
    required double odometerAtLastCheckKm,
    required double gpsKmSinceLastCheck,
  }) {
    final sample = factorSample(
      odometerNowKm: odometerNowKm,
      odometerAtLastCheckKm: odometerAtLastCheckKm,
      gpsKmSinceLastCheck: gpsKmSinceLastCheck,
    );
    if (sample.isNaN) return currentFactor;
    return smooth(currentFactor: currentFactor, sample: sample);
  }

  /// The EMA step on its own, so a test can drive the factor directly.
  static double smooth({
    required double currentFactor,
    required double sample,
  }) {
    if (sample.isNaN || sample.isInfinite) return currentFactor;
    final next = (1 - Odometer.rate) * currentFactor + Odometer.rate * sample;
    return next.clamp(Odometer.minFactor, Odometer.maxFactor);
  }

  /// Estimated real odometer: the starting reading plus every recorded ride,
  /// scaled by the calibration factor. Rebased on each odometer check.
  static double estimatedOdometerKm({
    required double odometerStartKm,
    required Iterable<double> rawRideDistancesKm,
    double distanceFactor = 1.0,
  }) =>
      odometerStartKm +
      rawRideDistancesKm.fold<double>(0, (sum, km) => sum + km) *
          distanceFactor;
}
