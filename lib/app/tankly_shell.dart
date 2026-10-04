import 'package:flutter/material.dart';

import 'package:tankly/data/demo_data.dart';
import 'package:tankly/design/controls.dart';
import 'package:tankly/design/tankly_nav_bar.dart';
import 'package:tankly/screens/home/home_screen.dart';
import 'package:tankly/screens/live/live_trip_screen.dart';
import 'package:tankly/screens/settings/account_screen.dart';
import 'package:tankly/screens/settings/settings_screen.dart';
import 'package:tankly/screens/tabs/fuel_screen.dart';
import 'package:tankly/screens/tabs/reminders_screen.dart';
import 'package:tankly/screens/tabs/stats_screen.dart';
import 'package:tankly/screens/tabs/trips_screen.dart';
import 'package:tankly/screens/trip_detail/trip_detail_screen.dart';
import 'package:tankly/theme/tankly_palette.dart';

/// Bottom-nav shell. Four destinations plus a centred primary action.
class TanklyShell extends StatefulWidget {
  const TanklyShell({super.key, this.startIndex = 0});

  final int startIndex;

  @override
  State<TanklyShell> createState() => _TanklyShellState();
}

class _TanklyShellState extends State<TanklyShell> {
  late int _index = widget.startIndex;
  late final _pages = <Widget>[
    HomeScreen(
      onStartRide: _openLiveTrip,
      onOpenSettings: _openSettings,
      onOpenTrip: _openLastTrip,
      snapshot: DemoData.fuelNow,
    ),
    const TripsScreen(),
    const FuelScreen(),
    const StatsScreen(),
    RemindersScreen(onOpenAccount: _openAccount, onOpenSettings: _openSettings),
  ];

  void _openLiveTrip() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LiveTripScreen(snapshot: DemoData.fuelLive),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }

  void _openAccount() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AccountScreen()));
  }

  void _openLastTrip() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TripDetailScreen(trip: DemoData.eveningRide),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.bg,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: TanklyNavBar(
        current: _index,
        onTap: (value) => setState(() => _index = value),
      ),
    );
  }
}

/// Shared "Start ride" action so Home and the empty Trips state stay identical.
class StartRideButton extends StatelessWidget {
  const StartRideButton({
    super.key,
    required this.onPressed,
    this.riding = false,
  });

  final VoidCallback onPressed;
  final bool riding;

  @override
  Widget build(BuildContext context) {
    return TanklyButton(
      label: riding ? 'Finish ride' : 'Start ride',
      icon: riding ? Icons.stop_rounded : Icons.play_arrow_rounded,
      riding: true,
      onPressed: onPressed,
      expand: true,
    );
  }
}
