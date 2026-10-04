import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/inputs.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Correction actions. Three ways to tell Tankly the truth about the tank.
///
/// Each row previews the resulting level, because a correction that silently
/// moves the number by 0.5 L is impossible to trust.
class CorrectionSheet extends StatelessWidget {
  const CorrectionSheet({super.key});

  static Future<void> show(BuildContext context) {
    return TanklySheet.show(context, const CorrectionSheet());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TanklySheet(
      title: 'Correct the estimate',
      subtitle:
          'Pick what actually happened. Everything after it recalculates.',
      child: Column(
        children: [
          _CorrectionRow(
            icon: Icons.lightbulb_outline_rounded,
            title: 'Light came on',
            result: DemoData.litres(DemoData.vehicle.reserveL),
            message:
                'Sets petrol to your ${DemoData.vehicle.reserveL.toStringAsFixed(2)} L reserve.',
            tint: p.medium,
            onTap: () => Navigator.of(context).pop(),
          ),
          _CorrectionRow(
            icon: Icons.no_drinks_outlined,
            title: 'Ran dry',
            result: '0.00 L',
            message:
                'Sets petrol to zero and teaches the leftover next refuel.',
            tint: p.critical,
            onTap: () => Navigator.of(context).pop(),
          ),
          _CorrectionRow(
            icon: Icons.two_wheeler_rounded,
            title: 'Still running',
            result: DemoData.litres(0.20),
            message:
                'Adds a small bonus when the scooter runs past the estimate.',
            tint: p.info,
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _CorrectionRow extends StatelessWidget {
  const _CorrectionRow({
    required this.icon,
    required this.title,
    required this.message,
    required this.result,
    required this.tint,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String message;
  final String result;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.md - 4),
      child: TankCard(
        onTap: onTap,
        padding: const EdgeInsets.all(Gap.md + 2),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(Radii.thumb),
              ),
              child: Icon(icon, color: tint, size: 22),
            ),
            const SizedBox(width: Gap.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TanklyType.ui(
                            TanklyType.body,
                            weight: 700,
                            color: p.text,
                          ),
                        ),
                      ),
                      const SizedBox(width: Gap.sm),
                      Text(
                        result,
                        style: TanklyType.number(
                          TanklyType.label,
                          weight: 700,
                          color: tint,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TanklyType.ui(
                      TanklyType.caption,
                      color: p.textDim,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Gap.sm),
            Icon(Icons.chevron_right_rounded, color: p.textDim, size: 22),
          ],
        ),
      ),
    );
  }
}

/// Odometer sync. Shows what the phone measured against what the scooter says.
class OdometerSheet extends StatefulWidget {
  const OdometerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return TanklySheet.show(context, const OdometerSheet());
  }

  @override
  State<OdometerSheet> createState() => _OdometerSheetState();
}

class _OdometerSheetState extends State<OdometerSheet> {
  static const _gpsKm = 41.2;
  static const _lastCheckedKm = 18317.0;

  late final TextEditingController _controller = TextEditingController(
    text: DemoData.odometerKm.toStringAsFixed(0),
  );

  double get _entered =>
      double.tryParse(_controller.text) ?? DemoData.odometerKm;
  double get _drift => _entered - _lastCheckedKm - _gpsKm;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TanklySheet(
      title: 'Sync odometer',
      subtitle:
          'Type the reading on your scooter dial. Tankly trusts the scooter.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumericField(
            label: 'Odometer now',
            value: _controller.text,
            unit: 'km',
            icon: Icons.speed_rounded,
            onChanged: (_) => setState(() {}),
          ),
          TankCard(
            padding: const EdgeInsets.all(Gap.md + 2),
            child: Column(
              children: [
                KeyValueRow(
                  'Last checked',
                  '${_lastCheckedKm.toStringAsFixed(0)} km',
                ),
                Divider(color: p.outline, height: Gap.lg),
                KeyValueRow('GPS measured', '${_gpsKm.toStringAsFixed(1)} km'),
                Divider(color: p.outline, height: Gap.lg),
                KeyValueRow(
                  'Difference',
                  '${_drift >= 0 ? '+' : ''}${_drift.toStringAsFixed(1)} km',
                  valueColor: _drift.abs() < 3 ? p.good : p.medium,
                ),
              ],
            ),
          ),
          const SizedBox(height: Gap.md),
          Text(
            _drift.abs() < 3
                ? 'GPS and the scooter agree. Distance factor stays at 1.00.'
                : 'Distance factor will be nudged by ${(_drift / _gpsKm * 100).toStringAsFixed(1)}% so future estimates match your dial.',
            style: TanklyType.ui(
              TanklyType.caption + 1,
              color: p.textDim,
              height: 1.4,
            ),
          ),
          const SizedBox(height: Gap.lg),
          TanklyButton(
            label: 'Save reading',
            icon: Icons.check_rounded,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
