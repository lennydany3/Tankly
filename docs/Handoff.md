# Tankly — design prototype handoff

Status: **UI prototype complete and verified.** `flutter analyze` is clean and
`flutter test` passes 25 tests (10 domain, 15 widget). Everything below is what
was built, what is real, and what is still mocked.

---

## 1. What this repo is right now

A fully designed, navigable **Flutter UI prototype** of Tankly — a fuel tracker
for scooter riders. Every screen, state and component in the design brief exists
in code, runs in both dark and light themes, and survives large text scaling.

It is deliberately **not** wired to a backend. No Supabase, no auth, no real GPS,
no notifications, no persistence. Those are described in `docs/Architecture.md`
and are the next milestone, not this one.

| Layer | State |
| --- | --- |
| Design system, screens, states | Real, complete |
| Fuel estimation engine (`lib/domain/fuel.dart`) | Real, unit-tested |
| Navigation between top-level destinations | Real |
| Form submission, refuel/reminder writes | Local state only |
| Auth, sync, GPS, notifications, storage | Mocked / not implemented |

---

## 2. Running it

```bash
flutter pub get
flutter run                                  # the app shell, dark theme
flutter run --dart-define=TANKLY_LIGHT=true  # the app shell, light theme
flutter run --dart-define=TANKLY_GALLERY=true  # the design gallery
```

The gallery is also reachable in code:

```dart
TanklyApp()                          // app shell (default)
TanklyApp(startAtGallery: true)      // gallery index
TanklyApp(startAtGallery: true, light: true)   // gallery, light theme
```

### Verification

```bash
dart format lib test
flutter analyze --no-pub     # No issues found!
flutter test                 # 25/25 passing
```

---

## 3. Project layout

```
lib/
  main.dart                     TanklyApp, TanklyLaunch
  app/
    tankly_shell.dart           bottom-nav shell, live-trip / settings / account routes
    gallery.dart                28 screen entries + design gallery + style sheets
  theme/
    tankly_palette.dart         raw colours, dark + light palettes
    tankly_type.dart            typography, tabular numeric styles
    tankly_tokens.dart          Gap, Radii, Sizes, Motion, TanklyIcons
    tankly_theme.dart           Material 3 ThemeData for both brightnesses
  domain/
    fuel.dart                   FuelEngine, FuelSnapshot, MileageLearner
  data/
    models.dart                 trip, refuel, reminder, TimeLabel
    demo_data.dart              one coherent demo state, not scattered fixtures
  design/                       the reusable system (see section 5)
  screens/                      one folder per area
test/
  fuel_engine_test.dart         10 domain tests
  widget_test.dart              15 layout/navigation tests at 390 x 844
docs/
  Design.md                     the design brief
  Architecture.md               the v1 system design
  Handoff.md                    this file
```

---

## 4. The five-tab shell

`lib/app/tankly_shell.dart` holds exactly five destinations in an `IndexedStack`:

`Home` · `Trips` · `Fuel` · `Stats` · `Reminders`

There is no drawer, so **Settings and Account live as the last two rows of the
Reminders tab** — nothing important is more than one tap from anywhere. Home's
gear icon and "All trips" / last-ride card push `SettingsScreen` and
`TripDetailScreen`; "Start ride" pushes `LiveTripScreen`.

---

## 5. The design system

Everything in `lib/design/` is screen-agnostic and theme-aware.

| File | Contents |
| --- | --- |
| `surfaces.dart` | `TankCard`, `Eyebrow`, `SectionHeader`, `TanklyBanner`, `EmptyState`, `Skeleton`, dividers |
| `controls.dart` | `TanklyButton` (5 variants incl. `riding`), `QuickActionButton`, `SwitchRow`, `PickerRow` |
| `inputs.dart` | `LabelledField`, `NumericField`, `SegmentedField`, steppers |
| `fuel_gauge.dart` | `FuelGauge`, `FuelLegend`, `FuelStrip`, `Pulse`, `_ArcPainter` |
| `data_display.dart` | `StatTile`, `StatusChip`, `TripCard`, `ReminderRow`, `InlineStat`, `SettingsRow` |
| `charts.dart` | rolling bar chart, donut, line chart |
| `route_map.dart` | painted route with start/end markers |
| `tankly_brand.dart` | `TanklyWordmark`, `TanklyMark` |
| `tankly_nav_bar.dart` | five-tab bottom nav |
| `dialogs.dart` | `DeleteConfirmDialog`, `ResumeTripDialog`, `LowFuelNotificationMock` |

