# Tankly: Frontend Design Master Prompt

> Paste everything below the line into Claude (design mode) to generate the Tankly UI.
> After the first pass, iterate screen by screen ("tighten the Home gauge", "make the Live Trip speed bigger").

---

## ROLE

You are a senior mobile product designer. Design the complete UI for **Tankly**, a Flutter Android app. Produce polished, high-fidelity screens that a developer can rebuild in Flutter (Material 3) without guessing. Every screen must feel like part of one coherent product.

## PRODUCT

**Tankly** is a fuel gauge and ride tracker for a scooter whose built-in fuel indicator is broken. A phone cannot read the tank, so Tankly **estimates** petrol left from GPS distance and the petrol the rider logs at each refuel. It also records rides Strava-style (route, speed, distance, time).

- **User:** one scooter rider in India. Often checks the app at a glance on a handlebar mount, in bright sunlight, with gloves on.
- **Core promise:** "Always know how much petrol you have left."
- **Tone:** confident, calm, practical. Not playful, not corporate. Think instrument cluster meets a clean fitness app.
- **Currency and units:** ₹, litres, km, km/h, km/L.

### How the fuel logic shows up in the UI (design for this)
- Each refuel sets the starting petrol (example: ₹100 buys 0.93 L).
- Petrol left = litres at last refuel − (km ridden ÷ mileage). Mileage is about 35 to 40 km/L (default 37.5), and the app learns it over time.
- Range = petrol left × mileage, shown conservatively.
- The value is an **estimate**, so show it with an honest "~" (for example `~0.40 L`, `~13 km`) and offer correction actions: "Light came on", "Ran dry", "Still running", "Sync odometer".

## DESIGN PRINCIPLES

1. **Glanceable first.** The most important number on any screen is readable from arm's length in 1 second.
2. **One hero per screen.** One dominant element, everything else supports it.
3. **Fuel state is a color language.** Green, yellow, orange, red are reserved for fuel status only. Never use them decoratively. Always pair color with a number and an icon (glare, color blindness).
4. **Big tap targets.** Minimum 48 dp, riding-critical buttons 64 dp or more.
5. **Dark by default, OLED-friendly.** Light theme is a secondary variant.
6. **Honest about uncertainty.** Estimates carry "~" and a small "estimated" hint where it matters.
7. **Calm density.** Generous spacing, no clutter, no decorative gradients behind text.

## BRAND

- **Name:** Tankly. Wordmark in a rounded geometric sans, lowercase or sentence case, slightly heavy.
- **Tagline (optional, onboarding and splash only):** "Know your tank."
- **App icon:** a simple droplet or fuel-gauge arc in Volt Cyan on a near-black rounded square. One shape, no text. Provide a monochrome version for the Android themed icon.
- **Personality words:** precise, steady, road-ready.

## DESIGN TOKENS

### Colors (dark theme, primary)

| Token | Hex | Use |
|---|---|---|
| bg | `#0B0F14` | App background |
| surface | `#131A22` | Cards, bottom bar |
| surfaceHigh | `#1B2530` | Dialogs, selected items |
| outline | `#2A3644` | Dividers, card borders |
| text | `#F2F5F8` | Primary text and numbers |
| textDim | `#9AA8B8` | Labels, captions |
| accent (Volt Cyan) | `#22D3EE` | Primary buttons, active tab, route line |
| accentSoft | `#0E3A44` | Accent chips and backgrounds |
| fuelGood | `#34D399` | Above 50% |
| fuelMedium | `#FACC15` | 25% to 50% |
| fuelLow | `#FB923C` | Below 25% |
| fuelCritical | `#EF4444` | At or below the low-fuel threshold (pulse gently) |
| info | `#60A5FA` | GPS searching |

**Live Trip screen:** pure `#000000` background for maximum contrast and OLED saving.

### Colors (light variant)
bg `#F6F8FA`, surface `#FFFFFF`, text `#0B0F14`, textDim `#5B6B7C`, accent `#0891B2`, fuelMedium `#CA8A04`; other fuel colors unchanged. Design the Home and Live Trip screens in light as well.

