# Scooty Fuel & Ride Tracker: System Design (v1)

> A Flutter app that replaces a broken fuel gauge and records rides Strava-style.
> A phone cannot read the tank, so the app **estimates** fuel from GPS distance and the petrol you log at each refuel.
> Offline-first: the phone database is the source of truth, Supabase is backup and sync.

Status: kickstart document. Platform assumed: **Android first** (iOS later; see Open Questions).

---

## 1. Goals and non-goals

### Goals (v1)
1. Show litres left and range, always visible (home screen and tracking notification).
2. Record rides reliably in the background: distance, duration, speed, route.
3. Strava-style timeline of rides with route preview and stats.
4. Refuel log that drives the fuel estimate and learns real mileage.
5. Stats (mileage trend, cost per km, monthly spend) and reminders (service by km, document expiry).
6. **Never lose data.** Local-first writes, Google login, Supabase sync, manual export.

### Non-goals (v1)
- Real fuel sensor (OBD/ESP32), crash detection, live location sharing
- Auto trip start/stop, home screen widget, idle-fuel correction, city/highway mileage split (v2)
- Multi-user features, social features
- iOS-specific polish

---

## 2. Core concept: how fuel estimation works

Fuel is **derived, never stored as an editable number**. The app keeps a history of events and computes the current level from it. Correcting any event automatically fixes everything after it.

```
petrol left = latest anchor level
            − fuel used by completed trips since the anchor
            − fuel used by the trip in progress
```

**Anchor** = any event that tells the app how much fuel is in the tank at a moment in time:

| Anchor event | Level set to |
|---|---|
| Refuel, mode `reset` (default) | `litres_added + assumed_leftover` (leftover defaults to 0, so the estimate is safe and slightly pessimistic) |
| Refuel, marked `full` | `tank_capacity` |
| Reserve light came on | `reserve_l` (about 0.8 L, configurable) |
| Ran dry | `0` |
| Still running after estimate hit 0 | `still_running_bonus_l` (default 0.2 L) |

The most recent anchor wins. Trips that ended after the anchor time subtract fuel.

### Formulas

```
fuel_used_l     = (raw_distance_km × distance_factor) / mileage_kmpl
litres_left     = max(0, anchor_level − Σ fuel_used_l)
safe_mileage    = mileage_kmpl × safety_factor          // default 0.90
range_km        = litres_left × safe_mileage            // shown to the user
```

`distance_factor` corrects GPS drift (see odometer sync). `mileage_kmpl` is the learned value, falling back to the vehicle default (37.5).

### Worked example (must be a unit test)

| Step | Calculation | Result |
|---|---|---|
| Refuel ₹100 | | 0.93 L |
| Ride 20 km | 20 / 37.5 = 0.533 L used | **0.397 L left** |
| Range | 0.397 × 37.5 × 0.90 | **about 13.4 km** (unsafe figure would be 14.9 km) |

### Mileage learning
At each new refuel in `reset` mode, the app knows the km ridden since the previous refuel and the litres that refuel put in:

```
observed = km_since_prev_refuel / litres_burned_on_that_tank
mileage  = 0.7 × mileage + 0.3 × observed        // exponential moving average
```

Guards: ignore if `km < 15`, clamp result to `[mileage_min, mileage_max]` (default 25 to 55), and ignore outliers more than 30% from the current value. In `reset` mode the leftover is unknown, so learning is approximate; full-tank fills give exact values, so encourage them occasionally.

### Odometer sync (distance correction)
User enters the real odometer reading now and then:

```
factor_sample = (odometer_now − odometer_at_last_check) / gps_km_since_last_check
distance_factor = 0.7 × distance_factor + 0.3 × factor_sample   // clamp 0.90 to 1.10
```

### Known error sources (documented, accepted for v1)
- Idle time in traffic burns fuel with no distance (fixed in v2 with an idle burn rate)
- Unknown leftover at refuel (handled by correction buttons)
- Missing trips (handled by odometer sync)
- Expected accuracy once calibrated: about 0.3 to 0.5 L

---

## 3. Tech stack

