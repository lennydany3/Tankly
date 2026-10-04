import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/data/models.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/fuel_gauge.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/design/tankly_brand.dart';
import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';
import 'package:tankly/screens/forms/refuel_form_screen.dart';
import 'package:tankly/screens/sheets/correction_sheets.dart';

/// Home. One hero, the fuel gauge, and everything else in service of it.
///
/// Every variant the gallery shows — normal, low, critical, loading — comes
/// from the same widget with different inputs.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onStartRide,
    this.snapshot,
    this.syncPhase = SyncPhase.synced,
    this.onOpenSettings,
    this.onOpenTrip,
    this.showQuickActions = true,
  });

  final VoidCallback onStartRide;
  final FuelSnapshot? snapshot;
  final SyncPhase syncPhase;
  final VoidCallback? onOpenSettings;
  final VoidCallback? onOpenTrip;
  final bool showQuickActions;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final fuel = snapshot;

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
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: const TanklyWordmark(),
                  ),
                ),
                const SizedBox(width: Gap.sm),
                StatusChip(phase: syncPhase),
                const SizedBox(width: Gap.xs),
                IconButton(
                  onPressed: onOpenSettings,
                  icon: const Icon(Icons.settings_outlined),
                  tooltip: 'Settings',
                  style: IconButton.styleFrom(minimumSize: const Size(44, 44)),
                ),
              ],
            ),
            const SizedBox(height: Gap.lg),
            if (fuel != null && fuel.status != FuelStatus.good) ...[
              _FuelBanner(fuel: fuel),
              const SizedBox(height: Gap.lg),
            ],
            Center(
              child: fuel == null
                  ? const _GaugeSkeleton()
                  : FuelGauge(snapshot: fuel),
            ),
            const SizedBox(height: Gap.xl),
            if (fuel == null)
              const Row(
                children: [
                  Expanded(child: Skeleton(height: 84, radius: Radii.card)),
                  SizedBox(width: Gap.md),
                  Expanded(child: Skeleton(height: 84, radius: Radii.card)),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: StatTile(
                      label: 'Mileage',
                      value: fuel.mileageKmpl.toStringAsFixed(1),
                      unit: 'km/L',
                      icon: Icons.eco_outlined,
                    ),
                  ),
                  const SizedBox(width: Gap.md),
                  Expanded(
                    child: StatTile(
                      label: 'Since refuel',
                      value: fuel.kmSinceAnchor.toStringAsFixed(0),
                      unit: 'km',
                      icon: Icons.route_rounded,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: Gap.lg),
            TanklyRideButton(label: 'Start ride', onPressed: onStartRide),
            if (showQuickActions) ...[
              const SizedBox(height: Gap.md),
              Row(
                children: [
                  QuickActionButton(
                    icon: Icons.local_gas_station_rounded,
                    label: 'Add refuel',
                    onTap: () => RefuelFormScreen.show(context),
                  ),
                  const SizedBox(width: Gap.sm),
                  QuickActionButton(
                    icon: Icons.lightbulb_outline_rounded,
                    label: 'Light came on',
                    onTap: () => CorrectionSheet.show(context),
                  ),
                  const SizedBox(width: Gap.sm),
                  QuickActionButton(
                    icon: Icons.speed_rounded,
                    label: 'Sync odometer',
                    onTap: () => OdometerSheet.show(context),
                  ),
                ],
              ),
            ],
            const SizedBox(height: Gap.xl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Last ride',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TanklyType.ui(
                      TanklyType.title - 2,
                      weight: 700,
                      color: p.text,
                    ),
                  ),
                ),
                const SizedBox(width: Gap.sm),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: const Size(48, 36),
                    padding: const EdgeInsets.symmetric(horizontal: Gap.sm),
                  ),
                  child: const Text('All trips'),
                ),
              ],
            ),
            const SizedBox(height: Gap.sm),
            TripCard(trip: DemoData.eveningRide, onTap: onOpenTrip),
            const SizedBox(height: Gap.lg),
            const _MonthStrip(),
          ],
        ),
      ),
    );
  }
}

/// Start Ride. 72 dp, accent fill, dark text. The biggest target in the app.
class TanklyRideButton extends StatelessWidget {
  const TanklyRideButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: Sizes.rideButton,
      width: double.infinity,
      child: Material(
        color: p.accent,
        borderRadius: BorderRadius.circular(Radii.riding),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: TanklyBrand.bg, size: 30),
              const SizedBox(width: Gap.md),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TanklyType.ui(
                    TanklyType.title,
                    weight: 700,
                    color: TanklyBrand.bg,
                    tracking: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FuelBanner extends StatelessWidget {
  const _FuelBanner({required this.fuel});

  final FuelSnapshot fuel;

  @override
  Widget build(BuildContext context) {
    final color = fuelColor(context, fuel.status);
    final message = switch (fuel.status) {
      FuelStatus.low =>
        'About ${fuel.rangeKm.toStringAsFixed(0)} km left. Worth filling up soon.',
      FuelStatus.critical => 'At the reserve line. Ride to the nearest pump.',
      _ => '',
    };
    return TanklyBanner(
      icon: fuelIcon(fuel.status),
      color: color,
      title:
          '${fuel.status.label} fuel · ~${fuel.rangeKm.toStringAsFixed(0)} km range',
      message: message,
      action: 'Fix',
      onAction: () => CorrectionSheet.show(context),
    );
  }
}

class _MonthStrip extends StatelessWidget {
  const _MonthStrip();

  @override
  Widget build(BuildContext context) {
    return TankCard(
      padding: const EdgeInsets.symmetric(
        horizontal: Gap.card,
        vertical: Gap.md + 2,
      ),
      child: Row(
        children: [
          Expanded(
            child: InlineStat(
              value: DemoData.monthDistanceKm.toStringAsFixed(0),
              unit: 'km',
              label: 'Last 30 days',
            ),
          ),
          const _Separator(),
          Expanded(
            child: InlineStat(
              value: '${DemoData.monthRides}',
              unit: 'rides',
              label: 'Rides',
            ),
          ),
          const _Separator(),
          Expanded(
            child: InlineStat(
              value: DemoData.rupees(DemoData.costPerKm, decimals: 1),
              unit: '/km',
              label: 'Cost per km',
            ),
          ),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 30, color: context.palette.outline);
}

class _GaugeSkeleton extends StatelessWidget {
  const _GaugeSkeleton();

  @override
  Widget build(BuildContext context) => const SizedBox.square(
    dimension: 260,
    child: Skeleton(height: 260, radius: 130),
  );
}
