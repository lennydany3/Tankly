import 'package:flutter/material.dart';

/// Raw brand values, transcribed from `docs/Design.md`.
///
/// These are the dark theme values and double as the brand reference sheet.
/// Runtime lookups do **not** use these constants — they go through
/// [TanklyPalette], a [ThemeExtension] that also carries accessible light
/// theme equivalents. Keeping the raw table here means the brand spec and the
/// code can be diffed against each other at a glance.
abstract final class TanklyBrand {
  // Neutrals
  static const bg = Color(0xFF0B0F14);
  static const surface = Color(0xFF131A22);
  static const surfaceHigh = Color(0xFF1B2530);
  static const outline = Color(0xFF2A3644);

  // Content
  static const text = Color(0xFFF2F5F8);
  static const textDim = Color(0xFF9AA8B8);

  // Brand
  static const accent = Color(0xFF22D3EE); // Volt Cyan
  static const accentSoft = Color(0xFF0E3A44);

  // Fuel status. Reserved: never used decoratively.
  static const fuelGood = Color(0xFF34D399);
  static const fuelMedium = Color(0xFFFACC15);
  static const fuelLow = Color(0xFFFB923C);
  static const fuelCritical = Color(0xFFEF4444);

  // Non-fuel signal
  static const info = Color(0xFF60A5FA); // GPS searching

  /// Live Trip runs on pure black in dark theme for OLED + sunlight contrast.
  static const liveBg = Color(0xFF000000);
}

/// Resolved theme colours.
///
/// Read with `context.palette` (see [TanklyThemeAccess]) rather than
/// `TanklyBrand`, so every widget adapts to the active light/dark variant.
@immutable
class TanklyPalette extends ThemeExtension<TanklyPalette> {
  const TanklyPalette({
    required this.bg,
    required this.surface,
    required this.surfaceHigh,
    required this.outline,
    required this.text,
    required this.textDim,
    required this.accent,
    required this.accentSoft,
    required this.good,
    required this.medium,
    required this.low,
    required this.critical,
    required this.info,
    required this.liveBg,
    required this.mapBase,
    required this.mapBlock,
    required this.mapRoad,
    required this.mapLabel,
    required this.isDark,
  });

  /// App background.
  final Color bg;

  /// Cards, bottom navigation bar, inputs.
  final Color surface;

  /// Dialogs, bottom sheets, selected rows.
  final Color surfaceHigh;

  /// 1 dp borders and dividers.
  final Color outline;

  /// Primary text and all numeric readouts.
  final Color text;

  /// Labels, captions, units.
  final Color textDim;

  /// Primary actions, active tab, route line.
  final Color accent;

  /// Tinted chip and pill backgrounds.
  final Color accentSoft;

  /// Fuel above 50 %.
  final Color good;

  /// Fuel between 25 % and 50 %.
  final Color medium;

  /// Fuel below 25 %.
  final Color low;

  /// Fuel at or below the alert level. Pulses.
  final Color critical;

  /// GPS searching and other informational signals.
  final Color info;

  /// Background of the Live Trip screen.
  final Color liveBg;

  /// Stylised dark map layers, used until `flutter_map` is wired up.
  final Color mapBase;
  final Color mapBlock;
  final Color mapRoad;
  final Color mapLabel;

  final bool isDark;

  static const dark = TanklyPalette(
    bg: TanklyBrand.bg,
    surface: TanklyBrand.surface,
    surfaceHigh: TanklyBrand.surfaceHigh,
    outline: TanklyBrand.outline,
    text: TanklyBrand.text,
    textDim: TanklyBrand.textDim,
    accent: TanklyBrand.accent,
    accentSoft: TanklyBrand.accentSoft,
    good: TanklyBrand.fuelGood,
    medium: TanklyBrand.fuelMedium,
    low: TanklyBrand.fuelLow,
    critical: TanklyBrand.fuelCritical,
    info: TanklyBrand.info,
    liveBg: TanklyBrand.liveBg,
    mapBase: Color(0xFF0E151C),
    mapBlock: Color(0xFF16212B),
    mapRoad: Color(0xFF23303E),
    mapLabel: Color(0xFF6E8296),
    isDark: true,
  );

  /// Light variant.
  ///
  /// The spec pins `bg`, `surface`, `text`, `textDim`, `accent` and
  /// `fuelMedium`. The remaining fuel hues are darkened here because the dark
  /// set fails the 4.5:1 contrast requirement on white — see the accessibility
  /// note in `docs/Handoff.md`.
  static const light = TanklyPalette(
    bg: Color(0xFFF6F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceHigh: Color(0xFFE9EFF4),
    outline: Color(0xFFD9E1E9),
    text: Color(0xFF0B0F14),
    textDim: Color(0xFF5B6B7C),
    accent: Color(0xFF0891B2),
    accentSoft: Color(0xFFD6F1F7),
    good: Color(0xFF047857),
    medium: Color(0xFFCA8A04),
    low: Color(0xFFC2410C),
    critical: Color(0xFFDC2626),
    info: Color(0xFF2563EB),
    // Pure white: maximum legibility in direct sun on a handlebar mount.
    liveBg: Color(0xFFFFFFFF),
    mapBase: Color(0xFFEAEFF3),
    mapBlock: Color(0xFFDCE5EC),
    mapRoad: Color(0xFFC6D2DC),
    mapLabel: Color(0xFF64748B),
    isDark: false,
  );

  @override
  TanklyPalette copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceHigh,
    Color? outline,
    Color? text,
    Color? textDim,
    Color? accent,
    Color? accentSoft,
    Color? good,
    Color? medium,
    Color? low,
    Color? critical,
    Color? info,
    Color? liveBg,
    Color? mapBase,
    Color? mapBlock,
    Color? mapRoad,
    Color? mapLabel,
    bool? isDark,
  }) {
    return TanklyPalette(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      outline: outline ?? this.outline,
      text: text ?? this.text,
      textDim: textDim ?? this.textDim,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      good: good ?? this.good,
      medium: medium ?? this.medium,
      low: low ?? this.low,
      critical: critical ?? this.critical,
      info: info ?? this.info,
      liveBg: liveBg ?? this.liveBg,
      mapBase: mapBase ?? this.mapBase,
      mapBlock: mapBlock ?? this.mapBlock,
      mapRoad: mapRoad ?? this.mapRoad,
      mapLabel: mapLabel ?? this.mapLabel,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  TanklyPalette lerp(TanklyPalette? other, double t) {
    if (other == null) return this;
    return TanklyPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      text: Color.lerp(text, other.text, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      good: Color.lerp(good, other.good, t)!,
      medium: Color.lerp(medium, other.medium, t)!,
      low: Color.lerp(low, other.low, t)!,
      critical: Color.lerp(critical, other.critical, t)!,
      info: Color.lerp(info, other.info, t)!,
      liveBg: Color.lerp(liveBg, other.liveBg, t)!,
      mapBase: Color.lerp(mapBase, other.mapBase, t)!,
      mapBlock: Color.lerp(mapBlock, other.mapBlock, t)!,
      mapRoad: Color.lerp(mapRoad, other.mapRoad, t)!,
      mapLabel: Color.lerp(mapLabel, other.mapLabel, t)!,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}

/// Sugar so widgets read `context.palette` instead of a two-step lookup.
extension TanklyThemeAccess on BuildContext {
  TanklyPalette get palette => Theme.of(this).extension<TanklyPalette>()!;
}
