import 'package:flutter/material.dart' show IconData, Offset, Icons;

/// A recorded ride. Maps to the `trips` table.
class TripRecord {
  const TripRecord({
    required this.id,
    required this.title,
    required this.startedAt,
    required this.endedAt,
    required this.distanceKm,
    required this.durationS,
    required this.avgKmph,
    required this.maxKmph,
    required this.elevationGainM,
    required this.startLabel,
    required this.endLabel,
    required this.route,
    this.movingS,
    this.fuelUsedL,
  });

  final String id;
  final String title;
  final DateTime startedAt;
  final DateTime endedAt;
  final double distanceKm;
  final int durationS;
  final double avgKmph;
  final double maxKmph;
  final double elevationGainM;
  final String startLabel;
  final String endLabel;

  /// Normalised 0–1 points, drawn by `RouteMap`. Swap for `flutter_map`
  /// polylines once the real tile layer is wired up.
  final List<Offset> route;

  final int? movingS;
  final double? fuelUsedL;

  /// "41 min", or "1 h 12 min" once the ride passes an hour.
  String get durationLabel {
    final minutes = (durationS / 60).round();
    if (minutes < 60) return '$minutes min';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '$h h' : '$h h $m min';
  }

  String get startTimeLabel => TimeLabel.clock(startedAt);
  String get endTimeLabel => TimeLabel.clock(endedAt);
}

/// A refuel. Doubles as a fuel anchor when `anchorMode` is reset or full.
class RefuelRecord {
  const RefuelRecord({
    required this.at,
    required this.litres,
    required this.priceTotal,
    required this.odometerKm,
    this.isFull = false,
    this.notes,
  });

  final DateTime at;
  final double litres;
  final int priceTotal;
  final double odometerKm;
  final bool isFull;
  final String? notes;

  double get pricePerLitre => litres <= 0 ? 0.0 : priceTotal / litres;
}

/// Reminder category.
enum ReminderKind { service, document }

/// Urgency. Drives the row colour, and is always paired with text.
enum ReminderUrgency { ok, dueSoon, overdue }

class ReminderRecord {
  const ReminderRecord({
    required this.kind,
    required this.title,
    required this.urgency,
    required this.detail,
    this.icon = Icons.build_outlined,
  });

  final ReminderKind kind;
  final String title;
  final ReminderUrgency urgency;
  final String detail;
  final IconData icon;
}

/// Connection / backup status surfaced by the status chip.
enum SyncPhase { synced, syncing, offline, gpsSearching, failed }

/// Small date helpers so every screen formats time identically.
abstract final class TimeLabel {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String clock(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m ${t.hour < 12 ? 'am' : 'pm'}';
  }

  /// "2 Oct", or "2 Oct 2025" when the year differs from [now].
  static String dayMonth(DateTime t, {DateTime? now}) {
    final base = '${t.day} ${_months[t.month - 1]}';
    final reference = now ?? DateTime.now();
    return t.year == reference.year ? base : '$base ${t.year}';
  }

  static String monthYear(DateTime t) => '${_months[t.month - 1]} ${t.year}';

  static String monthShort(DateTime t) => _months[t.month - 1];

  /// "Today", "Yesterday", or a short date.
  static String relativeDay(DateTime t, DateTime now) {
    final day = DateTime(t.year, t.month, t.day);
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return 'This week';
    return dayMonth(t, now: now);
  }

  /// "12 days ago", "3 weeks ago".
  static String ago(DateTime t, DateTime now) {
    final days = now.difference(t).inDays;
    if (days <= 0) return 'today';
    if (days == 1) return 'yesterday';
    if (days < 7) return '$days days ago';
    if (days < 14) return '1 week ago';
    if (days < 60) return '${days ~/ 7} weeks ago';
    return '${days ~/ 30} months ago';
  }

  /// Stopwatch readout for the Live Trip screen.
  static String stopwatch(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return h > 0 ? '$h:$mm:$ss' : '$mm:$ss';
  }
}