| Concern | Choice | Notes |
|---|---|---|
| UI | Flutter (Dart 3) | Material 3, dark-first theme for glanceable riding UI |
| State | `flutter_riverpod` | AsyncNotifier and StreamProvider over drift streams |
| Navigation | `go_router` | `ShellRoute` for the 5 tabs |
| Local DB | `drift` + `drift_flutter` (SQLite) | Relational, reactive queries, migrations |
| GPS | `geolocator` | Position stream with speed and accuracy |
| Background | `flutter_foreground_task` | Android foreground service (type `location`), updatable notification |
| Maps | `flutter_map` + OpenStreetMap tiles | No API key; respect tile usage policy |
| Charts | `fl_chart` | Stats and speed/elevation graphs |
| Notifications | `flutter_local_notifications` | Reminders, low-fuel alerts |
| Permissions | `permission_handler` | Location, notifications, battery optimization |
| Auth | `supabase_flutter` + `google_sign_in` | `signInWithIdToken` |
| Background sync | `workmanager` | Periodic sync when online |
| Misc | `uuid`, `connectivity_plus`, `archive` (gzip), `share_plus`, `file_picker` | |
| Cloud | Supabase (Postgres, Auth, RLS) | Backup and sync only |

Why SQLite (drift) over Hive: thousands of GPS points per trip and queries like "total km since the last refuel" are relational; Hive would force manual in-memory loops.

---

## 4. Architecture

```
┌──────────────────────────────────────────────────────────┐
│ UI (features/*)       screens, widgets                   │
├──────────────────────────────────────────────────────────┤
│ State (Riverpod)      providers, notifiers               │
├──────────────────────────────────────────────────────────┤
│ Domain (pure Dart)    FuelEngine, MileageLearner,        │
│                       GpsFilter, DistanceCalculator,     │
│                       TripStateMachine, ReminderRules    │
├──────────────────────────────────────────────────────────┤
│ Services              TrackingService (foreground task), │
│                       NotificationService, SyncEngine    │
├──────────────────────────────────────────────────────────┤
│ Repositories          Vehicle, Refuel, Trip, Reminder... │
├────────────────────────────┬─────────────────────────────┤
│ Local: drift (SQLite)      │ Remote: Supabase            │
│ source of truth            │ backup + sync               │
└────────────────────────────┴─────────────────────────────┘
```

### Design rules
1. **The domain layer is pure Dart.** No Flutter, no database, no network. `FuelEngine` and `GpsFilter` are unit-testable on a laptop.
2. **The database is the event bus.** The tracking service writes to drift; the UI watches drift streams. The UI never needs a direct channel to the service for data.
3. **Local first.** Recording and logging never wait for the network.
4. **Derived, not stored.** Fuel level and range are computed on read.
5. **Soft deletes everywhere** so deletions can sync.

### Background isolate caveat (verify in Milestone 3 spike)
`flutter_foreground_task` runs its handler in a separate isolate. Both the handler (writing GPS points) and the UI (reading them) need the same SQLite file. Use drift's shared/isolate database setup (`DriftIsolate` or `drift_flutter` with `shareAcrossIsolates: true`) so writes from the service trigger stream updates in the UI. Prove this with a throwaway spike before building features on it.

---

## 5. Project structure

```
lib/
├─ main.dart
├─ app/
│  ├─ app.dart                 # MaterialApp.router, theme
│  ├─ router.dart              # go_router config
│  └─ providers.dart           # DI roots (db, supabase, repos)
├─ core/
│  ├─ geo.dart                 # haversine, bearing helpers
│  ├─ units.dart               # m/s to km/h, formatting
│  ├─ constants.dart           # thresholds, defaults
│  └─ result.dart / logger.dart
├─ domain/
│  ├─ models/                  # Vehicle, Refuel, Trip, FuelEvent, Reminder
│  ├─ fuel/
│  │  ├─ fuel_engine.dart
│  │  └─ mileage_learner.dart
│  ├─ tracking/
│  │  ├─ gps_filter.dart
│  │  ├─ distance_calculator.dart
│  │  └─ trip_state_machine.dart
│  └─ reminders/reminder_rules.dart
├─ data/
│  ├─ db/
│  │  ├─ app_database.dart
│  │  ├─ tables/               # one file per table
│  │  └─ daos/
│  ├─ repositories/
│  ├─ remote/                  # supabase client, row mappers
│  └─ sync/
│     ├─ sync_engine.dart
│     ├─ push.dart
│     └─ pull.dart
├─ services/
│  ├─ tracking_task_handler.dart   # runs in the foreground-service isolate
│  ├─ tracking_controller.dart     # start/stop from UI
│  ├─ notification_service.dart
│  └─ background_sync.dart         # workmanager entry
└─ features/
   ├─ splash/  auth/  permissions/  vehicle_setup/
   ├─ home/  live_trip/  trips/  trip_detail/
   ├─ fuel/  refuel_form/  stats/
   ├─ reminders/  reminder_form/
   └─ settings/  account/
test/
├─ domain/ (fuel_engine_test, gps_filter_test, mileage_learner_test, ...)
├─ data/ (repositories, sync with fake remote)
└─ fixtures/ (recorded GPS tracks as CSV/JSON)
```

