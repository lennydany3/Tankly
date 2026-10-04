import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/data/models.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/dialogs.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Account and backup. Sync state is always visible, never a spinner mystery.
class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
    this.phase = SyncPhase.synced,
    this.pending = 0,
  });

  final SyncPhase phase;
  final int pending;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(title: const Text('Account and backup')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.screen, 0, Gap.screen, Gap.xl),
          children: [
            const _GoogleCard(),
            const SizedBox(height: Gap.lg),
            _SyncCard(phase: phase, pending: pending),
            const SizedBox(height: Gap.lg),
            const Eyebrow('Your data'),
            const SizedBox(height: Gap.sm + 2),
            Row(
              children: [
                Expanded(
                  child: TanklyButton(
                    label: 'Export',
                    icon: Icons.file_upload_outlined,
                    variant: TanklyButtonVariant.secondary,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: TanklyButton(
                    label: 'Import',
                    icon: Icons.file_download_outlined,
                    variant: TanklyButtonVariant.secondary,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.md),
            TankCard(
              padding: const EdgeInsets.all(Gap.md + 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 18, color: p.textDim),
                  const SizedBox(width: Gap.md),
                  Expanded(
                    child: Text(
                      'Export files contain your full location history. Tankly only uploads '
                      'to your own Supabase project, protected by row-level security.',
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gap.xl),
            const Eyebrow('Danger zone'),
            const SizedBox(height: Gap.sm + 2),
            TankCard(
              borderColor: p.critical.withValues(alpha: 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 19,
                        color: p.critical,
                      ),
                      const SizedBox(width: Gap.md),
                      Expanded(
                        child: Text(
                          'Delete cloud data',
                          style: TanklyType.ui(
                            TanklyType.body,
                            weight: 600,
                            color: p.critical,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gap.sm),
                  Padding(
                    padding: const EdgeInsets.only(left: 37),
                    child: Text(
                      'Removes every ride and refuel from the cloud and signs you out. '
                      'Data on this phone is kept.',
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: Gap.md),
                  TanklyButton(
                    label: 'Delete cloud data',
                    icon: Icons.delete_outline_rounded,
                    variant: TanklyButtonVariant.secondary,
                    onPressed: () => DeleteConfirmDialog.show(
                      context,
                      title: 'Delete cloud data?',
                      message:
                          'Every ride and refuel will be removed from the cloud and you will '
                          'be signed out. Rides stored on this phone stay put.',
                      confirmLabel: 'Delete',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleCard extends StatelessWidget {
  const _GoogleCard();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: p.accentSoft,
              borderRadius: BorderRadius.circular(Radii.thumb),
              border: Border.all(color: p.outline),
            ),
            alignment: Alignment.center,
            child: Text(
              'A',
              style: TanklyType.number(22, weight: 700, color: p.accent),
            ),
          ),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arjun S.',
                  style: TanklyType.ui(
                    TanklyType.body + 2,
                    weight: 700,
                    color: p.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'arjun.s@gmail.com',
                  style: TanklyType.ui(TanklyType.label, color: p.textDim),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Sign out',
              style: TanklyType.ui(
                TanklyType.label,
                weight: 600,
                color: p.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncCard extends StatelessWidget {
  const _SyncCard({required this.phase, required this.pending});

  final SyncPhase phase;
  final int pending;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (icon, color, headline) = switch (phase) {
      SyncPhase.synced => (
        Icons.cloud_done_rounded,
        p.good,
        'Everything is backed up',
      ),
      SyncPhase.syncing => (
        Icons.cloud_sync_rounded,
        p.info,
        'Syncing 12 of 40 items',
      ),
      SyncPhase.offline => (
        Icons.cloud_off_rounded,
        p.textDim,
        'Offline · 4 items waiting',
      ),
      SyncPhase.failed => (
        Icons.error_outline_rounded,
        p.critical,
        'Sync failed',
      ),
      SyncPhase.gpsSearching => (
        TanklyIcons.gpsSearching,
        p.info,
        'Waiting for GPS',
      ),
    };

    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: Gap.sm + 2),
              Expanded(
                child: Text(
                  headline,
                  style: TanklyType.ui(
                    TanklyType.body,
                    weight: 700,
                    color: p.text,
                  ),
                ),
              ),
              StatusChip(phase: phase),
            ],
          ),
          const SizedBox(height: Gap.md),
          Text(
            'Last synced today at 11:02 am',
            style: TanklyType.ui(TanklyType.caption, color: p.textDim),
          ),
          const SizedBox(height: Gap.md),
          Row(
            children: [
              _SyncStat(value: '$pending', label: 'Pending'),
              _SyncStat(
                value: '${DemoData.rides.length + 398}',
                label: 'Rides',
              ),
              _SyncStat(
                value: '${DemoData.refuels.length + 33}',
                label: 'Refuels',
              ),
              _SyncStat(
                value: '${DemoData.reminders.length + 7}',
                label: 'Reminders',
              ),
            ],
          ),
          const SizedBox(height: Gap.lg),
          TanklyButton(
            label: 'Sync now',
            icon: Icons.sync_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SyncStat extends StatelessWidget {
  const _SyncStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TanklyType.number(22, weight: 700, color: p.text, height: 1),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TanklyType.ui(TanklyType.caption, color: p.textDim),
          ),
        ],
      ),
    );
  }
}
