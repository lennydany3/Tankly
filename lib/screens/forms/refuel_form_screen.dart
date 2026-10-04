import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/inputs.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/domain/fuel/fuel_engine.dart';
import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Add or edit a refuel.
///
/// A refuel is an anchor: it re-bases the estimate for every ride after it,
/// which is why the preview updates as the litres change.
class RefuelFormScreen extends StatefulWidget {
  const RefuelFormScreen({super.key, this.editing = false});

  final bool editing;

  static Future<void> show(BuildContext context, {bool editing = false}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RefuelFormScreen(editing: editing)),
    );
  }

  @override
  State<RefuelFormScreen> createState() => _RefuelFormScreenState();
}

class _RefuelFormScreenState extends State<RefuelFormScreen> {
  final _litres = TextEditingController(text: '0.93');
  final _price = TextEditingController(text: '100');
  final _odometer = TextEditingController(
    text: DemoData.odometerKm.toStringAsFixed(0),
  );

  bool _fullTank = false;

  @override
  void dispose() {
    _litres.dispose();
    _price.dispose();
    _odometer.dispose();
    super.dispose();
  }

  double get _litresValue => double.tryParse(_litres.text) ?? 0;
  double get _priceValue => double.tryParse(_price.text) ?? 0;
  double get _pricePerLitre =>
      _litresValue <= 0 ? 0 : _priceValue / _litresValue;

  /// What the gauge will read the moment this refuel is saved.
  FuelSnapshot get _preview {
    final level = _fullTank ? DemoData.vehicle.tankCapacityL : _litresValue;
    return FuelEngine.compute(
      vehicle: DemoData.vehicle,
      anchor: FuelAnchor(
        at: DemoData.now,
        levelL: level,
        kind: _fullTank ? AnchorKind.refuelFull : AnchorKind.refuelReset,
      ),
      rides: const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final preview = _preview;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text(widget.editing ? 'Edit refuel' : 'Add refuel'),
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
            NumericField(
              label: 'Litres added',
              value: _litres.text,
              unit: 'L',
              icon: Icons.local_gas_station_rounded,
              autofocus: !widget.editing,
              onChanged: (_) => setState(() {}),
            ),
            NumericField(
              label: 'Amount paid',
              value: _price.text,
              prefix: '₹',
              onChanged: (_) => setState(() {}),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.lg),
              child: Row(
                children: [
                  Icon(Icons.calculate_outlined, size: 16, color: p.textDim),
                  const SizedBox(width: Gap.sm),
                  Flexible(
                    child: Text(
                      '${DemoData.rupees(_pricePerLitre, decimals: 2)} per litre',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TanklyType.ui(
                        TanklyType.label,
                        weight: 600,
                        color: p.accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: Gap.sm),
                  Text(
                    '· Chennai, today',
                    style: TanklyType.ui(TanklyType.caption, color: p.textDim),
                  ),
                ],
              ),
            ),
            NumericField(
              label: 'Odometer',
              value: _odometer.text,
              unit: 'km',
              icon: Icons.speed_rounded,
              helper: 'Optional, but it keeps trip distances honest.',
              onChanged: (_) => setState(() {}),
            ),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.sm,
              ),
              child: SwitchRow(
                title: 'I filled the tank completely',
                subtitle: 'Gives an exact mileage reading next time.',
                value: _fullTank,
                icon: Icons.check_circle_outline_rounded,
                onChanged: (value) => setState(() => _fullTank = value),
              ),
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                Expanded(
                  child: PickerRow(
                    label: '',
                    value: 'Today · 6:45 pm',
                    icon: Icons.event_rounded,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.sm),
            PreviewCard(
              title: 'New estimate after saving',
              value: DemoData.litres(preview.litresLeft),
              secondary: '~${preview.rangeKm.toStringAsFixed(0)} km range',
              color: preview.status == FuelStatus.critical
                  ? p.critical
                  : p.accent,
              icon: Icons.auto_graph_rounded,
            ),
            const SizedBox(height: Gap.sm),
            Text(
              'Range uses ${(DemoData.vehicle.safetyFactor * 100).toStringAsFixed(0)}% of '
              '${DemoData.vehicle.mileageKmpl} km/L, so Tankly warns you early instead of '
              'running you dry.',
              style: TanklyType.ui(
                TanklyType.caption,
                color: p.textDim,
                height: 1.4,
              ),
            ),
            const SizedBox(height: Gap.xl),
            TanklyButton(
              label: 'Save refuel',
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
