import 'dart:math' as math;

import 'package:intl/intl.dart';

/// Unit conversion and the string formats the UI is allowed to use.
///
/// Everything the user reads is formatted here, so there is exactly one place
/// that decides a decimal point count and one place that decides kilometres
/// versus miles.
enum DistanceUnit {
  kilometres('km', 'km'),
  miles('mi', 'mi');

  const DistanceUnit(this.symbol, this.longLabel);

  final String symbol;
  final String longLabel;

  static DistanceUnit parse(String? raw) => switch (raw) {
    'mi' => DistanceUnit.miles,
    _ => DistanceUnit.kilometres,
  };
}

enum VolumeUnit {
  litres('L'),
  gallons('gal');

  const VolumeUnit(this.symbol);

  final String symbol;
}

abstract final class Units {
  static const kmPerMile = 1.609344;
  static const litresPerGallon = 3.785411784;

  // --- conversions -------------------------------------------------------

  static double kmToMiles(double km) => km / kmPerMile;
  static double milesToKm(double mi) => mi * kmPerMile;
  static double mpsToKmh(double mps) => mps * 3.6;
  static double kmhToMps(double kmh) => kmh / 3.6;
  static double metresToFeet(double m) => m * 3.280839895;

  static double toKm(double value, DistanceUnit unit) =>
      unit == DistanceUnit.miles ? kmToMiles(value) : value;

  static double fromKm(double km, DistanceUnit unit) =>
      unit == DistanceUnit.miles ? milesToKm(km) : km;

  static double toL(double litres, VolumeUnit unit) =>
      unit == VolumeUnit.gallons ? litres / litresPerGallon : litres;

  static double fromL(double litres, VolumeUnit unit) =>
      unit == VolumeUnit.gallons ? litres * litresPerGallon : litres;

  // --- formatting --------------------------------------------------------

  /// Litres. Fuel reads in hundredths: 0.40 L, never 0.4 L.
  static String litres(double value, {VolumeUnit unit = VolumeUnit.litres}) =>
      '${toL(value, unit).toStringAsFixed(2)} ${unit.symbol}';

  /// Kilometres or miles. Whole numbers above 100, one decimal below, because
  /// "34 km" is honest while "34.219 km" pretends to a precision GPS does not
  /// have.
  static String distance(
    double km, {
    DistanceUnit unit = DistanceUnit.kilometres,
    int? decimals,
  }) {
    final v = toKm(km, unit);
    final dp = decimals ?? (v >= 100 ? 0 : 1);
    return '${v.toStringAsFixed(dp)} ${unit.symbol}';
  }

  static String speed(double kmh) => '${kmh.round()} km/h';

  static String cost(double rupees) => _rupees.format(rupees);

  static String duration(Duration d, {bool compact = false}) =>
      compact ? _compactDuration(d) : _fullDuration(d);

  static String clock(DateTime local) =>
      DateFormat.jm().format(local.toLocal());

  static String dayMonth(DateTime local) =>
      DateFormat('d MMM').format(local.toLocal());

  static String dayMonthYear(DateTime local) =>
      DateFormat('d MMM yyyy').format(local.toLocal());

  /// "3 days ago", "in 2 weeks". Used by reminders and sync status.
  static String relative(DateTime then, {DateTime? from}) {
    final now = from ?? DateTime.now();
    final days = then
        .toLocal()
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (days == 0) return 'today';
    if (days == 1) return 'tomorrow';
    if (days == -1) return 'yesterday';
    final future = days > 0;
    final n = days.abs();
    final phrase = switch (n) {
      < 7 => '$n ${n == 1 ? 'day' : 'days'}',
      < 14 => '1 week',
      < 31 => '${(n / 7).round()} weeks',
      < 60 => '1 month',
      < 365 => '${(n / 30).round()} months',
      _ => '${(n / 365).round()} ${n >= 730 ? 'years' : 'year'}',
    };
    return future ? 'in $phrase' : '$phrase ago';
  }

  static String rupeesCompact(double value) {
    if (value >= 100000) return '₹${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '₹${(value / 1000).toStringAsFixed(1)}k';
    return _rupees.format(value);
  }

  static final _rupees = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static String _fullDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String _compactDuration(Duration d) {
    if (d.inHours > 0) {
      final m = d.inMinutes.remainder(60);
      return '${d.inHours}h ${m}m';
    }
    final s = d.inSeconds.remainder(60);
    return '${d.inMinutes}m ${s}s';
  }
}

/// Clamp helper used across the domain layer.
double clampDouble(double value, double lo, double hi) =>
    math.max(lo, math.min(hi, value));
