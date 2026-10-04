import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/domain/fuel/fuel_engine.dart';
import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/dialogs.dart';
import 'package:tankly/design/fuel_gauge.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/domain/models/trip.dart';

/// Review the numbers before the ride is written to the log.
class FinishRideScreen extends StatefulWidget {
  const FinishRideScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const FinishRideScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<FinishRideScreen> createState() => _FinishRideScreenState();
}

class _FinishRideScreenState extends State<FinishRideScreen> {
  bool _addFillUp = false;

  /// The tank as it will stand once this one ride is written to the log.
  FuelSnapshot get _afterRide => FuelEngine.compute(
    vehicle: DemoData.vehicle,
    anchor: DemoData.anchor,
    rides: [
      RideSample(
        startedAt: DemoData.anchor.at.add(const Duration(minutes: 90)),
        distanceKm: DemoData.eveningRide.distanceKm,
      ),
    ],
    now: DemoData.now,
  );

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final snapshot = _afterRide;
    final ride = DemoData.eveningRide;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: const Text('Finish this ride?'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.screen, 0, Gap.screen, Gap.xl),
          children: [
            Center(
              child: FuelGauge(
                snapshot: snapshot,
                size: 176,
                showLegend: false,
              ),
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Distance',
                    value: ride.distanceKm.toStringAsFixed(1),
                    unit: 'km',
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(label: 'Duration', value: '42', unit: 'min'),
                ),
              ],
            ),
            const SizedBox(height: Gap.md),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Fuel used',
                    value: '~${ride.fuelUsedL!.toStringAsFixed(2)}',
                    unit: 'L',
                    valueColor: p.good,
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: StatTile(
                    label: 'Left in tank',
                    value: '~${snapshot.litresLeft.toStringAsFixed(2)}',
                    unit: 'L',
                    valueColor: p.low,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.lg),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.xs,
              ),
              child: SwitchRow(
                title: 'I filled up right after',
                subtitle: 'Logs a full refuel and recalibrates your mileage.',
                value: _addFillUp,
                icon: Icons.local_gas_station_outlined,
                onChanged: (value) => setState(() => _addFillUp = value),
              ),
            ),
            const SizedBox(height: Gap.md),
            TanklyBanner(
              icon: Icons.info_outline_rounded,
              color: p.info,
              title: 'Fuel used is an estimate',
              message:
                  '${ride.distanceKm.toStringAsFixed(1)} km ÷ 37.5 km/L ≈ ~'
                  '${ride.fuelUsedL!.toStringAsFixed(2)} L. Idle time burns fuel too, and the '
                  'graph cannot see it.',
            ),
            const SizedBox(height: Gap.xl),
            TanklyButton(
              label: 'Save ride',
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: Gap.sm),
            TanklyButton(
              label: 'Discard ride',
              variant: TanklyButtonVariant.ghost,
              onPressed: () => DeleteConfirmDialog.show(
                context,
                title: 'Discard this ride?',
                message:
                    '${ride.distanceKm.toStringAsFixed(1)} km and 42 minutes will not be added '
                    'to your log. This cannot be undone.',
                confirmLabel: 'Discard',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