---

## 6. Local data model (drift / SQLite)

Conventions on **every** synced table:

| Column | Type | Purpose |
|---|---|---|
| `id` | TEXT (UUID v4) | Client-generated, collision-free, safe to retry |
| `user_id` | TEXT nullable | Null until first Google login, then stamped |
| `created_at` | DATETIME | UTC |
| `updated_at` | DATETIME | UTC, set on every local change |
| `deleted_at` | DATETIME nullable | Soft delete |
| `sync_status` | INT (0 = pending, 1 = synced) | **Local only**, never sent to server |

### Tables

**vehicles**
`name, tank_capacity_l, reserve_l, default_mileage_kmpl, learned_mileage_kmpl?, distance_factor (default 1.0), safety_factor (default 0.9), low_fuel_threshold_l (default 0.25), odometer_start_km, is_active`

**refuels** (anchor)
`vehicle_id, at, litres, price_total, price_per_l?, odometer_km?, is_full, anchor_mode ('reset'|'full'), assumed_leftover_l (default 0), notes`

**fuel_events** (anchor)
`vehicle_id, at, kind ('reserve_light'|'ran_dry'|'still_running'), level_l`

**trips**
`vehicle_id, status ('recording'|'completed'|'interrupted'), started_at, ended_at?, raw_distance_km, duration_s, moving_s, idle_s, avg_speed_kmh, max_speed_kmh, elevation_gain_m?, start_lat, start_lng, end_lat?, end_lng?, title?, notes?, route_gz? (base64 gzip of points JSON, built when the trip completes, used for sync)`

**trip_points** (local only, not synced row by row)
`id (autoincrement), trip_id, seq, ts, lat, lng, altitude_m?, speed_mps, accuracy_m, is_moving`
Index: `(trip_id, seq)`.

**odometer_checks**
`vehicle_id, at, odometer_km, gps_km_since_last, factor_sample`

**reminders**
`vehicle_id, kind ('service'|'document'), title, due_km?, due_date?, interval_km?, interval_days?, last_done_km?, last_done_date?, notify_before_km?, notify_before_days?, notes`

**sync_state** (single row, local only)
`last_pulled_at, last_push_at, last_error?`

**app_settings** (key-value, local only)
Units, theme, notification preferences, speedometer offset, onboarding completed flag.

### Key queries
- Latest anchor: `max(at)` across `refuels` and `fuel_events` for the active vehicle, `deleted_at IS NULL`.
- Km since anchor: `SUM(raw_distance_km)` of `completed` trips with `ended_at > anchor.at`, plus the active trip's live distance.
- Odometer estimate: `odometer_start_km + SUM(all completed raw_distance_km × factor)`, rebased on each odometer check.

---

## 7. GPS tracking pipeline

### 7.1 Trip state machine

```
idle ──start──▶ recording ──stop──▶ completed
                  │  ▲
               (app killed)
                  ▼  │
              interrupted ──resume──▶ recording
                         └─finish──▶ completed
```

- On app launch, query for any trip with status `recording`. If found, mark it `interrupted` and show the **Resume or Finish** dialog.
- Optional auto-stop prompt after 5 minutes stationary (v1 can show a notification; full auto-stop is v2).

### 7.2 Location settings
- `LocationAccuracy.best`, `distanceFilter: 0`, interval 1 s
- Android foreground notification: title "Ride in progress", body updated every few seconds: `0.40 L · ~13 km · 32 km/h`

### 7.3 Filtering (all thresholds in `constants.dart`, tunable)

