import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/app/gallery.dart';
import 'package:tankly/app/tankly_shell.dart';
import 'package:tankly/data/demo_data.dart';
import 'package:tankly/main.dart';
import 'package:tankly/screens/home/home_screen.dart';
import 'package:tankly/screens/live/live_trip_screen.dart';
import 'package:tankly/screens/tabs/fuel_screen.dart';
import 'package:tankly/screens/tabs/reminders_screen.dart';
import 'package:tankly/screens/tabs/stats_screen.dart';
import 'package:tankly/screens/tabs/trips_screen.dart';
import 'package:tankly/theme/tankly_theme.dart';

/// The design brief is drawn at 390 x 844. Every screen below is checked at
/// that size so a layout that only works on a tablet gets caught here.
const phone = Size(390, 844);

Widget host(Widget child, {ThemeData? theme}) =>
    MaterialApp(theme: theme ?? TanklyTheme.dark, home: child);

void main() {
  group('app shell', () {
    testWidgets('opens on Home with the gauge and the riding control', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const TanklyApp());

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Start ride'), findsOneWidget);
      expect(find.text('tankly'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('every bottom-nav tab renders without overflow', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const TanklyShell()));
      await tester.pumpAndSettle();

      for (final label in ['Trips', 'Fuel', 'Stats', 'Reminders']) {
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '$label threw while building',
        );
      }
    });
  });

  group('Home', () {
    testWidgets('low fuel shows the honest estimate and status word', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        host(HomeScreen(onStartRide: () {}, snapshot: DemoData.fuelNow)),
      );

      expect(find.textContaining('0.40', findRichText: true), findsOneWidget);
      expect(find.text('Low'), findsWidgets);
      expect(find.text('Start ride'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading shows a skeleton instead of a zero gauge', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(HomeScreen(onStartRide: () {})));

      expect(find.text('0.00'), findsNothing);
      expect(find.text('Start ride'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders in the light theme too', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        host(
          HomeScreen(onStartRide: () {}, snapshot: DemoData.fuelNow),
          theme: TanklyTheme.light,
        ),
      );

      expect(find.textContaining('0.40', findRichText: true), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('Live Trip', () {
    testWidgets('tracking shows the live readouts and the stop control', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        host(LiveTripScreen(snapshot: DemoData.fuelLive)),
      );
      await tester.pump();

      expect(find.text('Stop ride'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('GPS searching is stated in words, not only colour', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        host(const LiveTripScreen(snapshot: null, gps: LiveGps.searching)),
      );

      expect(find.text('Looking for GPS'), findsOneWidget);
      expect(find.text('Stop ride'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('survives 130 % text scaling', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(
        host(LiveTripScreen(snapshot: DemoData.fuelLive)),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('tabs', () {
    testWidgets('Trips lists the recorded rides', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const TripsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Evening ride'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Trips empty state offers one way out', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const TripsScreen(empty: true)));
      await tester.pumpAndSettle();

      expect(find.text('No rides yet'), findsOneWidget);
      expect(find.text('Start ride'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Fuel explains the last refuel', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const FuelScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Last refuel'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Stats frames totals as a rolling 30 days', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const StatsScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining('30 days'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Reminders empty state renders', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const RemindersScreen(empty: true)));
      await tester.pumpAndSettle();

      expect(find.text('Nothing to remember yet'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('gallery', () {
    testWidgets('index lists every screen group', (tester) async {
      await tester.binding.setSurfaceSize(phone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(host(const DesignGallery()));
      await tester.pumpAndSettle();

      expect(find.text('5 · Home · low fuel'), findsOneWidget);
      expect(find.text('6 · Live trip · tracking'), findsOneWidget);
      expect(find.text('Style sheet'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('every gallery entry renders without throwing', (tester) async {
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final entry in galleryEntries()) {
        await tester.binding.setSurfaceSize(phone);
        await tester.pumpWidget(host(GalleryScreenPage(entry: entry)));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          tester.takeException(),
          isNull,
          reason: '${entry.name} threw while building',
        );

        // Tear the screen down between entries so no ticker or route from the
        // previous screen is still mounted when the next one builds.
        await tester.pumpWidget(host(const SizedBox.shrink()));
        await tester.pump(const Duration(milliseconds: 100));
        tester.takeException();
      }
    });
  });
}
