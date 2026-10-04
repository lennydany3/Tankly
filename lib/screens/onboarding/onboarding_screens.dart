import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../design/controls.dart';
import '../../design/inputs.dart';
import '../../design/surfaces.dart';
import '../../design/tankly_brand.dart';
import '../../theme/tankly_palette.dart';
import '../../theme/tankly_tokens.dart';
import '../../theme/tankly_type.dart';

/// Cold start. Opens the database, checks the session, then routes onward.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Gap.xl),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const TanklyAppIcon(size: 104),
              const SizedBox(height: Gap.xl),
              const TanklyWordmark(size: 40),
              const SizedBox(height: Gap.sm),
              Text(
                'Know your tank.',
                style: TanklyType.ui(
                  TanklyType.title - 2,
                  weight: 500,
                  color: p.textDim,
                ),
              ),
              const Spacer(flex: 3),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Column(
                  children: [
                    Container(
                      height: 3,
                      width: 148,
                      decoration: BoxDecoration(
                        color: p.surfaceHigh,
                        borderRadius: BorderRadius.circular(Radii.chip),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: _controller.value.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: p.accent,
                            borderRadius: BorderRadius.circular(Radii.chip),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Gap.md),
                    Text(
                      'Opening your log…',
                      style: TanklyType.ui(
                        TanklyType.caption,
                        color: p.textDim,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Login is optional. The app is fully usable signed out.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Gap.screen,
            Gap.xl,
            Gap.screen,
            Gap.xl,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 2),
                      const TanklyWordmark(size: 30),
                      const SizedBox(height: Gap.xl),
                      Text(
                        'Always know how much\npetrol you have left.',
                        style: TanklyType.ui(
                          TanklyType.headline + 2,
                          weight: 700,
                          color: p.text,
                          height: 1.18,
                        ),
                      ),
                      const SizedBox(height: Gap.md),
                      Text(
                        'Tankly works out what is in the tank from your rides and every refuel you log.',
                        style: TanklyType.ui(
                          TanklyType.body,
                          color: p.textDim,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(flex: 3),
                      TankCard(
                        padding: const EdgeInsets.all(Gap.md + 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cloud_queue_rounded,
                              size: 20,
                              color: p.accent,
                            ),
                            const SizedBox(width: Gap.md),
                            Expanded(
                              child: Text(
                                'Signing in backs up your rides and fuel logs. Skip it and everything '
                                'still works — data just stays on this phone.',
                                style: TanklyType.ui(
                                  TanklyType.caption + 1,
                                  color: p.textDim,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Gap.lg),
                      TanklyButton(
                        label: 'Continue with Google',
                        icon: Icons.g_mobiledata_rounded,
                        onPressed: () {},
                      ),
                      const SizedBox(height: Gap.sm),
                      TanklyButton(
                        label: 'Skip for now',
                        variant: TanklyButtonVariant.secondary,
                        onPressed: () {},
                      ),
                      const SizedBox(height: Gap.md),
                      Center(
                        child: Text(
                          'You can sign in later from Settings.',
                          textAlign: TextAlign.center,
                          style: TanklyType.ui(
                            TanklyType.caption,
                            color: p.textDim,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Explain before each system prompt. Never a bare permission dialog.
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final Set<int> _granted = {0, 1};

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: const Text('Permissions'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Gap.screen),
            child: Center(
              child: Text(
                '${_granted.length} of 3',
                style: TanklyType.ui(
                  TanklyType.label,
                  weight: 600,
                  color: p.textDim,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Gap.screen,
            Gap.sm,
            Gap.screen,
            Gap.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Three things Tankly\nneeds to keep working.',
                style: TanklyType.ui(
                  TanklyType.headline,
                  weight: 700,
                  color: p.text,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: Gap.xl),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    _PermissionCard(
                      icon: Icons.my_location_rounded,
                      title: 'Location',
                      message: 'Measures distance and speed while you ride.',
                      detail: 'Requested only while you are recording a trip.',
                    ),
                    SizedBox(height: Gap.md - 4),
                    _PermissionCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      message: 'Shows the ride timer and low-fuel warnings.',
                      detail: 'Nothing else is ever notified.',
                    ),
                    SizedBox(height: Gap.md - 4),
                    _PermissionCard(
                      icon: Icons.battery_saver_outlined,
                      title: 'Battery optimisation',
                      message: 'Stops Android killing tracking mid-ride.',
                      detail:
                          'On Xiaomi, Oppo and Vivo this is a manual setting.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Gap.md),
              TanklyButton(
                label: 'Allow and continue',
                icon: Icons.check_rounded,
                onPressed: () => setState(() => _granted.addAll([0, 1, 2])),
              ),
              const SizedBox(height: Gap.sm),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Do this later',
                    style: TanklyType.ui(
                      TanklyType.label,
                      weight: 600,
                      color: p.textDim,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionCard extends StatefulWidget {
  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String message;
  final String detail;

  @override
  State<_PermissionCard> createState() => _PermissionCardState();
}

class _PermissionCardState extends State<_PermissionCard> {
  bool _granted = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      onTap: () => setState(() => _granted = !_granted),
      borderColor: _granted ? p.good.withValues(alpha: 0.5) : p.outline,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (p.accent).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Radii.thumb),
            ),
            child: Icon(widget.icon, color: p.accent, size: 22),
          ),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TanklyType.ui(
                    TanklyType.body,
                    weight: 700,
                    color: p.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.message,
                  style: TanklyType.ui(
                    TanklyType.label,
                    color: p.textDim,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: Gap.sm),
                Text(
                  widget.detail,
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Icon(
              _granted ? Icons.check_circle_rounded : Icons.circle_outlined,
              size: 24,
              color: _granted ? p.good : p.outline,
            ),
          ),
        ],
      ),
    );
  }
}

/// Vehicle setup, reused for editing later.
class VehicleSetupScreen extends StatefulWidget {
  const VehicleSetupScreen({super.key, this.editing = false});

  final bool editing;

  @override
  State<VehicleSetupScreen> createState() => _VehicleSetupScreenState();
}

class _VehicleSetupScreenState extends State<VehicleSetupScreen> {
  bool _isHonda = true;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text(widget.editing ? 'Edit vehicle' : 'Your scooter'),
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
            Text(
              _isHonda
                  ? 'These numbers drive the whole estimate. Get the tank capacity right.'
                  : 'Tankly will learn your real mileage from the first few full tanks.',
              style: TanklyType.ui(
                TanklyType.body,
                color: p.textDim,
                height: 1.45,
              ),
            ),
            const SizedBox(height: Gap.lg),
            LabelledField(
              label: 'Vehicle name',
              value: 'Activa 6G',
              icon: Icons.two_wheeler_rounded,
            ),
            const SizedBox(height: Gap.sm),
            Row(
              children: [
                Expanded(
                  child: NumericField(
                    label: 'Tank capacity',
                    value: DemoData.tankCapacityL.toStringAsFixed(1),
                    unit: 'L',
                    icon: Icons.local_gas_station_outlined,
                  ),
                ),
                const SizedBox(width: Gap.md),
                Expanded(
                  child: NumericField(
                    label: 'Reserve',
                    value: DemoData.reserveL.toStringAsFixed(2),
                    unit: 'L',
                    helper: 'Light comes on here',
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gap.sm),
            NumericField(
              label: 'Mileage',
              value: '37.5',
              unit: 'km/L',
              icon: Icons.eco_outlined,
              helper:
                  'Tankly refines this from your full-tank refuels. Most scooters '
                  'land between 35 and 40.',
            ),
            NumericField(
              label: 'Current odometer',
              value: DemoData.odometerKm.toStringAsFixed(0),
              unit: 'km',
              icon: Icons.speed_rounded,
              helper: 'Used for distance-by-kilometre reminders.',
            ),
            NumericField(
              label: 'Petrol in the tank right now',
              value: DemoData.anchor.levelL.toStringAsFixed(2),
              unit: 'L',
              icon: Icons.water_drop_outlined,
              helper:
                  'Your best guess is fine. "Light came on" fixes it later.',
            ),
            const SizedBox(height: Gap.sm),
            TankCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.card,
                vertical: Gap.xs,
              ),
              child: SwitchRow(
                title: 'Show speed on my scooter',
                subtitle: _isHonda
                    ? 'Activa 6G reads 12 % high in the dashboard.'
                    : 'Apply a fixed offset to the speedometer.',
                value: _isHonda,
                onChanged: (value) => setState(() => _isHonda = value),
              ),
            ),
            const SizedBox(height: Gap.xl),
            TanklyButton(
              label: widget.editing ? 'Save changes' : 'Save and start',
              icon: Icons.check_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