| Step | Rule |
|---|---|
| Accuracy | Drop if `accuracy > 25 m` |
| Speed accuracy | Drop speed if `speedAccuracy > 2 m/s` (when available) |
| Impossible jump | Drop if implied speed from the last good point `> 120 km/h` |
| Stationary | If `speed < 2 km/h`, count as idle: no distance added, no point stored |
| Distance gate | Store a point when moved `≥ 5 m` or `≥ 3 s` since the last stored point |
| Display speed | `shown = 0.4 × latest + 0.6 × previous` (EMA); show 0 below 2 km/h |
| Signal loss | Hold last value up to 2 s, then show "No GPS"; mark a gap after 10 s |

### 7.4 Distance
- Per accepted moving segment: `haversine(prev, current)`.
- Cross-check against `speed × dt`; if they disagree wildly, trust the Doppler speed integral for that segment.
- `raw_distance_km` is stored uncorrected. `distance_factor` is applied at read time.

### 7.5 Persistence strategy
- Buffer points in memory and flush to SQLite every 5 seconds or 20 points, in a single batch transaction.
- Update the `trips` row (distance, duration, max speed) at each flush, so a crash loses at most a few seconds.
- On Stop: flush, compute final stats, build `route_gz`, set `status = completed`, `sync_status = pending`, trigger sync.

### 7.6 Elevation
GPS altitude is noisy. Smooth with a moving average; if the device has a barometer, prefer it. Treat elevation as informational only.

---

## 8. Sync engine (offline-first)

### 8.1 Push (outbox pattern)
```
for each table in dependency order (vehicles, refuels, fuel_events,
                                    trips, odometer_checks, reminders):
    rows = SELECT * WHERE sync_status = 0 AND user_id IS NOT NULL
    upsert(rows, onConflict: id) to Supabase     // idempotent
    on success: mark exactly those rows synced (only if updated_at unchanged)
    on failure: leave pending, exponential backoff
```
- A row is marked `synced` **only after the server confirms**.
- If a row changed locally during the push (its `updated_at` moved), it stays `pending`.

### 8.2 Pull
```
since = sync_state.last_pulled_at
rows  = SELECT * WHERE updated_at > since ORDER BY updated_at LIMIT 500  (paginate)
for each row:
    local = find by id
    if local is null or server.updated_at > local.updated_at: write it (sync_status = 1)
    else: keep local (it will push)
advance last_pulled_at to the max updated_at seen
```
Soft-deleted rows arrive like any other row (`deleted_at` set) and hide locally.

### 8.3 Conflicts
Last write wins by `updated_at`. The server sets `updated_at` with a trigger on write (avoids phone clock skew). Good enough for a single user on one or two devices.

### 8.4 Triggers
App start, after trip completion, after refuel/reminder/vehicle edits (debounced 5 s), connectivity regained, periodic `workmanager` task (about every 6 h), and manual "Sync now".

### 8.5 Route data
Trips sync as **one row** with `route_gz`. Individual `trip_points` stay on the phone. On a new device, trips restore with route, stats and map; the raw points can be rebuilt from `route_gz` if needed.

### 8.6 First login and restore
- **First login with local data:** stamp all local rows with `user_id`, mark `pending`, push.
- **New phone:** sign in, pull everything (`since = epoch`), rebuild the local DB. Fuel level recalculates from refuels and trips.

---

## 9. Authentication

