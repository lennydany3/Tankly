import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/data/models.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/screens/forms/reminder_form_screen.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Service by kilometres, documents by date.
///
/// Account and Settings have no drawer to live in, so this tab carries them as
/// the last two rows. Nothing important is more than one tap from anywhere.
class RemindersScreen extends StatelessWidget {
  const RemindersScreen({
    super.key,
    this.empty = false,
    this.onOpenAccount,
    this.onOpenSettings,
  });

  final bool empty;
  final VoidCallback? onOpenAccount;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final overdue = DemoData.reminders
        .where((r) => r.urgency == ReminderUrgency.overdue)
        .length;

    return Scaffold(
      backgroundColor: p.bg,
      floatingActionButton: empty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => ReminderFormScreen.show(context),
              backgroundColor: p.accent,
              foregroundColor: TanklyBrand.bg,
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.riding),
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(
                'Add reminder',
                style: TanklyType.ui(
                  TanklyType.body,
                  weight: 700,
                  color: TanklyBrand.bg,
                ),
              ),
            ),
      body: SafeArea(
        bottom: false,
        child: empty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Gap.screen,
                      Gap.md,
                      Gap.screen,
                      0,
                    ),
                    child: Text(
                      'Reminders',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TanklyType.ui(
                        TanklyType.headline,
                        weight: 700,
                        color: p.text,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: EmptyState(
                      icon: Icons.notifications_none_rounded,
                      title: 'Nothing to remember yet',
                      message:
                          'Track oil changes by kilometres and insurance or PUC by date. '
                          'Tankly nudges you before each one is due.',
                      action: 'Add reminder',
                    ),
                  ),
                ],
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(
                  Gap.screen,
                  Gap.md,
                  Gap.screen,
                  96,
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Reminders',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TanklyType.ui(
                            TanklyType.headline,
                            weight: 700,
                            color: p.text,
                          ),
                        ),
                      ),
                      if (overdue > 0) ...[
                        const SizedBox(width: Gap.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: p.critical.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(Radii.chip),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                size: 15,
                                color: p.critical,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  '$overdue overdue',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TanklyType.ui(
                                    TanklyType.caption,
                                    weight: 700,
                                    color: p.critical,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: Gap.lg),
                  if (overdue > 0) ...[
                    TanklyBanner(
                      icon: Icons.assignment_late_outlined,
                      color: p.critical,
                      title: 'PUC is overdue by 3 days',
                      message:
                          'Your scooter may not pass an emissions check until it is renewed.',
                      action: 'Renew',
                      onAction: () {},
                    ),
                    const SizedBox(height: Gap.lg),
                  ],
                  _Group(
                    eyebrow:
                        'Service · odometer ${DemoData.odometerKm.toStringAsFixed(0)} km',
                    reminders: DemoData.reminders
                        .where((r) => r.kind == ReminderKind.service)
                        .toList(),
                  ),
                  const SizedBox(height: Gap.lg),
                  _Group(
                    eyebrow: 'Documents',
                    reminders: DemoData.reminders
                        .where((r) => r.kind == ReminderKind.document)
                        .toList(),
                  ),
                  const SizedBox(height: Gap.xl),
                  const Eyebrow('More'),
                  const SizedBox(height: Gap.sm + 2),
                  TankCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        SettingsRow(
                          icon: Icons.person_outline_rounded,
                          title: 'Account',
                          subtitle: 'Sign in, profile and linked vehicles',
                          onTap: onOpenAccount,
                        ),
                        Divider(height: 1, color: p.outline),
                        SettingsRow(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          subtitle: 'Units, reminders, backup and privacy',
                          onTap: onOpenSettings,
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

class _Group extends StatelessWidget {
  const _Group({required this.eyebrow, required this.reminders});

  final String eyebrow;
  final List<ReminderRecord> reminders;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(eyebrow),
        const SizedBox(height: Gap.sm + 2),
        for (final reminder in reminders)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.sm + 2),
            child: ReminderRow(reminder: reminder),
          ),
      ],
    );
  }
}
