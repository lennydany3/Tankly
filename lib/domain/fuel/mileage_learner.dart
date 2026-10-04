import 'package:tankly/core/constants.dart';

/// Exponential moving average over observed mileage at refuel time.
///
/// At each new refuel the app knows the km ridden since the previous one and
/// the litres that refuel put in, which gives one mileage observation:
///
/// ```dart
/// observed = km_since_prev_refuel / litres_burned_on_that_tank
/// mileage  = 0.7 * mileage + 0.3 * observed
/// ```
///
/// Guards, all documented in the system design:
/// * ignore anything under [Learning.minDistanceKm] - too noisy to learn from
/// * ignore outliers more than [Learning.outlierTolerance] from the current value
/// * clamp the result into `[Learning.minKmpl, Learning.maxKmpl]`
///
/// In `reset` mode the leftover is unknown, so learning is approximate; full-tank
/// fills give exact values, which is why the refuel form nudges toward "I
/// filled the tank completely".
/// Result of feeding one observation into the learner.
///
/// [accepted] is false when a guard rejected the sample; [kmpl] then equals the
/// input value, so callers can persist it unconditionally.
class MileageObservation {
  const MileageObservation({
    required this.kmpl,
    required this.accepted,
    this.observedKmpl,
    this.reason,
  });

  final double kmpl;
  final bool accepted;

  /// The raw figure this observation implied, when it was usable.
  final double? observedKmpl;

  /// Why it was rejected, for the settings screen's "why is my mileage stuck"
  /// note and for tests.
  final String? reason;
}

abstract final class MileageLearner {
  static MileageObservation observe({
    required double currentKmpl,
    required double kmSincePrevRefuel,
    required double litresBurned,
  }) {
    if (kmSincePrevRefuel < Learning.minDistanceKm) {
      return MileageObservation(
        kmpl: currentKmpl,
        accepted: false,
        reason:
            'Trip too short to learn from (under '
            '${Learning.minDistanceKm.round()} km)',
      );
    }
    if (litresBurned <= 0) {
      return MileageObservation(
        kmpl: currentKmpl,
        accepted: false,
        reason: 'No litres recorded for that tank',
      );
    }

    final observed = kmSincePrevRefuel / litresBurned;
    if (currentKmpl > 0 &&
        (observed - currentKmpl).abs() / currentKmpl >
            Learning.outlierTolerance) {
      return MileageObservation(
        kmpl: currentKmpl,
        accepted: false,
        observedKmpl: observed,
        reason:
            'Outlier: ${observed.toStringAsFixed(1)} km/L is more than '
            '${(Learning.outlierTolerance * 100).round()} % from '
            '${currentKmpl.toStringAsFixed(1)} km/L',
      );
    }

    final next = (1 - Learning.rate) * currentKmpl + Learning.rate * observed;
    return MileageObservation(
      kmpl: next.clamp(Learning.minKmpl, Learning.maxKmpl),
      accepted: true,
      observedKmpl: observed,
    );
  }

  /// Convenience wrapper when the caller only wants the number.
  static double update({
    required double currentKmpl,
    required double kmSincePrevRefuel,
    required double litresBurned,
  }) => observe(
    currentKmpl: currentKmpl,
    kmSincePrevRefuel: kmSincePrevRefuel,
    litresBurned: litresBurned,
  ).kmpl;
}
