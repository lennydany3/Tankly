import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/design/tankly_brand.dart';

/// Every destructive action goes through this. Never a bare red button.
class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Delete',
  });

  final String title;
  final String message;
  final String confirmLabel;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Delete',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TanklyDialog(
      icon: Icons.delete_outline_rounded,
      iconColor: p.critical,
      title: title,
      message: message,
      children: [
        TanklyButton(
          label: confirmLabel,
          variant: TanklyButtonVariant.danger,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TanklyButton(
          label: 'Cancel',
          variant: TanklyButtonVariant.ghost,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}

/// Found a ride still recording when the app opened.
class ResumeTripDialog extends StatelessWidget {
  const ResumeTripDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const ResumeTripDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final ride = DemoData.eveningRide;
    return TanklyDialog(
      icon: Icons.directions_bike_rounded,
      iconColor: p.accent,
      title: 'Ride still recording?',
      message:
          'You started an evening ride at ${ride.startTimeLabel} and the app closed before '
          'you finished it. Pick up where you left off?',
      children: [
        TankCard(
          color: p.bg,
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.card,
            vertical: Gap.sm + 2,
          ),
          child: Row(
            children: [
              Expanded(
                child: InlineStat(
                  label: 'Distance',
                  value: ride.distanceKm.toStringAsFixed(1),
                  unit: 'km',
                ),
              ),
              Expanded(
                child: InlineStat(label: 'Duration', value: '42', unit: 'min'),
              ),
              Expanded(
                child: InlineStat(
                  label: 'Fuel used',
                  value: '~0.45',
                  unit: 'L',
                  color: p.good,
                ),
              ),
            ],
          ),
        ),
        TanklyButton(
          label: 'Resume this ride',
          icon: Icons.play_arrow_rounded,
          onPressed: () {},
        ),
        TanklyButton(
          label: 'Discard it',
          variant: TanklyButtonVariant.ghost,
          onPressed: () {},
        ),
      ],
    );
  }
}

/// Android heads-up notification, mocked so it can be reviewed in the gallery.
class LowFuelNotificationMock extends StatelessWidget {
  const LowFuelNotificationMock({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: 330,
      padding: const EdgeInsets.all(Gap.sm + 2),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B20),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const TanklyAppIcon(size: 24),
              const SizedBox(width: Gap.sm),
              Text(
                'Tankly · now',
                style: TanklyType.ui(
                  TanklyType.caption,
                  weight: 600,
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.sm + 2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Petrol is low',
              style: TanklyType.ui(
                TanklyType.body + 2,
                weight: 700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'About 13 km left in the tank — roughly 18 minutes.',
              style: TanklyType.ui(
                TanklyType.label,
                color: Colors.white.withValues(alpha: 0.78),
              ),
            ),
          ),
          const SizedBox(height: Gap.md),
          Row(
            children: [
              Text(
                'OPEN',
                style: TanklyType.ui(
                  TanklyType.label,
                  weight: 700,
                  color: const Color(0xFFA6C9FF),
                ),
              ),
              const Spacer(),
              Text(
                'DISMISS',
                style: TanklyType.ui(
                  TanklyType.label,
                  weight: 700,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.xs + 2),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: p.low,
              borderRadius: BorderRadius.circular(Radii.chip),
            ),
          ),
        ],
      ),
    );
  }
}
