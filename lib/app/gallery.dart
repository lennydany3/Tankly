import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../data/models.dart';
import '../design/charts.dart';
import '../design/controls.dart';
import '../design/data_display.dart';
import '../design/dialogs.dart';
import '../design/fuel_gauge.dart';
import '../design/surfaces.dart';
import '../design/tankly_brand.dart';
import '../domain/fuel.dart';
import '../screens/flows/finish_ride_screen.dart';
import '../screens/forms/refuel_form_screen.dart';
import '../screens/forms/reminder_form_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/live/live_trip_screen.dart';
import '../screens/onboarding/onboarding_screens.dart';
import '../screens/settings/account_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/sheets/correction_sheets.dart';
import '../screens/tabs/fuel_screen.dart';
import '../screens/tabs/reminders_screen.dart';
import '../screens/tabs/stats_screen.dart';
import '../screens/tabs/trips_screen.dart';
import '../screens/trip_detail/trip_detail_screen.dart';
import '../theme/tankly_palette.dart';
import '../theme/tankly_tokens.dart';
import '../theme/tankly_type.dart';

/// One reviewable screen plus its meaningful variants.
class GalleryEntry {
  const GalleryEntry(this.group, this.name, this.build, {this.note});

  final String group;
  final String name;
  final String? note;
  final Widget Function(BuildContext context) build;
}

/// Browsable list of everything, at real size.
class DesignGallery extends StatelessWidget {
  const DesignGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final entries = galleryEntries();

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: const Text('Design gallery'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const StyleSheetScreen())),
            child: Text(
              'Style sheet',
              style: TanklyType.ui(
                TanklyType.label,
                weight: 700,
                color: p.accent,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            Gap.screen,
            Gap.sm,
            Gap.screen,
            Gap.xl,
          ),
          itemCount: entries.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: Gap.sm),
          itemBuilder: (context, index) {
            if (index == entries.length) {
              return Padding(
                padding: const EdgeInsets.only(top: Gap.lg),
                child: Column(
                  children: [
                    const LowFuelNotificationMock(),
                    const SizedBox(height: Gap.md),
                    Text(
                      'System dialogs and notifications',
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                      ),
                    ),
                  ],
                ),
              );
            }
            final entry = entries[index];
            return SettingsRow(
              icon: _iconFor(entry.group),
              title: entry.name,
              subtitle:
                  '${entry.group}${entry.note == null ? '' : ' · ${entry.note}'}',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GalleryScreenPage(entry: entry),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static IconData _iconFor(String group) => switch (group) {
    'Onboarding' => Icons.waving_hand_outlined,
    'Main' => Icons.home_outlined,
    'Tabs' => Icons.tab_rounded,
    'Trip' => Icons.route_outlined,
    'Fuel' => Icons.local_gas_station_outlined,
    'Settings' => Icons.settings_outlined,
    _ => Icons.widgets_outlined,
  };
}

/// The entry rendered full screen, with a caption bar naming what you are seeing.
class GalleryScreenPage extends StatelessWidget {
  const GalleryScreenPage({super.key, required this.entry});

  final GalleryEntry entry;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text(entry.name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(26),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Gap.screen,
              right: Gap.screen,
              bottom: Gap.sm,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                entry.note ?? '${entry.group} · 390 × 844',
                style: TanklyType.ui(TanklyType.caption, color: p.textDim),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(top: false, child: entry.build(context)),
    );
  }
}

