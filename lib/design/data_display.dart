import 'package:flutter/material.dart';

import 'package:tankly/data/models.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';
import 'package:tankly/design/route_map.dart';
import 'package:tankly/design/surfaces.dart';

/// Label above a value and a unit. The workhorse of the Home and detail rows.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.valueColor,
    this.dense = false,
  });

  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color? valueColor;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      padding: EdgeInsets.all(dense ? Gap.md : Gap.card),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 15, color: p.textDim),
                const SizedBox(width: Gap.xs + 1),
              ],
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TanklyType.ui(
                    TanklyType.caption,
                    weight: 500,
                    color: p.textDim,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: dense ? Gap.xs + 2 : Gap.sm),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TanklyType.number(
                    dense ? 22 : 28,
                    weight: 700,
                    color: valueColor ?? p.text,
                    height: 1,
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: TanklyType.ui(
                      TanklyType.caption + 1,
                      weight: 600,
                      color: p.textDim,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Sync and GPS state. Icon + word, so it survives glare and colour blindness.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.phase, this.label});

  final SyncPhase phase;
  final String? label;

  static (IconData, Color, String) styleFor(
    BuildContext context,
    SyncPhase phase,
  ) {
    final p = context.palette;
    return switch (phase) {
      SyncPhase.synced => (Icons.cloud_done_outlined, p.accent, 'Synced'),
      SyncPhase.syncing => (Icons.cloud_sync_outlined, p.info, 'Syncing'),
      SyncPhase.offline => (Icons.cloud_off_outlined, p.textDim, 'Offline'),
      SyncPhase.gpsSearching => (
        TanklyIcons.gpsSearching,
        p.info,
        'GPS searching',
      ),
      SyncPhase.failed => (Icons.cloud_off_outlined, p.critical, 'Sync failed'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (icon, color, fallback) = styleFor(context, phase);
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 12, 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: p.isDark ? 0.14 : 0.10),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label ?? fallback,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TanklyType.ui(
                TanklyType.caption + 1,
                weight: 600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A ride in the timeline.
class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, this.onTap});

  final TripRecord trip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 86,
            child: RouteMap(route: trip.route, height: 86, showMarkers: false),
          ),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TanklyType.ui(
                    TanklyType.title - 3,
                    weight: 700,
                    color: p.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${TimeLabel.relativeDay(trip.startedAt, DateTime(2026, 10, 4))} · '
                  '${trip.startTimeLabel}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TanklyType.ui(TanklyType.caption, color: p.textDim),
                ),
                const SizedBox(height: Gap.sm + 2),
                Row(
                  children: [
                    _Metric('${trip.distanceKm.toStringAsFixed(1)} km', p.text),
                    const _Dot(),
                    _Metric(trip.durationLabel, p.text),
                    const _Dot(),
                    _Metric('${trip.avgKmph.round()} km/h', p.text),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: p.textDim, size: 22),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TanklyType.ui(TanklyType.caption + 1, weight: 600, color: color),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Gap.xs + 2),
    child: Text(
      '·',
      style: TextStyle(color: context.palette.textDim, fontSize: 13),
    ),
  );
}

/// A dated heading inside the timeline.
class DateHeader extends StatelessWidget {
  const DateHeader({super.key, required this.label, this.trailing});

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.only(top: Gap.lg, bottom: Gap.md),
      child: Row(
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TanklyType.ui(
                TanklyType.title - 3,
                weight: 700,
                color: palette.text,
              ),
            ),
          ),
          const SizedBox(width: Gap.sm),
          Expanded(child: Divider(color: palette.outline, height: 1)),
          if (trailing != null) ...[
            const SizedBox(width: Gap.sm),
            Text(
              trailing!,
              style: TanklyType.ui(TanklyType.caption, color: palette.textDim),
            ),
          ],
        ],
      ),
    );
  }
}

/// Service or document row. Urgency is colour *and* wording.
class ReminderRow extends StatelessWidget {
  const ReminderRow({super.key, required this.reminder, this.onTap});

  final ReminderRecord reminder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = switch (reminder.urgency) {
      ReminderUrgency.ok => p.good,
      ReminderUrgency.dueSoon => p.medium,
      ReminderUrgency.overdue => p.critical,
    };

    return TankCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: Gap.card,
        vertical: Gap.md + 2,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Radii.thumb),
            ),
            child: Icon(reminder.icon, color: color, size: 21),
          ),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: TanklyType.ui(
                    TanklyType.body,
                    weight: 600,
                    color: p.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reminder.detail,
                  style: TanklyType.ui(
                    TanklyType.label - 1,
                    weight: 700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: p.textDim, size: 22),
        ],
      ),
    );
  }
}

/// Value with a unit, laid out horizontally. Used in dense detail rows.
class InlineStat extends StatelessWidget {
  const InlineStat({
    super.key,
    required this.value,
    required this.unit,
    required this.label,
    this.color,
    this.align = CrossAxisAlignment.start,
  });

  final String value;
  final String unit;
  final String label;
  final Color? color;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TanklyType.number(
                  20,
                  weight: 700,
                  color: color ?? p.text,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: TanklyType.ui(TanklyType.caption, color: p.textDim),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TanklyType.ui(TanklyType.caption, color: p.textDim),
        ),
      ],
    );
  }
}

/// Settings / account list row: icon, title, current value, chevron.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.onTap,
    this.tint,
    this.showChevron = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final VoidCallback? onTap;
  final Color? tint;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = tint ?? p.textDim;
    return TankCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: Gap.card,
        vertical: Gap.md,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Radii.thumb),
            ),
            child: Icon(icon, color: color, size: 19),
          ),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TanklyType.ui(
                    TanklyType.body,
                    weight: 600,
                    color: p.text,
                  ),
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
          if (value != null)
            Text(
              value!,
              style: TanklyType.ui(
                TanklyType.label,
                weight: 600,
                color: p.textDim,
              ),
            ),
          if (showChevron) ...[
            const SizedBox(width: Gap.xs),
            Icon(Icons.chevron_right_rounded, color: p.textDim, size: 22),
          ],
        ],
      ),
    );
  }
}
