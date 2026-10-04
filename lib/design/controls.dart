import 'package:flutter/material.dart';

import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

enum TanklyButtonVariant { primary, secondary, danger, ghost }

/// The app's only button.
///
/// `riding: true` gives the 72 dp pill used by Start Ride and Stop — the two
/// controls a rider presses with a glove on, mid-traffic.
class TanklyButton extends StatelessWidget {
  const TanklyButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = TanklyButtonVariant.primary,
    this.riding = false,
    this.expand = true,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TanklyButtonVariant variant;
  final bool riding;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final height = riding ? Sizes.rideButton : Sizes.tap + 8;

    final (Color bg, Color fg) = switch (variant) {
      TanklyButtonVariant.primary => (
        p.accent,
        p.isDark ? TanklyBrand.bg : Colors.white,
      ),
      TanklyButtonVariant.danger => (p.critical, Colors.white),
      TanklyButtonVariant.secondary => (Colors.transparent, p.text),
      TanklyButtonVariant.ghost => (Colors.transparent, p.textDim),
    };

    final labelStyle = TanklyType.ui(
      riding ? TanklyType.title - 1 : TanklyType.body + 1,
      weight: riding ? 700 : 600,
      color: fg,
      tracking: 0.1,
    );

    final child = riding
        ? Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fg, size: 26),
                const SizedBox(width: Gap.md),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fg, size: 20),
                const SizedBox(width: Gap.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
            ],
          );

    final button = SizedBox(
      height: height,
      width: expand ? double.infinity : null,
      child: switch (variant) {
        TanklyButtonVariant.secondary => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                riding ? Radii.riding : Radii.button,
              ),
              side: BorderSide(color: p.outline),
            ),
            padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
          ),
          child: child,
        ),
        TanklyButtonVariant.ghost => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                riding ? Radii.riding : Radii.button,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
          ),
          child: child,
        ),
        _ => Material(
          color: bg,
          borderRadius: BorderRadius.circular(
            riding ? Radii.riding : Radii.button,
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Center(child: child),
          ),
        ),
      },
    );

    return button;
  }
}

/// Three-up action row under the Home gauge.
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.tint,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = tint ?? p.accent;
    return Expanded(
      child: Material(
        color: p.surface,
        borderRadius: BorderRadius.circular(Radii.button),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 84,
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: Gap.sm + 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.button),
              border: Border.all(color: p.outline),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 22),
                  const SizedBox(height: Gap.sm - 2),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TanklyType.ui(
                      TanklyType.caption - 1,
                      weight: 600,
                      color: p.text,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pill segmented control with a sliding selection.
class RangeSegments extends StatelessWidget {
  const RangeSegments({
    super.key,
    required this.labels,
    required this.index,
    required this.onChanged,
    this.expand = true,
  });

  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(Radii.chip),
        border: Border.all(color: p.outline),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segment = constraints.maxWidth / labels.length;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: Motion.base,
                curve: Motion.easeOut,
                left: segment * index,
                top: 0,
                bottom: 0,
                width: segment,
                child: Container(
                  decoration: BoxDecoration(
                    color: p.accentSoft,
                    borderRadius: BorderRadius.circular(Radii.chip),
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < labels.length; i++)
                    Expanded(
                      child: Semantics(
                        selected: i == index,
                        button: true,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(Radii.chip),
                          onTap: () => onChanged(i),
                          child: Center(
                            child: Text(
                              labels[i],
                              style: TanklyType.ui(
                                TanklyType.label - 1,
                                weight: i == index ? 700 : 500,
                                color: i == index ? p.accent : p.textDim,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Settings-style row with a trailing switch.
class SwitchRow extends StatelessWidget {
  const SwitchRow({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.sm),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: p.textDim, size: 22),
            const SizedBox(width: Gap.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TanklyType.ui(TanklyType.body, color: p.text),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Tappable field that opens a picker. Reads as an input, behaves like one.
class PickerRow extends StatelessWidget {
  const PickerRow({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.icon,
    this.helper,
  });

  final String label;
  final String value;
  final String? helper;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(Radii.field),
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
              decoration: BoxDecoration(
                color: p.surface,
                borderRadius: BorderRadius.circular(Radii.field),
                border: Border.all(color: p.outline),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: p.textDim, size: 20),
                    const SizedBox(width: Gap.md),
                  ],
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TanklyType.number(
                        TanklyType.title - 2,
                        weight: 600,
                        color: p.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: Gap.sm),
                  if (label.isNotEmpty) ...[
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TanklyType.ui(
                          TanklyType.label,
                          color: p.textDim,
                        ),
                      ),
                    ),
                    const SizedBox(width: Gap.sm),
                  ],
                  Icon(Icons.expand_more_rounded, color: p.textDim, size: 20),
                ],
              ),
            ),
          ),
          if (helper != null)
            Padding(
              padding: const EdgeInsets.only(top: Gap.xs + 2, left: Gap.xs),
              child: Text(
                helper!,
                style: TanklyType.ui(
                  TanklyType.caption,
                  color: p.textDim,
                  height: 1.35,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