/// Every screen, every variant, in review order.
List<GalleryEntry> galleryEntries() => [
  GalleryEntry('Onboarding', '1 · Splash', (_) => const SplashScreen()),
  GalleryEntry(
    'Onboarding',
    '2 · Sign in',
    (_) => const SignInScreen(),
    note: 'dismissible',
  ),
  GalleryEntry(
    'Onboarding',
    '3 · Permissions',
    (_) => const PermissionsScreen(),
  ),
  GalleryEntry(
    'Onboarding',
    '4 · Vehicle setup',
    (_) => const VehicleSetupScreen(),
  ),
  GalleryEntry(
    'Main',
    '5 · Home · low fuel',
    (_) => HomeScreen(onStartRide: () {}, snapshot: DemoData.fuelNow),
  ),
  GalleryEntry(
    'Main',
    '5 · Home · healthy',
    (_) => HomeScreen(onStartRide: () {}, snapshot: DemoData.fuelHealthy),
  ),
  GalleryEntry(
    'Main',
    '5 · Home · loading',
    (_) => HomeScreen(onStartRide: () => {}, snapshot: null),
    note: 'skeleton gauge',
  ),
  GalleryEntry(
    'Main',
    '5 · Home · offline',
    (_) => HomeScreen(
      onStartRide: () {},
      snapshot: DemoData.fuelNow,
      syncPhase: SyncPhase.offline,
    ),
    note: 'stale badge',
  ),
  GalleryEntry(
    'Main',
    '6 · Live trip · tracking',
    (_) => LiveTripScreen(snapshot: DemoData.fuelLive),
  ),
  GalleryEntry(
    'Main',
    '6 · Live trip · no GPS',
    (_) => LiveTripScreen(snapshot: DemoData.fuelLive, gps: LiveGps.searching),
  ),
  GalleryEntry(
    'Main',
    '6 · Live trip · no fuel data',
    (_) => const LiveTripScreen(),
  ),
  GalleryEntry('Tabs', '7 · Trips', (_) => const TripsScreen()),
  GalleryEntry(
    'Tabs',
    '7 · Trips · empty',
    (_) => const TripsScreen(empty: true),
  ),
  GalleryEntry('Tabs', '8 · Fuel', (_) => const FuelScreen()),
  GalleryEntry(
    'Tabs',
    '8 · Fuel · empty',
    (_) => const FuelScreen(empty: true),
  ),
  GalleryEntry('Tabs', '9 · Stats', (_) => const StatsScreen()),
  GalleryEntry('Tabs', '10 · Reminders', (_) => const RemindersScreen()),
  GalleryEntry(
    'Tabs',
    '10 · Reminders · empty',
    (_) => const RemindersScreen(empty: true),
  ),
  GalleryEntry('Trip', '11 · Trip detail', (_) => const TripDetailScreen()),
  GalleryEntry('Fuel', '12 · Refuel form', (_) => const RefuelFormScreen()),
  GalleryEntry('Fuel', '13 · Correction sheet', (_) => const CorrectionSheet()),
  GalleryEntry('Fuel', '13 · Odometer sheet', (_) => const OdometerSheet()),
  GalleryEntry('Fuel', '14 · Finish ride', (_) => const FinishRideScreen()),
  GalleryEntry('Settings', '15 · Settings', (_) => const SettingsScreen()),
  GalleryEntry(
    'Settings',
    '16 · Account · synced',
    (_) => const AccountScreen(),
  ),
  GalleryEntry(
    'Settings',
    '16 · Account · syncing',
    (_) => const AccountScreen(phase: SyncPhase.syncing, pending: 28),
  ),
  GalleryEntry(
    'Settings',
    '16 · Account · failed',
    (_) => const AccountScreen(phase: SyncPhase.failed, pending: 4),
  ),
  GalleryEntry(
    'Settings',
    '17 · Reminder form',
    (_) => const ReminderFormScreen(),
  ),
];

