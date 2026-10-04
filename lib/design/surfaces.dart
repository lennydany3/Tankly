import 'package:flutter/material.dart';

import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// The one container everything sits in. Flat, 1 dp outline, tonal depth only.
class TankCard extends StatelessWidget {
  const TankCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Gap.card),
    this.color,
    this.borderColor,
    this.onTap,
    this.clip = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? p.surface,
        borderRadius: BorderRadius.circular(Radii.card),
        border: Border.all(color: borderColor ?? p.outline),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(Radii.card),
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.card),
        child: content,
      ),
    );
  }
}

/// Small uppercase label above a grouped list.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TanklyType.eyebrow(context.palette.textDim),
          ),
        ),
        const SizedBox(width: Gap.sm),
        ?trailing,
      ],
    );
  }
}

/// Section heading with an optional trailing action.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TanklyType.ui(
              TanklyType.title - 2,
              weight: 700,
              color: p.text,
            ),
          ),
        ),
        const SizedBox(width: Gap.sm),
        ?action,
      ],
    );
  }
}

/// Page scaffold: 16 dp screen padding, optional header row.
class TanklyPage extends StatelessWidget {
  const TanklyPage({
    super.key,
    required this.slivers,
    this.padding = const EdgeInsets.fromLTRB(Gap.screen, 0, Gap.screen, Gap.xl),
  });

  final List<Widget> slivers;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.bg,
      body: SafeArea(
        bottom: false,
        child: ListView(padding: padding, children: slivers),
      ),
    );
  }
}

/// Bottom sheet shell: drag handle, title, optional subtitle.
class TanklySheet extends StatelessWidget {
  const TanklySheet({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  /// Presents this sheet with the Tankly chrome already applied.
  static Future<T?> show<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.palette.surfaceHigh,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.sheet)),
      ),
      builder: (_) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: Gap.screen + Gap.xs,
          right: Gap.screen + Gap.xs,
          bottom: MediaQuery.viewInsetsOf(context).bottom + Gap.md,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: p.textDim,
                    borderRadius: BorderRadius.circular(Radii.chip),
                  ),
                ),
              ),
              const SizedBox(height: Gap.lg),
              Text(
                title,
                style: TanklyType.ui(
                  TanklyType.headline - 6,
                  weight: 700,
                  color: p.text,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: Gap.xs + 2),
                Text(
                  subtitle!,
                  style: TanklyType.ui(TanklyType.label, color: p.textDim),
                ),
              ],
              const SizedBox(height: Gap.lg),
              child,
              const SizedBox(height: Gap.sm),
            ],
          ),
        ),
      ),
    );
  }
}

/// Label/value row. Used in settings, trip detail and the odometer sheet.
class KeyValueRow extends StatelessWidget {
  const KeyValueRow(
    this.label,
    this.value, {
    super.key,
    this.valueColor,
    this.trailing,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.md - 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TanklyType.ui(TanklyType.body, color: p.textDim),
            ),
          ),
          Text(
            value,
            style: TanklyType.number(
              TanklyType.label,
              weight: 600,
              color: valueColor ?? p.text,
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: Gap.xs), trailing!],
        ],
      ),
    );
  }
}

/// Inline banner for low fuel, interrupted trips and sync problems.
class TanklyBanner extends StatelessWidget {
  const TanklyBanner({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
    this.action,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color color;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.md + 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: p.isDark ? 0.13 : 0.10),
        borderRadius: BorderRadius.circular(Radii.button + 4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TanklyType.ui(
                    TanklyType.label,
                    weight: 700,
                    color: p.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TanklyType.ui(
                    TanklyType.caption + 1,
                    color: p.textDim,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: color,
                padding: const EdgeInsets.symmetric(horizontal: Gap.sm),
                minimumSize: const Size(48, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                action!,
                style: TanklyType.ui(TanklyType.label, weight: 700),
              ),
            ),
        ],
      ),
    );
  }
}

/// Illustration + copy + one action. Never a shrug.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
    this.icon = Icons.route_rounded,
    this.compact = false,
  });

  final String title;
  final String message;
  final String? action;
  final VoidCallback? onAction;
  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: compact ? Gap.xl : 56,
          horizontal: Gap.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 64 : 88,
              height: compact ? 64 : 88,
              decoration: BoxDecoration(
                color: p.surface,
                shape: BoxShape.circle,
                border: Border.all(color: p.outline),
              ),
              child: Icon(icon, size: compact ? 28 : 38, color: p.accent),
            ),
            SizedBox(height: compact ? Gap.md : Gap.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TanklyType.ui(
                TanklyType.title,
                weight: 700,
                color: p.text,
              ),
            ),
            const SizedBox(height: Gap.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TanklyType.ui(
                TanklyType.label,
                color: p.textDim,
                height: 1.45,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: Gap.lg),
              FilledButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Destructive and decision dialogs. Icon, one title, one paragraph, actions last.
class TanklyDialog extends StatelessWidget {
  const TanklyDialog({
    super.key,
    required this.title,
    required this.message,
    required this.children,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String message;
  final List<Widget> children;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final tint = iconColor ?? p.accent;

    return Dialog(
      backgroundColor: p.surfaceHigh,
      insetPadding: const EdgeInsets.symmetric(horizontal: Gap.xl),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.sheet),
        side: BorderSide(color: p.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Gap.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Radii.thumb),
                ),
                child: Icon(icon, color: tint, size: 22),
              ),
              const SizedBox(height: Gap.md + 2),
            ],
            Text(
              title,
              style: TanklyType.ui(
                TanklyType.title,
                weight: 700,
                color: p.text,
                height: 1.25,
              ),
            ),
            const SizedBox(height: Gap.sm),
            Text(
              message,
              style: TanklyType.ui(
                TanklyType.label + 1,
                color: p.textDim,
                height: 1.45,
              ),
            ),
            for (final child in children) ...[
              const SizedBox(height: Gap.md),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading placeholder. Breathes rather than shimmers, to match the motion rules.
class Skeleton extends StatefulWidget {
  const Skeleton({super.key, this.width, this.height = 16, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Opacity(
        opacity: 0.45 + 0.35 * _controller.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: p.surfaceHigh,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }
}
