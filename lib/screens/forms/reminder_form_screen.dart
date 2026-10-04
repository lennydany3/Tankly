import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../design/controls.dart';
import '../../design/inputs.dart';
import '../../design/surfaces.dart';
import '../../theme/tankly_palette.dart';
import '../../theme/tankly_tokens.dart';
import '../../theme/tankly_type.dart';

/// New or edited reminder. Type decides which fields are meaningful.
class ReminderFormScreen extends StatefulWidget {
  const ReminderFormScreen({super.key, this.editing = false});

  final bool editing;

  static Future<void> show(BuildContext context, {bool editing = false}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ReminderFormScreen(editing: editing)),
    );
  }

  @override
  State<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends State<ReminderFormScreen> {
  bool _byKilometres = true;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text(widget.editing ? 'Edit reminder' : 'New reminder'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
            const Eyebrow('Reminder type'),
            const SizedBox(height: Gap.sm + 2),
            Row(
              children: [
                Expanded(
                  child: _TypeCard(
                    icon: Icons.build_outlined,
                    title: 'Service',
                    subtitle: 'By kilometres',
                    selected: _byKilometres,
                    onTap: () => setState(() => _byKilometres = true),
                  ),
                ),
                const SizedBox(width: Gap.sm + 2),
                Expanded(
                  child: _TypeCard(
                    icon: Icons.description_outlined,
                    title: 'Document',
                    subtitle: 'By date',
                    selected: !_byKilometres,
                    onTap: () => setState(() => _byKilometres = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.xl),
            LabelledField(
              label: 'Title',
              value: 'Oil change',
              icon: Icons.edit_outlined,
              helper: 'Whatever you would call it on a receipt.',
            ),
            if (_byKilometres) ...[
              NumericField(
                label: 'Due at odometer',
                value: (DemoData.odometerKm + 320).toStringAsFixed(0),
                unit: 'km',
                icon: Icons.speed_rounded,
                helper:
                    'Odometer is now ${DemoData.odometerKm.toStringAsFixed(0)} km, '
                    'so this is due in 320 km.',
              ),
              NumericField(
                label: 'Repeat every',
                value: '2000',
                unit: 'km',
                icon: Icons.repeat_rounded,
                helper: 'Leave empty for a one-off reminder.',
              ),
              NumericField(
                label: 'Notify me before',
                value: '100',
                unit: 'km',
                icon: Icons.notifications_none_rounded,
              ),
            ] else ...[
              PickerRow(
                label: '',
                value: '16 Oct 2026',
                icon: Icons.event_rounded,
                onTap: () {},
                helper: 'Tankly nudges you 30, 7 and 1 day before it expires.',
              ),
              NumericField(
                label: 'Notify me before',
                value: '30',
                unit: 'days',
                icon: Icons.notifications_none_rounded,
              ),
            ],
            const SizedBox(height: Gap.sm),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.xs,
              ),
              child: SwitchRow(
                title: 'Repeat automatically',
                subtitle: _byKilometres
                    ? 'Re-arms 2,000 km after you mark it done.'
                    : 'Re-arms one year after the date.',
                value: true,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(height: Gap.xl),
            TanklyButton(
              label: 'Save reminder',
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      onTap: onTap,
      color: selected ? p.accentSoft : p.surface,
      borderColor: selected ? p.accent : p.outline,
      padding: const EdgeInsets.all(Gap.md + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: selected ? p.accent : p.textDim),
              const Spacer(),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                size: 19,
                color: selected ? p.accent : p.outline,
              ),
            ],
          ),
          const SizedBox(height: Gap.sm + 2),
          Text(
            title,
            style: TanklyType.ui(TanklyType.body, weight: 700, color: p.text),
          ),
          Text(
            subtitle,
            style: TanklyType.ui(TanklyType.caption, color: p.textDim),
          ),
        ],
      ),
    );
  }
}
