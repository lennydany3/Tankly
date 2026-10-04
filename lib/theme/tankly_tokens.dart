import 'package:flutter/material.dart';

/// Spacing scale. Everything in the layout sits on one of these values.
abstract final class Gap {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;

  /// Horizontal screen padding.
  static const screen = 16.0;

  /// Card padding.
  static const card = 16.0;
}

/// Corner radii.
abstract final class Radii {
  static const card = 20.0;
  static const field = 16.0;
  static const button = 16.0;

  /// Start Ride / Stop. Stadiums read as toys; a 28 dp radius on a 72 dp
  /// button keeps it unmistakably a riding control.
  static const riding = 28.0;

  static const chip = 999.0;
  static const sheet = 28.0;
  static const thumb = 12.0;
}

/// Fixed control sizes.
abstract final class Sizes {
  /// Minimum accessible touch target.
  static const tap = 48.0;

  /// Start Ride and Stop buttons.
  static const rideButton = 72.0;

  /// Bottom navigation bar.
  static const navBar = 64.0;

  /// Hairline border width used everywhere instead of elevation.
  static const hairline = 1.0;

  /// Reference device the spec is drawn against.
  static const designWidth = 390.0;
  static const designHeight = 844.0;
}

/// Motion. 150–250 ms ease-out for almost everything.
abstract final class Motion {
  static const fast = Duration(milliseconds: 150);
  static const base = Duration(milliseconds: 200);
  static const slow = Duration(milliseconds: 250);

  /// Fuel arc fill.
  static const gauge = Duration(milliseconds: 400);

  /// Critical fuel breathing loop. Slow enough to read as a warning rather
  /// than an alarm.
  static const pulse = Duration(milliseconds: 1500);

  static const easeOut = Curves.easeOutCubic;
  static const standard = Curves.easeOutCubic;
}

/// Icons that carry meaning on more than one screen.
///
/// Kept here so "GPS is still locking" is the same glyph in the status chip,
/// the Live Trip header and the account sync card.
abstract final class TanklyIcons {
  static const gpsSearching = Icons.my_location_rounded;
  static const gpsLocked = Icons.gps_fixed_rounded;
  static const fuel = Icons.local_gas_station_rounded;
  static const ride = Icons.directions_bike_rounded;
  static const correct = Icons.tune_rounded;
}
