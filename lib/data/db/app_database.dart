import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tankly/core/constants.dart' show Fuel;
import 'package:tankly/domain/models/refuel.dart';
import 'package:tankly/domain/models/trip.dart';
import 'package:uuid/uuid.dart';

import 'tables/app_settings_table.dart';
import 'tables/fuel_events_table.dart';
import 'tables/odometer_checks_table.dart';
import 'tables/refuels_table.dart';
import 'tables/reminders_table.dart';
import 'tables/sync_columns.dart';
import 'tables/sync_state_table.dart';
import 'tables/trip_points_table.dart';
import 'tables/trips_table.dart';
import 'tables/vehicles_table.dart';


part 'app_database.g.dart';




/// The local database. Source of truth for everything the rider owns.
///
/// Offline-first in the strict sense: the UI reads from here and never blocks on
/// the network. Supabase is a backup and a second-device replica, so a failed or
/// absent server degrades sync and nothing else.
///
/// Nine tables: six synced, plus three local-only (`trip_points`, `sync_state`,
/// `app_settings`).
@DriftDatabase(
  tables: [
    Vehicles,
    Refuels,
    FuelEvents,
    Trips,
    TripPoints,
    OdometerChecks,
    Reminders,
    SyncStates,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'tankly'));

  /// Test constructor: an in-memory database with no platform channel involved.
  AppDatabase.forTesting(super.executor);

  static const _uuid = Uuid();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
    // No destructive fallback. A schema change gets a new step below; dropping
    // the rider's history to make an upgrade easy is never the easy option.
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// First launch has to show something, and the fuel maths needs an anchor, so
  /// a brand new install gets the default vehicle plus a full-tank anchor rather
  /// than an empty database the UI has to special-case forever.
  Future<void> _seed() async {
    final now = DateTime.now().toUtc();
    final vehicleId = _uuid.v4();
    await into(vehicles).insert(
      VehiclesCompanion.insert(
        id: vehicleId,
        name: 'Activa 6G',
        createdAt: now,
        updatedAt: now,
        odometerStartKm: const Value(0),
      ),
    );
    await into(refuels).insert(
      RefuelsCompanion.insert(
        id: _uuid.v4(),
        vehicleId: vehicleId,
        at: now,
        litres: Fuel.defaultTankCapacityL,
        priceTotal: 0,
        createdAt: now,
        updatedAt: now,
        isFull: const Value(true),
        anchorMode: const Value(AnchorMode.full),
      ),
    );
  }
}