### Rules the system enforces

- **Colour never carries state alone.** Every fuel status pairs its colour with
  an icon *and* a word (`good` / `medium` / `low` / `critical`). Green/yellow/
  orange/red are reserved for `FuelStatus` and nothing else in the app.
- **Estimates are always marked.** Every computed number keeps its `~`.
- **48 dp minimum touch target**, 72 dp for the riding controls.
- **Dark/OLED first**, but every screen is reachable in light. Both themes come
  from `context.palette`; no widget hard-codes a colour.
- **Numeric data is tabular.** All figures use `TanklyType.number` (Space
  Grotesk) so digits do not shimmer while a ride is recording.

---

## 6. Fuel estimation (the real logic)

`lib/domain/fuel.dart` is the only part of the prototype with real behaviour.

```dart
final snapshot = FuelEngine.compute(
  vehicle: VehicleSpec(mileageKmpl: 37.5, safetyFactor: 0.90, …),
  anchor:  FuelAnchor(at: lastFullFill, levelL: 0.93, odometerKm: …),
  rides:   recordedRides,
  now:     DateTime.now(),
);
```

Rules:

- `kmSinceAnchor` sums only rides that started **after the anchor and not after
  `now`**. A recorded ride that cannot be trusted must not move the needle.
- `usedL = (kmSinceAnchor × distanceFactor) / mileageKmpl`
- `litresLeft = max(0, anchor.levelL − usedL)`
- `rangeKm = litresLeft × mileage × safetyFactor`
- `fillRatio = litresLeft / tankCapacityL`
- Status: `≤ 0.25 L` → critical, otherwise `> 50 %` good, `≥ 25 %` medium, below
  that low. Critical wins over the percentage bands.
- `MileageLearner` updates the mileage figure at refuel time using an EMA, and
  guards documented in code: ignores samples under the minimum distance, rejects
  outliers, clamps to the configured range.

### The demo state, and the one number that differs from the brief

The brief's Home screenshot reads *42 km* on range. That is not reproducible from
its own inputs, so the prototype uses the honest figure:

| Input | Value |
| --- | --- |
| Since last full fill | 20.0 km |
| Anchor at that fill | 0.93 L |
| Mileage | 37.5 km/L |
| Safety factor | 0.90 |
| **Result** | **≈ 0.40 L · ≈ 13 km · Low** |

`0.93 − (20 / 37.5) = 0.397 L`, and `0.397 × 37.5 × 0.90 = 13.4 km`.

**Decision:** show the honest number. A fuel gauge that overstates range by 3× is
the one failure this product cannot ship. `FuelEngine.compute` is a pure function,
so if the anchor or factor changes the display follows automatically — no screen
holds a hard-coded range. This is called out rather than silently "fixed", because
if 42 km was intentional there is a fact about the estimator we are missing.

---

## 7. Screen inventory

All 28 gallery entries render from the same widgets the app uses — there is no
separate "mock" copy of any screen.

| # | Screen | States shown |
| --- | --- | --- |
| 1 | Splash | — |
| 2 | Sign in | — |
| 3 | Permissions | — |
| 4 | Vehicle setup | — |
| 5 | Home | low fuel · healthy · loading · offline |
| 6 | Live trip | tracking · no GPS · no fuel data |
| 7 | Trips | listed · empty |
| 8 | Fuel | listed · empty |
| 9 | Stats | — |
| 10 | Reminders | listed · empty |
| 11 | Trip detail | — |
| 12 | Refuel form | add · edit |
| 13 | Correction sheets | fuel correction · odometer |
| 14 | Finish ride | — |
| 15 | Settings | — |
| 16 | Account | synced · signed out |