/// One page. Everything a designer needs to check a build against the brief.
class StyleSheetScreen extends StatelessWidget {
  const StyleSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(title: const Text('Style sheet')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Gap.screen,
            Gap.sm,
            Gap.screen,
            Gap.xl,
          ),
          children: [
            const _Brand(),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Neutrals'),
            const SizedBox(height: Gap.sm + 2),
            _Swatches(
              colors: [
                (TanklyBrand.bg, 'bg', '#0B0F14'),
                (TanklyBrand.surface, 'surface', '#131A22'),
                (TanklyBrand.surfaceHigh, 'surfaceHigh', '#1B2530'),
                (TanklyBrand.outline, 'outline', '#2A3644'),
                (TanklyBrand.text, 'text', '#F2F5F8'),
                (TanklyBrand.textDim, 'textDim', '#9AA8B8'),
              ],
              swatchFor: p,
            ),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Fuel status · reserved'),
            const SizedBox(height: Gap.sm + 2),
            _FuelRow(),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Type scale · Space Grotesk for numbers'),
            const SizedBox(height: Gap.sm + 2),
            const _TypeScale(),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Spacing and radii'),
            const SizedBox(height: Gap.sm + 2),
            const _ScaleSheet(),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Buttons'),
            const SizedBox(height: Gap.sm + 2),
            const TanklyButton(
              label: 'Primary',
              icon: Icons.check_rounded,
              onPressed: null,
            ),
            const SizedBox(height: Gap.sm),
            const TanklyButton(
              label: 'Secondary',
              variant: TanklyButtonVariant.secondary,
              onPressed: null,
            ),
            const SizedBox(height: Gap.sm),
            const TanklyButton(
              label: 'Ghost',
              variant: TanklyButtonVariant.ghost,
              onPressed: null,
            ),
            const SizedBox(height: Gap.sm),
            const TanklyButton(
              label: 'Danger',
              variant: TanklyButtonVariant.danger,
              onPressed: null,
            ),
            const SizedBox(height: Gap.sm),
            const TanklyButton(
              label: 'Start ride',
              icon: Icons.play_arrow_rounded,
              riding: true,
              onPressed: null,
            ),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Fuel gauge · every state'),
            const SizedBox(height: Gap.sm + 2),
            const _GaugeStates(),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Status chips'),
            const SizedBox(height: Gap.sm + 2),
            const Wrap(
              spacing: Gap.sm,
              runSpacing: Gap.sm,
              children: [
                StatusChip(phase: SyncPhase.synced),
                StatusChip(phase: SyncPhase.syncing),
                StatusChip(phase: SyncPhase.failed),
                StatusChip(phase: SyncPhase.offline),
                StatusChip(phase: SyncPhase.gpsSearching),
              ],
            ),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Charts'),
            const SizedBox(height: Gap.sm + 2),
            ChartCard(
              title: 'Mileage',
              value: '37.5 km/L',
              caption: 'Learned from your last three full tanks.',
              child: LinePlot(
                values: DemoData.mileageTrend.map((e) => e.$2).toList(),
                labels: DemoData.mileageTrend.map((e) => e.$1).toList(),
                unit: ' km/L',
              ),
            ),
            const SizedBox(height: Gap.md),
            ChartCard(
              title: 'Spend per month',
              value: '₹850',
              caption: 'Rolling 30 days.',
              child: BarPlot(
                values: DemoData.monthlySpend
                    .map((e) => e.$2.toDouble())
                    .toList(),
                labels: DemoData.monthlySpend.map((e) => e.$1).toList(),
                color: TanklyBrand.accent,
              ),
            ),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Empty states'),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              child: SizedBox(
                height: 240,
                child: EmptyState(
                  compact: true,
                  title: 'No rides yet',
                  message:
                      'Start a ride and Tankly will work out what is left in the tank.',
                  action: 'Start ride',
                  icon: Icons.route_rounded,
                ),
              ),
            ),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Dialogs'),
            const SizedBox(height: Gap.sm + 2),
            const DeleteConfirmDialog(
              title: 'Discard this ride?',
              message:
                  '16.8 km and 42 minutes will not be added to your log. '
                  'This cannot be undone.',
              confirmLabel: 'Discard',
            ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TanklyAppIcon(size: 56),
              const SizedBox(width: Gap.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TanklyWordmark(size: 24, showMark: false),
                    SizedBox(height: 4),
                    Text(
                      'Know your tank.',
                      style: TextStyle(
                        color: TanklyBrand.textDim,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.md),
          Text(
            'One number, always honest. Space Grotesk carries every digit; Inter carries every '
            'word. Fuel colours are reserved for fuel state and never decorative.',
            style: TanklyType.ui(
              TanklyType.label,
              color: p.textDim,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _Swatches extends StatelessWidget {
  const _Swatches({required this.colors, required this.swatchFor});

  final List<(Color, String, String)> colors;
  final TanklyPalette swatchFor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Gap.sm,
      runSpacing: Gap.sm,
      children: [
        for (final (color, name, hex) in colors)
          Container(
            width: 106,
            padding: const EdgeInsets.all(Gap.sm),
            decoration: BoxDecoration(
              color: swatchFor.surface,
              borderRadius: BorderRadius.circular(Radii.thumb),
              border: Border.all(color: swatchFor.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(Radii.chip),
                    border: Border.all(color: swatchFor.outline),
                  ),
                ),
                const SizedBox(height: Gap.sm),
                Text(
                  name,
                  style: TanklyType.ui(
                    TanklyType.label,
                    weight: 700,
                    color: swatchFor.text,
                  ),
                ),
                Text(
                  hex,
                  style: TanklyType.ui(
                    TanklyType.caption,
                    color: swatchFor.textDim,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _FuelRow extends StatelessWidget {
  const _FuelRow();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      children: [
        FuelLegend(status: FuelStatus.good, color: p.good),
        const SizedBox(height: Gap.sm),
        FuelLegend(status: FuelStatus.medium, color: p.medium),
        const SizedBox(height: Gap.sm),
        FuelLegend(status: FuelStatus.low, color: p.low),
        const SizedBox(height: Gap.sm),
        FuelLegend(status: FuelStatus.critical, color: p.critical),
      ],
    );
  }
}

class _TypeScale extends StatelessWidget {
  const _TypeScale();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final row in <(String, double, int)>[
            ('Display · 72 / 700', TanklyType.display, 700),
            ('Hero · 56 / 700', TanklyType.hero, 700),
            ('Headline · 28 / 700', TanklyType.headline, 700),
            ('Title · 20 / 700', TanklyType.title, 700),
            ('Body · 16 / 400', TanklyType.body, 400),
            ('Label · 14 / 500', TanklyType.label, 500),
            ('Caption · 12 / 400', TanklyType.caption, 400),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      '0.40 L · 37 km',
                      style: TanklyType.number(
                        row.$2,
                        weight: row.$3,
                        color: p.text,
                      ),
                    ),
                  ),
                  Text(
                    row.$1,
                    style: TanklyType.ui(TanklyType.caption, color: p.textDim),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Text('PETROL IS LOW', style: TanklyType.eyebrow(p.textDim)),
              const Spacer(),
              Text(
                'Eyebrow · 12 / 600 · +1.1 tracking',
                style: TanklyType.ui(TanklyType.caption, color: p.textDim),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScaleSheet extends StatelessWidget {
  const _ScaleSheet();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final gap in [Gap.xs, Gap.sm, Gap.md, Gap.lg, Gap.xl])
                Padding(
                  padding: const EdgeInsets.only(right: Gap.md),
                  child: Column(
                    children: [
                      Container(
                        width: gap * 2,
                        height: 24,
                        color: p.accent.withValues(alpha: 0.35),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${gap.toInt()}',
                        style: TanklyType.ui(10, color: p.textDim),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: Gap.md),
          Row(
            children: [
              for (final radius in [
                Radii.chip,
                Radii.thumb,
                Radii.button,
                Radii.card,
                Radii.sheet,
              ])
                Padding(
                  padding: const EdgeInsets.only(right: Gap.sm),
                  child: Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: p.surfaceHigh,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: p.outline),
                    ),
                    child: Text(
                      '${radius.toInt()}',
                      style: TanklyType.number(
                        11,
                        weight: 700,
                        color: p.textDim,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugeStates extends StatelessWidget {
  const _GaugeStates();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FuelGauge(
            snapshot: DemoData.fuelHealthy,
            size: 148,
            showLegend: false,
          ),
        ),
        Flexible(
          child: FuelGauge(
            snapshot: DemoData.fuelNow,
            size: 148,
            showLegend: false,
          ),
        ),
        Flexible(
          child: FuelGauge(
            snapshot: DemoData.fuelCritical,
            size: 148,
            showLegend: false,
          ),
        ),
      ],
    );
  }
}