### Typography
- **Numbers and gauges:** Space Grotesk (tabular figures) so digits do not jitter as values change.
- **UI text:** Inter.
- Scale (sp): Display 72 (speed), 56 (litres hero), Headline 28, Title 20, Body 16, Label 14, Caption 12.
- Weights: numbers 600 to 700, labels 500, body 400.

### Shape, spacing, elevation
- Spacing scale: 4, 8, 12, 16, 24, 32.
- Screen padding 16 dp. Card padding 16 dp.
- Radius: cards 20, buttons 16 (primary riding buttons 28), chips 999, sheets 28 (top corners).
- Elevation: flat with 1 dp outline borders, no heavy shadows. Use tonal surface changes for depth.
- Icons: Material Symbols Rounded, 24 dp, 2 dp stroke weight feel.

### Motion
- 150 to 250 ms ease-out for most transitions.
- Gauge fills animate smoothly when the value changes (400 ms).
- Critical fuel state pulses softly (opacity 100% to 70%, 1.5 s loop). No flashing.
- Respect reduced-motion settings.

## COMPONENT LIBRARY (design these first, then reuse)

1. **Fuel Gauge (hero):** a 240-degree radial arc with a large `~0.40 L` in the center (Space Grotesk 56), `~13 km range` beneath, and an "estimated" caption. Arc color follows the fuel status. Include four tick marks at 0, 25, 50, 100%, and a small reserve notch.
2. **Primary Button (Start Ride):** full-width, 72 dp high, accent fill, dark text, play icon.
3. **Stop Button:** full-width, 72 dp high, `#EF4444` fill, white text.
4. **Stat Tile:** label (caption, textDim) above a value (title, text) with a unit.
5. **Trip Card:** route thumbnail (dark map, cyan line), date and time, distance, duration, average speed.
6. **Bottom Navigation:** 5 tabs (Home, Trips, Fuel, Stats, Reminders), icon plus label, active tab in accent with a soft pill behind it.
7. **Status Chip:** Synced, Syncing, Offline, GPS searching, Sync failed.
8. **Reminder Row:** icon, title, due info (km or date), status color (OK, due soon, overdue).
9. **Bottom Sheet:** rounded top, drag handle, used for correction actions.
10. **Form Fields:** filled, rounded 16, large numeric inputs for litres, price, odometer.
11. **Empty State:** simple line illustration (droplet, route) plus a clear action.
12. **Banner:** low fuel, interrupted trip, sync problem.

## SCREENS TO DESIGN (mobile, 390 × 844)

Design **all** screens below, in dark theme. Provide light variants for Home and Live Trip. Use realistic data.

### First launch
1. **Splash:** wordmark, droplet mark, tagline, subtle loading line.
2. **Sign in:** "Continue with Google" button, "Skip for now" text button, one line explaining that signing in backs up rides and fuel logs.
3. **Permissions:** three stacked cards (Location, Notifications, Battery optimization), each with an icon, one sentence on why it is needed, and a status check; one primary "Allow and continue" button.
4. **Vehicle setup:** fields for vehicle name, tank capacity (L), reserve (L), mileage (km/L, default 37.5), current odometer (km), and "Petrol in the tank right now (L)". Show helper text under each. Same screen is reused for editing.

### Main tabs
5. **Home:** top bar with "Tankly" wordmark, sync chip, and a settings icon. Hero Fuel Gauge. Under it, a row of two Stat Tiles (Mileage `37.5 km/L`, Since refuel `42 km`). A large **Start Ride** button. A "Last ride" Trip Card. A low-fuel banner variant (design both normal and low states). Quick actions row: Add refuel, Light came on, Sync odometer.
6. **Trips (timeline):** a header with a month filter and total km. Trip Cards grouped by date headers (Today, Yesterday, This week). Include an empty state.
7. **Fuel:** top summary (current mileage, cost per km, last refuel). Refuel history list: date, litres, ₹ amount, odometer, a "Full" badge. Floating "Add refuel" button.
8. **Stats:** segmented range selector (Week, Month, Year). Cards with charts: mileage trend (line), monthly spend (bars), cost per km (big number plus sparkline), total distance and rides.
9. **Reminders:** grouped by Service and Documents. Rows such as "Oil change, due in 320 km", "Insurance, expires in 12 days" (due soon, yellow), "PUC, overdue by 3 days" (red). Add button.

