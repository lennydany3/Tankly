import 'package:flutter/material.dart';

/// Tankly type scale.
///
/// Two families, both bundled as variable fonts, so weight is chosen at
/// runtime with [FontVariation] rather than by shipping one file per weight.
///
/// * **Space Grotesk** — every number. Tabular figures are switched on
///   globally on this family so live readouts do not jitter as digits change.
/// * **Inter** — all UI text.
abstract final class TanklyType {
  static const grotesk = 'SpaceGrotesk';
  static const inter = 'Inter';

  /// Screen sizes, in logical pixels, from the design spec.
  static const speedHero = 132.0; // Live Trip speedometer
  static const display = 72.0;
  static const hero = 56.0; // litres hero on the fuel gauge
  static const headline = 28.0;
  static const title = 20.0;
  static const body = 16.0;
  static const label = 14.0;
  static const caption = 12.0;

  /// Numeric style.
  ///
  /// [tracking] is a multiplier on the font size, so a single value scales
  /// optical tracking across the whole scale. Negative values tighten large
  /// digits, which is what keeps a three-character speed readout stable.
  static TextStyle number(
    double size, {
    int weight = 700,
    Color? color,
    double? height,
    double tracking = -0.02,
  }) {
    return TextStyle(
      fontFamily: grotesk,
      fontSize: size,
      height: height,
      letterSpacing: size * tracking,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontVariations: [FontVariation('wght', weight.toDouble())],
    );
  }

  /// UI text style.
  static TextStyle ui(
    double size, {
    int weight = 400,
    Color? color,
    double? height,
    double tracking = 0,
  }) {
    return TextStyle(
      fontFamily: inter,
      fontSize: size,
      height: height,
      letterSpacing: tracking,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontVariations: [
        FontVariation('wght', weight.toDouble()),
        // Pin optical size to the default so small text does not get the
        // display cut of Inter.
        const FontVariation('opsz', 14),
      ],
    );
  }

  /// Small uppercase eyebrow used above grouped lists.
  static TextStyle eyebrow(Color color) =>
      ui(caption, weight: 600, color: color, tracking: 1.1);
}
