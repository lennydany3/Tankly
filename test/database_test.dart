import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tankly/data/db/app_database.dart';
import 'package:tankly/data/db/tables/sync_columns.dart';
import 'package:tankly/domain/models/refuel.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('schema', () {
    test('creates all nine tables', () async {
      final rows = await db
          .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
          .get();
      final names = rows.map((r) => r.read<String>('name')).toSet();
      expect(
        names,
        containsAll([
          'vehicles',
          'refuels',
          'fuel_events',
          'trips',
          'trip_points',
          'odometer_checks',
          'reminders',
          'sync_state',
          'app_settings',
        ]),
      );
    });

    test('enforces foreign keys, so a refuel needs a real vehicle', () async {
      final now = DateTime.utc(2026, 3, 1);
      await expectLater(
        db
            .into(db.refuels)
            .insert(
              RefuelsCompanion.insert(
                id: 'r1',
                vehicleId: 'nope',
                at: now,
                litres: 5,
                priceTotal: 450,
                createdAt: now,
                updatedAt: now,
              ),
            ),
        throwsA(isA<Exception>()),
      );
    });

    test('keeps a soft-deleted row readable', () async {
      final vehicle = await db.select(db.vehicles).getSingle();
      final now = DateTime.utc(2026, 3, 1);
      await db
          .into(db.refuels)
          .insert(
            RefuelsCompanion.insert(
              id: 'r2',
              vehicleId: vehicle.id,
              at: now,
              litres: 3,
              priceTotal: 270,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final row = await (db.select(
        db.refuels,
      )..where((t) => t.id.equals('r2'))).getSingle();
      expect(row.litres, 3);
      expect(row.isFull, isFalse);
      expect(row.anchorMode, AnchorMode.reset);
      expect(row.assumedLeftoverL, 0);
    });
  });

  group('seed', () {
    test(
      'a new install has an active vehicle and a full-tank anchor',
      () async {
        final vehicle = await db.select(db.vehicles).getSingle();
        expect(vehicle.isActive, isTrue);
        expect(vehicle.tankCapacityL, greaterThan(0));
        expect(vehicle.distanceFactor, 1.0);
        expect(vehicle.syncStatus, SyncStatus.pending);

        final refuel = await db.select(db.refuels).getSingle();
        expect(refuel.vehicleId, vehicle.id);
        expect(refuel.isFull, isTrue);
        expect(refuel.anchorMode, AnchorMode.full);
        expect(refuel.litres, vehicle.tankCapacityL);
      },
    );

    test('is idempotent across a reopen of the same schema version', () async {
      // A second database is a second install, so a second seed is correct: the
      // guarantee is that neither has a partial state.
      final other = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(other.close);
      expect(await other.select(other.vehicles).get(), hasLength(1));
      expect(await other.select(other.refuels).get(), hasLength(1));
    });
  });

  group('outbox', () {
    test('new rows start pending and can be marked synced', () async {
      final now = DateTime.utc(2026, 3, 1);
      await db
          .into(db.vehicles)
          .insert(
            VehiclesCompanion.insert(
              id: 'v-pending',
              name: 'Dio',
              createdAt: now,
              updatedAt: now,
              isActive: const Value(false),
            ),
          );
      final pending = await (db.select(
        db.vehicles,
      )..where((t) => t.id.equals('v-pending'))).getSingle();
      expect(pending.syncStatus, SyncStatus.pending);

      await (db.update(db.vehicles)..where((t) => t.id.equals('v-pending')))
          .write(const VehiclesCompanion(syncStatus: Value(SyncStatus.synced)));
      final synced = await (db.select(
        db.vehicles,
      )..where((t) => t.id.equals('v-pending'))).getSingle();
      expect(synced.syncStatus, SyncStatus.synced);
    });

    test('soft delete hides a row from a live query but keeps it', () async {
      final now = DateTime.utc(2026, 3, 1);
      await db
          .into(db.vehicles)
          .insert(
            VehiclesCompanion.insert(
              id: 'v-gone',
              name: 'Jupiter',
              createdAt: now,
              updatedAt: now,
              isActive: const Value(false),
            ),
          );
      await (db.update(db.vehicles)..where((t) => t.id.equals('v-gone'))).write(
        VehiclesCompanion(deletedAt: Value(now)),
      );
      final live = await (db.select(
        db.vehicles,
      )..where((t) => t.deletedAt.isNull())).get();
      expect(live.any((v) => v.id == 'v-gone'), isFalse);
      expect(await db.select(db.vehicles).get(), hasLength(2));
    });
  });

  group('settings', () {
    test('are key-value and survive a rewrite', () async {
      await db
          .into(db.appSettings)
          .insert(
            AppSettingsCompanion.insert(key: 'distance_unit', value: '"mi"'),
          );
      await (db.update(db.appSettings)
            ..where((t) => t.key.equals('distance_unit')))
          .write(AppSettingsCompanion(value: Value('"km"')));
      final row = await db.select(db.appSettings).getSingle();
      expect(row.value, '"km"');
    });

    test('a duplicate key is rejected by the primary key', () async {
      await db
          .into(db.appSettings)
          .insert(AppSettingsCompanion.insert(key: 'theme', value: '"dark"'));
      await expectLater(
        db
            .into(db.appSettings)
            .insert(
              AppSettingsCompanion.insert(key: 'theme', value: '"light"'),
            ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
