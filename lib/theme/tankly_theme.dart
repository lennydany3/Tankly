import 'package:flutter/material.dart';

import 'tankly_palette.dart';
import 'tankly_tokens.dart';
import 'tankly_type.dart';

/// Material 3 themes for Tankly. Dark is primary; light is a secondary
/// variant with accessible fuel hues.
abstract final class TanklyTheme {
  static ThemeData get dark => _build(TanklyPalette.dark, Brightness.dark);

  static ThemeData get light => _build(TanklyPalette.light, Brightness.light);

  static ThemeData _build(TanklyPalette p, Brightness brightness) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: p.accent,
          brightness: brightness,
        ).copyWith(
          primary: p.accent,
          onPrimary: p.isDark ? TanklyBrand.bg : Colors.white,
          secondary: p.accent,
          surface: p.surface,
          onSurface: p.text,
          error: p.critical,
          onError: Colors.white,
          outline: p.outline,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.bg,
      canvasColor: p.bg,
      splashFactory: InkSparkle.splashFactory,
      // Elevation is replaced by tonal surface changes plus a 1 dp outline, so
      // shadows stay off everywhere except dialogs and sheets, which genuinely
      // float above the page.
      cardTheme: CardThemeData(
        elevation: 0,
        color: p.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.card),
          side: BorderSide(color: p.outline),
        ),
      ),
      dividerTheme: DividerThemeData(color: p.outline, space: 1, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: p.bg,
        foregroundColor: p.text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TanklyType.ui(
          TanklyType.title,
          weight: 700,
          color: p.text,
          tracking: -0.2,
        ),
        iconTheme: IconThemeData(color: p.text, size: 24),
      ),
      textTheme: _textTheme(p),
      iconTheme: IconThemeData(color: p.text, size: 24),
      primaryIconTheme: IconThemeData(color: p.accent, size: 24),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.accent,
          foregroundColor: p.isDark ? TanklyBrand.bg : Colors.white,
          disabledBackgroundColor: p.surfaceHigh,
          disabledForegroundColor: p.textDim,
          minimumSize: const Size(0, Sizes.tap),
          padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.button),
          ),
          textStyle: TanklyType.ui(TanklyType.body, weight: 600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.text,
          minimumSize: const Size(0, Sizes.tap),
          side: BorderSide(color: p.outline),
          padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.button),
          ),
          textStyle: TanklyType.ui(TanklyType.body, weight: 600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.accent,
          minimumSize: const Size(0, Sizes.tap),
          textStyle: TanklyType.ui(TanklyType.body, weight: 600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        hintStyle: TanklyType.ui(TanklyType.body, color: p.textDim),
        labelStyle: TanklyType.ui(TanklyType.label, color: p.textDim),
        floatingLabelStyle: TanklyType.ui(TanklyType.label, color: p.accent),
        helperStyle: TanklyType.ui(TanklyType.caption, color: p.textDim),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Gap.lg,
          vertical: Gap.lg,
        ),
        border: _fieldBorder(p.outline),
        enabledBorder: _fieldBorder(p.outline),
        focusedBorder: _fieldBorder(p.accent, width: 2),
        errorBorder: _fieldBorder(p.critical),
        focusedErrorBorder: _fieldBorder(p.critical, width: 2),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surfaceHigh,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: p.surfaceHigh,
        elevation: 0,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Radii.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surfaceHigh,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.card),
          side: BorderSide(color: p.outline),
        ),
        titleTextStyle: TanklyType.ui(
          TanklyType.title,
          weight: 700,
          color: p.text,
        ),
        contentTextStyle: TanklyType.ui(TanklyType.body, color: p.textDim),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.surfaceHigh,
        contentTextStyle: TanklyType.ui(TanklyType.body, color: p.text),
        actionTextColor: p.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.button),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? (p.isDark ? TanklyBrand.bg : Colors.white)
              : p.textDim,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? p.accent : p.surfaceHigh,
        ),
        trackOutlineColor: WidgetStateProperty.all(p.outline),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(color: p.outline)),
          textStyle: WidgetStateProperty.all(
            TanklyType.ui(TanklyType.label, weight: 600),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? p.accentSoft
                : Colors.transparent,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) =>
                states.contains(WidgetState.selected) ? p.accent : p.textDim,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: p.text,
        textColor: p.text,
        minVerticalPadding: Gap.md,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: p.accent,
        inactiveTrackColor: p.surfaceHigh,
        thumbColor: p.accent,
        trackHeight: 4,
      ),
      extensions: <ThemeExtension<dynamic>>[p],
    );
  }

  static OutlineInputBorder _fieldBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Radii.field),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static TextTheme _textTheme(TanklyPalette p) {
    TextStyle ui(double size, int weight, Color color, {double? height}) =>
        TanklyType.ui(size, weight: weight, color: color, height: height);

    return TextTheme(
      displayLarge: TanklyType.number(
        TanklyType.display,
        color: p.text,
        height: 0.92,
        tracking: -0.035,
      ),
      displayMedium: TanklyType.number(
        TanklyType.hero,
        color: p.text,
        height: 0.95,
        tracking: -0.03,
      ),
      displaySmall: TanklyType.number(
        40,
        color: p.text,
        height: 1,
        tracking: -0.03,
      ),
      headlineLarge: ui(TanklyType.headline, 700, p.text, height: 1.15),
      headlineMedium: ui(24, 700, p.text, height: 1.2),
      headlineSmall: ui(TanklyType.title + 2, 700, p.text, height: 1.25),
      titleLarge: ui(TanklyType.title, 700, p.text),
      titleMedium: ui(TanklyType.body, 600, p.text),
      titleSmall: ui(TanklyType.label, 600, p.text),
      bodyLarge: ui(TanklyType.body, 400, p.text, height: 1.45),
      bodyMedium: ui(TanklyType.label, 400, p.textDim, height: 1.45),
      bodySmall: ui(TanklyType.caption, 400, p.textDim, height: 1.4),
      labelLarge: ui(TanklyType.label, 600, p.text),
      labelMedium: ui(TanklyType.caption, 500, p.textDim),
      labelSmall: TanklyType.eyebrow(p.textDim),
    );
  }
}
