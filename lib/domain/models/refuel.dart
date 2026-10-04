/// How a refuel sets the fuel anchor (system design 2).
enum AnchorMode {
  /// Level becomes `litres + assumedLeftover`. The default, because the estimate
  /// is then safe and slightly pessimistic.
  reset,

  /// Level becomes tank capacity. Exact, and the only mode that yields an exact
  /// mileage observation.
  full;

  String get wire => name;

  static AnchorMode parse(String raw) =>
      raw == 'full' ? AnchorMode.full : AnchorMode.reset;
}

/// Manual correction events that pin a known level without a refuel.
enum FuelEventKind {
  /// The reserve light came on. Level is the configured reserve.
  reserveLight,

  /// The scooter ran dry. Level is 0, and the leftover teaches the mileage.
  ranDry,

  /// Still running after the estimate hit 0. Level is a small bonus.
  stillRunning;

  String get wire => name;

  static FuelEventKind parse(String raw) => FuelEventKind.values.firstWhere(
    (k) => k.name == raw,
    orElse: () => FuelEventKind.reserveLight,
  );
}

/// What a reminder tracks.
enum ReminderKind {
  /// Odometer-based: oil, tyres, brakes.
  service,

  /// Date-based: insurance, PUC, RC, licence.
  document;

  String get wire => name;

  static ReminderKind parse(String raw) =>
      raw == 'document' ? ReminderKind.document : ReminderKind.service;
}

/// How overdue a reminder is. Drives the urgency colour.
enum ReminderUrgency {
  ok,
  dueSoon,
  overdue;

  String get label => switch (this) {
    ReminderUrgency.ok => 'On track',
    ReminderUrgency.dueSoon => 'Due soon',
    ReminderUrgency.overdue => 'Overdue',
  };
}

/// A reminder rule. Mirrors the `reminders` table.
///
/// A service reminder is due when the estimated odometer reaches
/// `dueKm - notifyBeforeKm`. A document reminder is due on a date.
class ReminderSpec {
  const ReminderSpec({
    this.id,
    required this.vehicleId,
    required this.kind,
    required this.title,
    this.dueKm,
    this.dueDate,
    this.intervalKm,
    this.intervalDays,
    this.lastDoneKm,
    this.lastDoneDate,
    this.notifyBeforeKm = 500,
    this.notifyBeforeDays = 7,
    this.notes,
    this.iconCodePoint,
  });

  final String? id;
  final String vehicleId;
  final ReminderKind kind;
  final String title;

  /// Service only. Absolute odometer at which this is due.
  final double? dueKm;

  /// Document only.
  final DateTime? dueDate;

  /// Auto-reschedule interval after being marked done.
  final double? intervalKm;
  final int? intervalDays;

  final double? lastDoneKm;
  final DateTime? lastDoneDate;

  final double notifyBeforeKm;
  final int notifyBeforeDays;
  final String? notes;
  final int? iconCodePoint;

  /// The next due point after "done", when an interval is set.
  double? get nextDueKm =>
      intervalKm == null ? null : (lastDoneKm ?? 0) + intervalKm!;
  DateTime? get nextDueDate => intervalDays == null
      ? null
      : (lastDoneDate ?? DateTime.now()).add(Duration(days: intervalDays!));

  ReminderSpec copyWith({
    String? id,
    String? vehicleId,
    ReminderKind? kind,
    String? title,
    double? dueKm,
    DateTime? dueDate,
    double? intervalKm,
    int? intervalDays,
    double? lastDoneKm,
    DateTime? lastDoneDate,
    double? notifyBeforeKm,
    int? notifyBeforeDays,
    String? notes,
    int? iconCodePoint,
  }) => ReminderSpec(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    dueKm: dueKm ?? this.dueKm,
    dueDate: dueDate ?? this.dueDate,
    intervalKm: intervalKm ?? this.intervalKm,
    intervalDays: intervalDays ?? this.intervalDays,
    lastDoneKm: lastDoneKm ?? this.lastDoneKm,
    lastDoneDate: lastDoneDate ?? this.lastDoneDate,
    notifyBeforeKm: notifyBeforeKm ?? this.notifyBeforeKm,
    notifyBeforeDays: notifyBeforeDays ?? this.notifyBeforeDays,
    notes: notes ?? this.notes,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
  );
}

/// One odometer reading the rider typed in, and what it taught the app.
class OdometerCheckSample {
  const OdometerCheckSample({
    this.id,
    required this.vehicleId,
    required this.at,
    required this.odometerKm,
    this.gpsKmSinceLast,
    this.factorSample,
  });

  final String? id;
  final String vehicleId;
  final DateTime at;
  final double odometerKm;
  final double? gpsKmSinceLast;
  final double? factorSample;
}
