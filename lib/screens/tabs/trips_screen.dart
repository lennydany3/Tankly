import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../data/models.dart';
import '../../design/data_display.dart';
import '../../design/surfaces.dart';
import '../../theme/tankly_palette.dart';
import '../../theme/tankly_tokens.dart';
import '../../theme/tankly_type.dart';

/// Ride timeline, newest first, grouped by day.
class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key, this.empty = false});

  final bool empty;

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  int _range = 1;

  static const _months = ['September', 'October'];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    if (widget.empty) {
      return Scaffold(
        backgroundColor: p.bg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Gap.screen,
                  Gap.md,
                  Gap.screen,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Trips',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TanklyType.ui(
                          TanklyType.headline,
                          weight: 700,
                          color: p.text,
                        ),
                      ),
                    ),
                    const SizedBox(width: Gap.sm),
                    const StatusChipValue(label: '0 km · October'),
                  ],
                ),
              ),
              const Expanded(
                child: EmptyState(
                  icon: Icons.route_rounded,
                  title: 'No rides yet',
                  message:
                      'Start a ride and Tankly records distance, speed and the route. '
                      'Rides also feed your fuel estimate.',
                  action: 'Start ride',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: p.bg,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Gap.screen,
            Gap.md,
            Gap.screen,
            Gap.xl,
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Trips',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TanklyType.ui(
                      TanklyType.headline,
                      weight: 700,
                      color: p.text,
                    ),
                  ),
                ),
                const SizedBox(width: Gap.sm),
                const StatusChipValue(label: '28.4 km · Oct'),
              ],
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                for (var i = 0; i < _months.length; i++) ...[
                  Expanded(
                    child: _MonthChip(
                      label: _months[i],
                      selected: _range == i,
                      onTap: () => setState(() => _range = i),
                    ),
                  ),
                  if (i != _months.length - 1) const SizedBox(width: Gap.sm),
                ],
              ],
            ),
            const SizedBox(height: Gap.md),
            ..._buildTimeline(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeline(BuildContext context) {
    final groups = <String, List<TripRecord>>{};
    for (final trip in DemoData.trips) {
      groups
          .putIfAbsent(
            TimeLabel.relativeDay(trip.startedAt, DemoData.now),
            () => [],
          )
          .add(trip);
    }

    final widgets = <Widget>[];
    for (final entry in groups.entries) {
      final total = entry.value.fold<double>(0, (sum, t) => sum + t.distanceKm);
      widgets.add(
        DateHeader(
          label: entry.key,
          trailing: '${total.toStringAsFixed(1)} km',
        ),
      );
      for (final trip in entry.value) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.md - 4),
            child: TripCard(trip: trip),
          ),
        );
      }
    }
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(top: Gap.lg),
        child: Center(
          child: Text(
            'Showing the 4 most recent of 31 rides',
            style: TanklyType.ui(
              TanklyType.caption,
              color: context.palette.textDim,
            ),
          ),
        ),
      ),
    );
    return widgets;
  }
}

class _MonthChip extends StatelessWidget {
  const _MonthChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: selected ? p.accentSoft : p.surface,
      borderRadius: BorderRadius.circular(Radii.button),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.button),
            border: Border.all(color: selected ? p.accent : p.outline),
          ),
          child: Text(
            label,
            style: TanklyType.ui(
              TanklyType.label,
              weight: selected ? 700 : 500,
              color: selected ? p.accent : p.textDim,
            ),
          ),
        ),
      ),
    );
  }
}

/// A quiet numeric readout in a top bar.
class StatusChipValue extends StatelessWidget {
  const StatusChipValue({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 12, 7),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(Radii.chip),
        border: Border.all(color: p.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 15, color: p.textDim),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TanklyType.number(
              TanklyType.caption + 1,
              weight: 600,
              color: p.textDim,
            ),
          ),
        ],
      ),
    );
  }
}
