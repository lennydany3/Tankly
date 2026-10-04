import 'package:flutter/material.dart';

import '../theme/tankly_palette.dart';
import '../theme/tankly_tokens.dart';
import '../theme/tankly_type.dart';

/// The five tabs. Active tab gets an accent icon, label and a soft pill.
class TanklyNavBar extends StatelessWidget {
  const TanklyNavBar({super.key, required this.current, required this.onTap});

  final int current;
  final ValueChanged<int> onTap;

  static const items = <(IconData, IconData, String)>[
    (Icons.home_outlined, Icons.home_rounded, 'Home'),
    (Icons.route_outlined, Icons.route_rounded, 'Trips'),
    (Icons.local_gas_station_outlined, Icons.local_gas_station_rounded, 'Fuel'),
    (Icons.bar_chart_outlined, Icons.bar_chart_rounded, 'Stats'),
    (
      Icons.notifications_none_rounded,
      Icons.notifications_rounded,
      'Reminders',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        border: const Border(top: BorderSide(color: TanklyBrand.outline)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: Sizes.navBar,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavItem(
                    icon: items[i].$1,
                    activeIcon: items[i].$2,
                    label: items[i].$3,
                    selected: i == current,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = selected ? p.accent : p.textDim;
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Motion.fast,
              curve: Motion.easeOut,
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.md + 2,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: selected ? p.accentSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Radii.chip),
              ),
              child: Icon(selected ? activeIcon : icon, size: 22, color: color),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TanklyType.ui(
                10.5,
                weight: selected ? 700 : 500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