1. Create a Google Cloud OAuth consent screen and two clients: **Android** (package name + SHA-1 for debug and release keystores) and **Web** (its client ID and secret go into Supabase's Google provider).
2. In Flutter: `GoogleSignIn(serverClientId: <web client id>)` returns an ID token.
3. `supabase.auth.signInWithIdToken(provider: google, idToken: ..., accessToken: ...)`.
4. Login is **optional**: the app works fully offline and signed out. Signing in enables backup and sync.
5. Sign out stops sync but keeps local data. "Delete my cloud data" is available in Account.

---

## 10. Supabase schema and security

```sql
-- Shared trigger: server-side updated_at (avoids client clock skew)
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

create table public.vehicles (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  tank_capacity_l numeric(5,2) not null,
  reserve_l numeric(4,2) not null default 0.8,
  default_mileage_kmpl numeric(5,2) not null default 37.5,
  learned_mileage_kmpl numeric(5,2),
  distance_factor numeric(5,4) not null default 1.0,
  safety_factor numeric(3,2) not null default 0.90,
  low_fuel_threshold_l numeric(4,2) not null default 0.25,
  odometer_start_km numeric(9,1),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.refuels (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  at timestamptz not null,
  litres numeric(6,3) not null,
  price_total numeric(8,2),
  price_per_l numeric(6,2),
  odometer_km numeric(9,1),
  is_full boolean not null default false,
  anchor_mode text not null default 'reset',
  assumed_leftover_l numeric(4,2) not null default 0,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.fuel_events (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  at timestamptz not null,
  kind text not null check (kind in ('reserve_light','ran_dry','still_running')),
  level_l numeric(4,2) not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.trips (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  status text not null check (status in ('recording','completed','interrupted')),
  started_at timestamptz not null,
  ended_at timestamptz,
  raw_distance_km numeric(8,3) not null default 0,
  duration_s int not null default 0,
  moving_s int not null default 0,
  idle_s int not null default 0,
  avg_speed_kmh numeric(5,1),
  max_speed_kmh numeric(5,1),
  elevation_gain_m numeric(7,1),
  start_lat double precision, start_lng double precision,
  end_lat double precision,   end_lng double precision,
  title text, notes text,
  route_gz text,                      -- base64(gzip(json points))
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.odometer_checks (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  at timestamptz not null,
  odometer_km numeric(9,1) not null,
  gps_km_since_last numeric(8,3),
  factor_sample numeric(6,4),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.reminders (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  kind text not null check (kind in ('service','document')),
  title text not null,
  due_km numeric(9,1), due_date date,
  interval_km numeric(8,1), interval_days int,
  last_done_km numeric(9,1), last_done_date date,
  notify_before_km numeric(7,1), notify_before_days int,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

-- RLS, sync index and updated_at trigger on every table
do $$
declare t text;
begin
  foreach t in array array['vehicles','refuels','fuel_events','trips','odometer_checks','reminders']
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format('create policy "select own" on public.%I for select using (user_id = auth.uid())', t);
    execute format('create policy "insert own" on public.%I for insert with check (user_id = auth.uid())', t);
    execute format('create policy "update own" on public.%I for update using (user_id = auth.uid()) with check (user_id = auth.uid())', t);
    execute format('create policy "delete own" on public.%I for delete using (user_id = auth.uid())', t);
    execute format('create index on public.%I (user_id, updated_at)', t);
    execute format('create trigger set_updated_at before insert or update on public.%I for each row execute function public.set_updated_at()', t);
  end loop;
end $$;
```

Notes:
- Only the **anon key** ships in the app. Never ship the service-role key.
- Test RLS with a second account: it must see zero rows from the first.
- Supabase free tier: projects pause after about a week of inactivity, and automatic daily backups are not included. Keep the manual export.

---

## 11. Screens and navigation

**Bottom tabs (ShellRoute):** Home, Trips, Fuel, Stats, Reminders.

| # | Screen | Purpose |
|---|---|---|
| 1 | Splash | Open DB, check session, route onward |
| 2 | Sign in | Google login, "Skip for now" |
| 3 | Permissions | Location, notifications, battery-optimization exemption |
| 4 | Vehicle setup / edit | Tank, reserve, mileage, odometer, starting fuel |
| 5 | **Home** | Fuel gauge (L left, range), Start Ride, last trip, low-fuel warning, settings icon |
| 6 | **Trips** | Timeline grouped by date, route preview, stats |
| 7 | **Fuel** | Refuel history, current mileage, add refuel |
| 8 | **Stats** | Mileage trend, cost per km, monthly spend |
| 9 | **Reminders** | Due and overdue items |
| 10 | **Live trip** | Big speedometer, distance, time, fuel left, range, mini map, large Stop; high contrast |
| 11 | Trip detail | Full map, speed and elevation graphs, fuel used |
| 12 | Add/edit refuel | Litres, price, odometer, full or partial |
| 13 | Add/edit reminder | Service by km or document by date |
| 14 | Settings | Units, safety factor, speed offset, low-fuel threshold, notifications |
| 15 | Account and backup | Google account, sync status, sync now, export/import |

**Dialogs (not screens):** ran dry / still running / reserve light, odometer sync, resume-or-finish interrupted trip, delete confirmation, low-fuel alert.

**Routes:** `/splash`, `/auth`, `/permissions`, `/setup`, `/home`, `/trips`, `/trips/:id`, `/fuel`, `/fuel/refuel/new|:id`, `/stats`, `/reminders`, `/reminders/new|:id`, `/live`, `/settings`, `/account`.

---

## 12. State management (Riverpod)

| Provider | Type | Source |
|---|---|---|
| `databaseProvider` | Provider | drift DB |
| `activeVehicleProvider` | StreamProvider | vehicles DAO |
| `fuelStateProvider` | StreamProvider | combines anchor, trips, live trip into `FuelEngine` |
| `liveTripProvider` | StreamProvider | active trip row + latest points |
| `tripsProvider` | StreamProvider | trips DAO, newest first |
| `statsProvider` | FutureProvider.family | aggregated queries by range |
| `remindersProvider` | StreamProvider | reminders + odometer estimate |
| `authStateProvider` | StreamProvider | Supabase auth |
| `syncStatusProvider` | StreamProvider | sync_state + pending count |
| `trackingControllerProvider` | Notifier | start/stop the foreground service |

`FuelEngine.compute(...)` is a pure function:

```dart
FuelState compute({
  required Vehicle vehicle,
  required Anchor anchor,              // latest refuel or fuel event
  required double kmSinceAnchor,       // completed trips, raw km
  required double liveTripKm,          // in-progress trip, raw km
}) {
  final mileage = vehicle.learnedMileage ?? vehicle.defaultMileage;
  final used = ((kmSinceAnchor + liveTripKm) * vehicle.distanceFactor) / mileage;
  final left = max(0.0, anchor.levelL - used);
  final range = left * mileage * vehicle.safetyFactor;
  return FuelState(litresLeft: left, rangeKm: range, isLow: left <= vehicle.lowFuelThresholdL);
}
```

---

## 13. Reminders and notifications

- **Service reminders (by km):** due when `estimated_odometer >= due_km − notify_before_km`. Evaluated after each trip completes and on app open.
- **Document reminders (by date):** insurance, PUC, RC, licence; notify at 30, 7 and 1 days before expiry via scheduled local notifications.
- **Low-fuel alert:** fires once when `litres_left` crosses `low_fuel_threshold_l`; re-arms after the next anchor.
- After editing or completing a reminder, reschedule its notifications.

---

## 14. Android configuration

**Permissions (AndroidManifest):**
`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_LOCATION`, `POST_NOTIFICATIONS`, `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`, `INTERNET`, `RECEIVE_BOOT_COMPLETED` (for rescheduling reminders), `SCHEDULE_EXACT_ALARM` only if exact reminder times are needed.

**Service declaration:** foreground service with `android:foregroundServiceType="location"`.

**First-run flow:** explain why before each system prompt. Request location "while using the app", start the foreground service from a visible UI action (Start Ride), then guide the user to exempt the app from battery optimization. Test on your real phone: manufacturer battery managers (Xiaomi, Oppo, Vivo, Samsung) often need extra manual settings.

**Google sign-in:** register SHA-1 for both debug and release keystores, or login fails in release builds.

**Build:** use a release keystore from the start; keep it backed up.

---

## 15. Error handling and edge cases

| Situation | Handling |
|---|---|
| App killed mid-trip | Trip left as `recording`, shown as `interrupted` on launch; Resume or Finish |
| GPS lost | Hold last value 2 s, then "No GPS"; mark the gap; do not add distance across long gaps |
| Forgot to start a trip | Odometer sync corrects missing km |
| Refuel during a trip | Block refuel entry while recording, or split the trip at that moment |
| Refuel logged late | Anchor uses the entered `at` time; trips are assigned by time, so the order stays correct |
| Estimate hits 0 but scooty runs | "Still running" button sets a small bonus anchor |
| Scooty dies before estimate hits 0 | "Ran dry" button sets 0 and teaches the leftover |
| Time zone changes | Store all timestamps in UTC |
| Sync fails | Rows stay `pending`, retried with backoff, error shown in Account |
| Login expires | Refresh the token; if that fails, pause sync and show a banner |
| Schema change | drift migrations with versioned steps; never drop user columns without a migration test |

---

## 16. Testing plan

**Unit tests (pure Dart, run on every change)**
- `FuelEngine`: the ₹100 example, multiple trips, refuel resets, reserve and ran-dry anchors, clamp at 0, safety factor
- `MileageLearner`: normal case, guards (short distance, outliers, clamps)
- `GpsFilter`: bad accuracy, jumps, stationary, signal loss, using recorded GPS tracks as fixtures
- `DistanceCalculator`: known routes, odometer factor
- Reminder due-date and due-km rules

**Integration tests**
- Repositories against an in-memory drift DB
- `SyncEngine` against a fake remote: push idempotency, partial failure, pull conflicts, soft deletes

**Manual field tests (real scooty)**
1. Record a 20 km ride and compare the app distance to the odometer
2. Kill the app mid-ride, reopen, confirm trip recovery
3. Record in airplane mode, reconnect, confirm upload
4. Uninstall, reinstall, sign in, confirm full restore
5. Run a full tank and compare predicted vs actual at the next refuel
6. Sunlight readability of the live trip screen on the handlebar mount

---

## 17. Security and privacy

- Location data is sensitive. It lives on the phone and in the user's own Supabase rows, protected by RLS.
- Only the anon key is in the app; no service-role key, no secrets in source control (use `--dart-define` or an untracked env file).
- Export files contain location history; warn before sharing.
- "Delete account data" removes cloud rows and signs out.

---

## 18. Build order and milestones

| # | Milestone | Done when |
|---|---|---|
| 0 | Project setup, lints, drift schema with sync columns, CI-style `flutter test` | Tables migrate; empty app runs |
| 1 | `FuelEngine` and `MileageLearner` with unit tests | All worked examples pass |
| 2 | Vehicle setup and Refuel log screens | Add a refuel; fuel gauge on Home updates |
| 3 | **Tracking spike**: foreground service, GPS stream, shared DB writes, UI stream updates | A real 10-minute ride is recorded and visible live |
| 4 | Trip recorder with filtering, persistence, crash recovery; Live trip screen; notification updates | 20 km ride matches the odometer within 3% |
| 5 | Home fuel loop end to end (ride changes litres and range live) | Estimate behaves correctly over a full tank |
| 6 | Trips timeline and Trip detail (map, graphs) | Past rides browsable |
| 7 | Google login and Supabase tables with RLS | Login works in a release build; RLS verified with 2 accounts |
| 8 | Sync engine (push, pull, soft deletes, workmanager) | Reinstall-and-restore test passes |
| 9 | Stats, reminders, notifications | Reminders fire on schedule |
| 10 | Settings, export/import, polish, field tests | All manual tests in section 16 pass |

Do milestone 3 early: background tracking is the riskiest part of the project.

---

## 19. Roadmap after v1

**v2:** idle-time fuel correction, city/highway mileage, auto trip start/stop, home screen widget, nearby petrol pumps, expense log, per-part maintenance, GPX export and ride cards, personal records, frequent routes, overspeed alerts.

**v3:** live location sharing, riding insights, crash detection, optional hardware sensor (ESP32/OBD), iOS release.

---

## 20. Decisions log

| Decision | Choice | Reason |
|---|---|---|
| Fuel storage | Derived from events | One source of truth; corrections propagate |
| Local DB | drift (SQLite) | Relational data, many rows, reactive streams |
| Backend | None; Supabase for backup and sync only | Phone works offline; no server to maintain |
| Sync | Outbox, UUIDs, soft deletes, last-write-wins | Simple and safe for one user |
| Route sync | One gzip blob per trip | Fewer rows, lossless enough for the timeline |
| Default range | Uses 90% of mileage | Better to warn early than strand the rider |
| Login | Optional Google sign-in | App never blocked by auth issues |

## 21. Open questions
1. Android or iPhone? (Assumed Android; affects background tracking and Google sign-in setup.)
2. Scooty model: tank capacity and reserve litres (placeholders: 5 L tank, 0.8 L reserve).
3. Does the low-fuel light still work? (If yes, the reserve-light button becomes the best calibration tool.)
4. Keep `reset` as the default refuel mode, or ask "full tank?" at every refuel?