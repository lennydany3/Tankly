import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/data/models.dart';
import 'package:tankly/design/charts.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Stats. Range selector, then one card per question the rider asks.
class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _range = 1;

  /// Month is framed as a rolling 30 days so the totals match the refuel log.
  String get _windowLabel => switch (_range) {
    0 => 'This week',
    1 => 'Last 30 days',
    _ => 'Last 12 months',
  };

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

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
            Text(
              'Stats',
              style: TanklyType.ui(
                TanklyType.headline,
                weight: 700,
                color: p.text,
              ),
            ),
            const SizedBox(height: Gap.lg),
            RangeSegments(
              labels: const ['Week', 'Month', 'Year'],
              index: _range,
              onChanged: (value) => setState(() => _range = value),
            ),
            const SizedBox(height: Gap.md),
            Text(
              _windowLabel,
              style: TanklyType.ui(TanklyType.caption, color: p.textDim),
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Total distance',
                    value: DemoData.monthDistanceKm.toStringAsFixed(0),
                    unit: 'km',
                    icon: Icons.route_rounded,
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(
                    label: 'Rides',
                    value: '${DemoData.monthRides}',
                    icon: Icons.two_wheeler_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Cost per km',
              value: DemoData.rupees(DemoData.costPerKm, decimals: 1),
              caption: 'Total spend ÷ distance ridden',
              child: Sparkline(
                values: DemoData.costTrend.map((e) => e.$2).toList(),
                color: p.accent,
                height: 52,
              ),
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Mileage trend',
              value: '37.5 km/L',
              caption: 'Learned from your full-tank refuels',
              child: LinePlot(
                values: DemoData.mileageTrend.map((e) => e.$2).toList(),
                labels: DemoData.mileageTrend.map((e) => e.$1).toList(),
                color: p.good,
                unit: 'km/L',
              ),
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Monthly spend',
              value: DemoData.rupees(DemoData.monthSpend),
              caption: 'October is 4 days in',
              child: BarPlot(
                values: DemoData.monthlySpend
                    .map((e) => e.$2.toDouble())
                    .toList(),
                labels: DemoData.monthlySpend.map((e) => e.$1).toList(),
              ),
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Time in the saddle',
              value: '9 h 40 min',
              caption: 'Across 31 rides · 18 min average',
              child: BarPlot(
                values: const [3.2, 5.4, 7.1, 6.2, 9.7],
                labels: const ['W1', 'W2', 'W3', 'W4', 'W5'],
                color: p.info,
              ),
            ),
            const SizedBox(height: Gap.lg),
            TanklyBanner(
              icon: Icons.insights_rounded,
              color: p.info,
              title: 'Your best month yet',
              message:
                  'You spent less per kilometre in ${TimeLabel.monthShort(DemoData.now)} than in any month since June. The distance factor is doing its job.',
            ),
          ],
        ),
      ),
    );
  }
}
