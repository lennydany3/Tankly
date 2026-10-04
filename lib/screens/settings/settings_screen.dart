import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';
import 'package:tankly/screens/onboarding/onboarding_screens.dart';

/// Settings. Grouped, one concern per row, current value always visible.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = true;
  bool _lowFuelAlerts = true;
  bool _reminders = true;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.screen, 0, Gap.screen, Gap.xl),
          children: [
            const Eyebrow('Vehicle'),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.two_wheeler_rounded,
              title: DemoData.vehicle.name,
              subtitle:
                  '${DemoData.tankCapacityL.toStringAsFixed(1)} L tank · '
                  '${DemoData.odometerKm.toStringAsFixed(0)} km',
              value: 'Edit',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const VehicleSetupScreen(editing: true),
                ),
              ),
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Fuel estimate'),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.shield_outlined,
              title: 'Safety margin',
              subtitle: 'Range is quoted at this share of real mileage.',
              value: '90 %',
              onTap: () {},
            ),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.notifications_active_outlined,
              title: 'Low-fuel alert level',
              subtitle: 'Below this, the strip turns red and pulses.',
              value: '${DemoData.alertL.toStringAsFixed(2)} L',
              onTap: () {},
            ),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.xs,
              ),
              child: SwitchRow(
                title: 'Low-fuel alerts',
                subtitle: 'Fires once each time you cross the alert level.',
                value: _lowFuelAlerts,
                icon: Icons.local_gas_station_outlined,
                onChanged: (value) => setState(() => _lowFuelAlerts = value),
              ),
            ),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.straighten_rounded,
              title: 'Distance correction',
              subtitle: 'Nudges GPS distance toward your odometer.',
              value: '×1.00',
              onTap: () {},
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Speedometer'),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.speed_rounded, size: 19, color: p.textDim),
                      const SizedBox(width: Gap.md),
                      Expanded(
                        child: Text(
                          'Speed offset',
                          style: TanklyType.ui(
                            TanklyType.body,
                            weight: 600,
                            color: p.text,
                          ),
                        ),
                      ),
                      Text(
                        '+3 km/h',
                        style: TanklyType.number(
                          TanklyType.title - 2,
                          weight: 700,
                          color: p.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gap.md),
                  Slider(
                    value: 3,
                    max: 15,
                    divisions: 30,
                    label: '+3 km/h',
                    onChanged: (_) {},
                  ),
                  Text(
                    'Your Activa 6G reads about 12 % high. This is applied to the Live Trip '
                    'speed only, never to distance.',
                    style: TanklyType.ui(
                      TanklyType.caption,
                      color: p.textDim,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Appearance and units'),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              padding: const EdgeInsets.all(Gap.sm + 2),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Theme',
                      style: TanklyType.ui(
                        TanklyType.body,
                        weight: 600,
                        color: p.text,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 172,
                    child: RangeSegments(
                      labels: const ['Dark', 'Light'],
                      index: _dark ? 0 : 1,
                      onChanged: (value) => setState(() => _dark = value == 0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.straighten_outlined,
              title: 'Units',
              subtitle: 'Kilometres, litres, km/L',
              value: 'Metric',
              onTap: () {},
            ),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.xs,
              ),
              child: SwitchRow(
                title: 'Reminder notifications',
                subtitle: 'Service and document nudges.',
                value: _reminders,
                icon: Icons.notifications_none_rounded,
                onChanged: (value) => setState(() => _reminders = value),
              ),
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Data'),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.file_upload_outlined,
              title: 'Export a backup',
              subtitle: 'Gzipped JSON of every ride and refuel.',
              onTap: () {},
            ),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.file_download_outlined,
              title: 'Import a backup',
              onTap: () {},
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('About'),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.info_outline_rounded,
              title: 'Tankly',
              subtitle: 'Version 1.0.0 · build 1',
              showChevron: false,
            ),
            const SizedBox(height: Gap.sm + 2),
            SettingsRow(
              icon: Icons.help_outline_rounded,
              title: 'How the estimate works',
              showChevron: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
