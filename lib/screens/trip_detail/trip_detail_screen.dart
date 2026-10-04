import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../data/models.dart';
import '../../design/charts.dart';
import '../../design/data_display.dart';
import '../../design/route_map.dart';
import '../../design/surfaces.dart';
import '../../theme/tankly_palette.dart';
import '../../theme/tankly_tokens.dart';
import '../../theme/tankly_type.dart';

/// One ride, in full. Map first, then the numbers, then the graphs.
class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key, this.trip});

  final TripRecord? trip;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final record = trip ?? DemoData.eveningRide;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text(record.title),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            color: p.surfaceHigh,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.button),
              side: BorderSide(color: p.outline),
            ),
            onSelected: (_) {},
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'rename',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 20, color: p.text),
                    const SizedBox(width: Gap.md),
                    Text(
                      'Rename ride',
                      style: TanklyType.ui(TanklyType.body, color: p.text),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: p.critical,
                    ),
                    const SizedBox(width: Gap.md),
                    Text(
                      'Delete ride',
                      style: TanklyType.ui(TanklyType.body, color: p.critical),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.screen, 0, Gap.screen, Gap.xl),
          children: [
            Stack(
              children: [
                RouteMap(
                  route: record.route,
                  height: 232,
                  borderRadius: BorderRadius.circular(Radii.card),
                  startLabel: record.startLabel,
                  endLabel: record.endLabel,
                ),
                Positioned(
                  left: Gap.md,
                  bottom: Gap.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Gap.md,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: p.surface.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(Radii.chip),
                      border: Border.all(color: p.outline),
                    ),
                    child: Text(
                      '${TimeLabel.dayMonth(record.startedAt, now: DemoData.now)} · '
                      '${record.startTimeLabel}',
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Distance',
                    value: record.distanceKm.toStringAsFixed(1),
                    unit: 'km',
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(
                    label: 'Time',
                    value: record.durationLabel.split(' ').first,
                    unit: 'min',
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.md),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Avg speed',
                    value: record.avgKmph.toStringAsFixed(0),
                    unit: 'km/h',
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(
                    label: 'Max speed',
                    value: record.maxKmph.toStringAsFixed(0),
                    unit: 'km/h',
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.md),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Fuel used',
                    value: '~${(record.fuelUsedL ?? 0.45).toStringAsFixed(2)}',
                    unit: 'L',
                    valueColor: p.good,
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(
                    label: 'Elevation',
                    value: record.elevationGainM.toStringAsFixed(0),
                    unit: 'm',
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.lg),
            ChartCard(
              title: 'Speed',
              value: '${record.maxKmph.toStringAsFixed(0)} km/h max',
              caption: 'Peak marked · one sample every two minutes',
              child: ProfilePlot(
                values: DemoData.eveningSpeed,
                labels: DemoData.rideTimeLabels,
                color: p.accent,
                unit: ' km/h',
                highlightIndex: DemoData.eveningPeakIndex,
              ),
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Elevation',
              value: '${record.elevationGainM.toStringAsFixed(0)} m gain',
              caption: 'GPS altitude, smoothed. Informational only.',
              child: ProfilePlot(
                values: DemoData.eveningElevation,
                labels: DemoData.rideTimeLabels,
                color: p.good,
                unit: ' m',
              ),
            ),
            const SizedBox(height: Gap.lg),
            TanklyBanner(
              icon: Icons.info_outline_rounded,
              color: p.info,
              title: 'Fuel used is an estimate',
              message:
                  '${record.distanceKm.toStringAsFixed(1)} km ÷ 37.5 km/L ≈ '
                  '~${(record.fuelUsedL ?? 0.45).toStringAsFixed(2)} L. Idle time burns fuel too, '
                  'and the graph cannot see it.',
              action: 'Fix',
              onAction: () {},
            ),
            const SizedBox(height: Gap.md),
            TankCard(
              child: Column(
                children: [
                  KeyValueRow(
                    'Started',
                    '${TimeLabel.dayMonth(record.startedAt, now: DemoData.now)}, ${record.startTimeLabel}',
                  ),
                  Divider(color: p.outline, height: Gap.lg),
                  KeyValueRow('Ended', record.endTimeLabel),
                  Divider(color: p.outline, height: Gap.lg),
                  KeyValueRow(
                    'Moving time',
                    TimeLabel.stopwatch(
                      record.movingS ?? record.durationS - 210,
                    ),
                  ),
                  Divider(color: p.outline, height: Gap.lg),
                  const KeyValueRow('Idle', '3 min 40 s'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
