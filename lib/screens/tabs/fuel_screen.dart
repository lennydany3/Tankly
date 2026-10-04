import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/data/models.dart';
import 'package:tankly/design/data_display.dart';
import 'package:tankly/design/surfaces.dart';
import 'package:tankly/screens/forms/refuel_form_screen.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Refuel log. The list that drives the estimate and teaches mileage.
class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key, this.empty = false});

  final bool empty;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      floatingActionButton: empty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => RefuelFormScreen.show(context),
              backgroundColor: p.accent,
              foregroundColor: TanklyBrand.bg,
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.riding),
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(
                'Add refuel',
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
                    child: Row(
                      children: [
                        Text(
                          'Fuel',
                          style: TanklyType.ui(
                            TanklyType.headline,
                            weight: 700,
                            color: p.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: EmptyState(
                      icon: Icons.local_gas_station_rounded,
                      title: 'No refuels logged',
                      message:
                          'Log a refuel and Tankly starts estimating your tank from that '
                          'point onwards.',
                      action: 'Add first refuel',
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
                  Text(
                    'Fuel',
                    style: TanklyType.ui(
                      TanklyType.headline,
                      weight: 700,
                      color: p.text,
                    ),
                  ),
                  const SizedBox(height: Gap.lg),
                  const _FuelSummary(),
                  const SizedBox(height: Gap.xl),
                  const SectionHeader('Refuel history'),
                  const SizedBox(height: Gap.md),
                  ..._history(context),
                ],
              ),
      ),
    );
  }

  List<Widget> _history(BuildContext context) {
    final p = context.palette;
    final rows = <Widget>[];
    String? lastMonth;

    for (final refuel in DemoData.refuels) {
      final month = TimeLabel.monthYear(refuel.at);
      if (month != lastMonth) {
        lastMonth = month;
        rows.add(
          Padding(
            padding: const EdgeInsets.only(top: Gap.sm, bottom: Gap.sm),
            child: Eyebrow(month),
          ),
        );
      }
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: Gap.sm + 2),
          child: _RefuelRow(refuel: refuel),
        ),
      );
    }

    rows.add(
      Padding(
        padding: const EdgeInsets.only(top: Gap.md),
        child: Text(
          'Tankly learns 37.5 km/L from full-tank fills. Add a few more full tanks and '
          'the estimate gets tighter.',
          style: TanklyType.ui(
            TanklyType.caption,
            color: p.textDim,
            height: 1.4,
          ),
        ),
      ),
    );
    return rows;
  }
}

class _FuelSummary extends StatelessWidget {
  const _FuelSummary();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final last = DemoData.lastRefuel;
    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InlineStat(
                  value: DemoData.vehicle.mileageKmpl.toStringAsFixed(1),
                  unit: 'km/L',
                  label: 'Mileage',
                ),
              ),
              Container(width: 1, height: 34, color: p.outline),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: Gap.card),
                  child: InlineStat(
                    value: DemoData.rupees(DemoData.costPerKm, decimals: 1),
                    unit: '/km',
                    label: 'Cost per km',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.lg),
          Divider(color: p.outline, height: 1),
          const SizedBox(height: Gap.md),
          Row(
            children: [
              Icon(Icons.history_rounded, size: 18, color: p.textDim),
              const SizedBox(width: Gap.sm),
              Expanded(
                child: Text(
                  'Last refuel · ${TimeLabel.dayMonth(last.at, now: DemoData.now)}, '
                  '${TimeLabel.clock(last.at)}',
                  style: TanklyType.ui(TanklyType.label, color: p.textDim),
                ),
              ),
              Text(
                '${last.odometerKm.toStringAsFixed(0)} km',
                style: TanklyType.number(
                  TanklyType.label,
                  weight: 700,
                  color: p.text,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RefuelRow extends StatelessWidget {
  const _RefuelRow({required this.refuel});

  final RefuelRecord refuel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      padding: const EdgeInsets.symmetric(
        horizontal: Gap.card,
        vertical: Gap.md + 2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${refuel.litres.toStringAsFixed(2)} L',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TanklyType.number(
                          TanklyType.title - 2,
                          weight: 700,
                          color: p.text,
                        ),
                      ),
                    ),
                    if (refuel.isFull) ...[
                      const SizedBox(width: Gap.sm),
                      _Badge(label: 'Full', color: p.accent),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '${DemoData.rupees(refuel.priceTotal.toDouble())} · '
                  '${DemoData.rupees(refuel.pricePerLitre, decimals: 2)}/L · '
                  '${refuel.odometerKm.toStringAsFixed(0)} km',
                  style: TanklyType.ui(TanklyType.caption, color: p.textDim),
                ),
              ],
            ),
          ),
          const SizedBox(width: Gap.sm),
          Text(
            TimeLabel.ago(refuel.at, DemoData.now),
            style: TanklyType.ui(TanklyType.caption, color: p.textDim),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Gap.sm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Text(label, style: TanklyType.ui(10.5, weight: 700, color: color)),
    );
  }
}