Plus the style sheets in the gallery: colours, type scale, components.

---

## 8. Tests

`test/fuel_engine_test.dart` — 10 tests over `FuelEngine.compute`: known value,
empty state, past/future ride filtering, clamping at zero, threshold boundaries,
partial refuel handling.

`test/widget_test.dart` — 15 tests. Every screen is checked at **390 × 844**, the
size the brief is drawn at, so a layout that only works on a tablet fails here:

- the shell opens on Home and every bottom-nav tab builds without overflow
- Home shows the honest estimate and the status **word**, and the loading state
  shows a skeleton rather than a `0.00` gauge
- Home in the light theme
- Live trip tracking, GPS-searching stated in words, and 160 % text scale
- each tab's populated and empty states
- the gallery index lists every group
- **all 28 gallery entries build without throwing**

During development the gallery entries were also swept across
**2 themes × 3 text scales (1.0 / 1.3 / 1.6) = 174 combinations**, all clean. If
you add a screen, that sweep is the bar.

### Two traps worth knowing

1. **`flutter test` does not load bundled fonts.** Every glyph falls back to a
   square test face, so text is far wider than on device. Any `Row` here can
   overflow in tests and not on a phone — which is exactly why so many rows are
   built with `Expanded`/`Flexible` + `TextOverflow.ellipsis`. Keep it that way;
   it is also what makes the UI survive large text scaling.

2. **Never create an `AnimationController` lazily in `dispose()`.**
   `late final _controller = AnimationController(vsync: this, …)` is initialised
   on *first access*; if `build` returned early (disabled `Pulse`) the first
   access happens inside `dispose()`, and `createTicker` looks up `TickerMode` on
   a deactivated element. Create it in `initState` instead — assign `.value` to
   force creation without starting it, so a disabled animation costs no frames.

---

## 9. SDK notes for this environment

Flutter `3.44.4` / Dart `3.12.2`. Two things that will bite you:

- `ListView` is **not** const-constructible in this SDK, so the constructors
  that wrap one cannot be `const`.
- This toolchain rejects standalone `const DateTime(…)`, so demo timestamps are
  non-const even though that looks like dead weight.

Both are workarounds, not style choices. Do not "clean them up" without running
the tests.

---

## 10. Known limitations / next milestone

Nothing below is a bug in the prototype; it is simply not built.

- **No persistence.** Refuelling and reminders live in widget state and vanish
  on restart. `drift` models are specified in `docs/Architecture.md` §6.
- **No auth.** "Sign in" is a no-op; the app is fully usable signed out, which is
  the intended v1 behaviour, but `AccountScreen`'s signed-out variant is the only
  implemented account state.
- **No GPS.** `LiveTripScreen` animates a fixed demo ride. There is no
  `geolocator` stream behind `LiveGps`.
- **No notifications.** `LowFuelNotificationMock` is a static preview of the
  real banner; no scheduling, no permission prompts beyond the explanation UI.
- **No sync / offline queue.** `StatusChip` shows `synced`, `offline` and
  `syncing` as literals chosen per screen.
- **No units other than km/L.** The Settings screen offers metric as the only
  option; imperial is a display concern still to be built.
- **Ride history is one ride.** `DemoData` carries a single evening ride so the
  stats and fuel screens are internally consistent; real history needs the
  database.

---

## 11. Conventions to follow

- No new packages without a reason in the changelog. The prototype uses Flutter
  SDK and the two bundled fonts only.
- Colours, spacing, radii and durations come from `theme/`. If you need a new
  one, add it there — do not inline a literal.
- Never `Theme.of(context)` a colour directly; use `context.palette`.
- Screens stay dumb: they take a snapshot and callbacks. `lib/domain/` and
  `lib/data/` never import Flutter.
- Every new screen gets a `GalleryEntry` so it is reviewable in one place.