### Riding and detail
10. **Live Trip (most important screen):** pure black background. Giant speed (Display 72 or larger) with `km/h` unit, centered. Below: distance and duration as two large tiles. A compact fuel strip showing `~0.40 L` and `~13 km` in the fuel status color. A small dark mini-map with the route. A full-width Stop button at the bottom. A GPS signal indicator in the corner. Design a "No GPS" state and a "Low fuel" state (strip turns critical, gentle pulse). Keep everything readable at arm's length in sunlight.
11. **Trip detail:** full-width dark map with the cyan route (start and end markers), summary tiles (distance, time, average speed, max speed, fuel used, elevation gain), a speed graph, and an elevation graph. Overflow menu: rename, delete.
12. **Add/edit refuel:** big numeric input for litres, price input (with computed price per litre), odometer, a Full tank toggle, date and time. Show a live preview card: "New estimate: ~0.93 L, ~35 km range". Save button.
13. **Add/edit reminder:** type selector (Service by km, Document by date), title, due value, repeat interval, notify-before setting.
14. **Settings:** grouped list: Vehicle, Fuel (safety margin, low-fuel alert level), Speedometer (offset), Units, Notifications, Theme, Data (export, import), About.
15. **Account and backup:** Google account card, sync status with last synced time, pending items count, "Sync now" button, export and import buttons, "Delete cloud data" in a danger zone.

### Dialogs and sheets (design each)
- **Correction sheet:** three options as large rows ("Light came on", "Ran dry", "Still running"), each with a one-line explanation.
- **Odometer sync sheet:** numeric input, shows GPS-measured distance versus entered value.
- **Resume or finish trip dialog:** shown when the app was closed mid-ride.
- **Low-fuel alert:** persistent card plus notification mock-up.
- **Delete confirmation.**
- **Foreground notification mock-up (Android):** "Ride in progress · ~0.40 L · ~13 km · 32 km/h".

## SAMPLE DATA (use for realism)

- Fuel: `~0.40 L` left, `~13 km` range, mileage `37.5 km/L`, 42 km since refuel.
- Refuels: 2 Oct, 0.93 L, ₹100, odometer 18,420 km; 25 Sep, 1.86 L, ₹200, odometer 18,330 km; 18 Sep, 0.93 L, ₹100.
- Trips: "Home to College", 8.4 km, 24 min, avg 21 km/h; "Evening ride", 20.1 km, 41 min, avg 29 km/h; "Market run", 3.2 km, 11 min.
- Stats: total 312 km this month, cost per km ₹2.7, monthly spend ₹850.
- Reminders: Oil change due in 320 km; Insurance expires in 12 days; PUC overdue by 3 days; Chain lube due in 90 km.
- Route area: Chennai (do not show real business names on maps).

## STATES TO COVER

For key screens, show: **default, loading (skeleton), empty, error/offline, and low-fuel**. Include at least: Home (normal, low, critical), Live Trip (normal, no GPS, low fuel), Trips (empty), Account (syncing, synced, failed).

## ACCESSIBILITY

- Text contrast at least 4.5:1 (7:1 for the live speed and fuel numbers).
- Never convey fuel state by color alone.
- Minimum touch target 48 dp.
- Support font scaling up to 130% on Home without breaking the layout.

## FLUTTER-FRIENDLINESS CONSTRAINTS

- Use only what Flutter Material 3 can reproduce: standard widgets, rounded containers, CustomPainter arcs, `fl_chart`-style charts, `flutter_map` with a dark tile style.
- No blur-heavy glassmorphism, no complex shaders, no web-only effects.
- Keep layouts on an 8-point grid and name components consistently so they map to widgets.

## DELIVERABLES

1. A one-page **style sheet**: colors, type scale, spacing, radii, icon style, and the component library.
2. All **screens** listed above, dark theme, 390 × 844, grouped by flow (First launch, Main tabs, Riding and detail, Dialogs).
3. **Light variants** of Home and Live Trip.
4. **State variants** listed under "States to cover".
5. A short **handoff note**: which components repeat, the fuel color logic (thresholds: above 50% good, 25 to 50% medium, below 25% low, at or below the alert level critical), and any assumptions you made.

If something is ambiguous, make a sensible decision, state it in the handoff note, and keep going rather than asking.