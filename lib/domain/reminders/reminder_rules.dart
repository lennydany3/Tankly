import 'package:tankly/domain/models/refuel.dart';

/// One reminder, resolved against the current state of the vehicle.
class ReminderState {
  const ReminderState({
    required this.spec,
    required this.urgency,
    this.remainingKm,
    this.remainingDays,
  });

  final ReminderSpec spec;
  final ReminderUrgency urgency;

  /// Remaining real km for a service reminder; null for documents.
  final double? remainingKm;

  /// Remaining days for a document reminder; null for services.
  final int? remainingDays;

  bool get isActionable => urgency != ReminderUrgency.ok;

  String get title => spec.title;

  /// Card subtitle. Always says what is left rather than only colouring the
  /// card, so urgency is never carried by colour alone.
  String get subtitle => switch (spec.kind) {
    ReminderKind.service => switch (remainingKm) {
      null => 'Set a due odometer to start tracking',
      final km when km <= 0 => 'Overdue by ${(-km).round()} km',
      final km => 'Due in ${km.round()} km',
    },
    ReminderKind.document => switch (remainingDays) {
      null => 'Set an expiry date to start tracking',
      final d when d < 0 => 'Expired ${-d} ${_days(-d)} ago',
      final d => 'Due in $d ${_days(d)}',
    },
  };

  static String _days(int n) => n == 1 ? 'day' : 'days';
}

/// Decides whether a reminder is on track, due soon, or overdue
/// (system design 9).
///
/// Pure and synchronous: the same call serves the reminders screen, the home
/// card count and the notification scheduler, so all three can never disagree
/// about what is due.
abstract final class ReminderRules {
  /// Resolves one rule. [odometerKm] is the estimated real odometer.
  static ReminderState evaluate({
    required ReminderSpec spec,
    required double odometerKm,
    DateTime? now,
  }) => switch (spec.kind) {
    ReminderKind.service => _service(spec, odometerKm),
    ReminderKind.document => _document(spec, now ?? DateTime.now()),
  };

  static List<ReminderState> evaluateAll({
    required Iterable<ReminderSpec> specs,
    required double odometerKm,
    DateTime? now,
  }) => specs
      .map((s) => evaluate(spec: s, odometerKm: odometerKm, now: now))
      .toList();

  /// Only the ones worth interrupting the rider for, most urgent first.
  static List<ReminderState> dueSoon({
    required Iterable<ReminderSpec> specs,
    required double odometerKm,
    DateTime? now,
  }) {
    final actionable =
        evaluateAll(
          specs: specs,
          odometerKm: odometerKm,
          now: now,
        ).where((r) => r.isActionable).toList()..sort((a, b) {
          final byUrgency = b.urgency.index.compareTo(a.urgency.index);
          if (byUrgency != 0) return byUrgency;
          return _rank(a).compareTo(_rank(b));
        });
    return actionable;
  }

  /// The headline number on the home card: how many need attention now.
  static int actionableCount({
    required Iterable<ReminderSpec> specs,
    required double odometerKm,
    DateTime? now,
  }) => dueSoon(specs: specs, odometerKm: odometerKm, now: now).length;

  static ReminderState _service(ReminderSpec spec, double odometerKm) {
    final due = spec.nextDueKm ?? spec.dueKm;
    if (due == null) {
      return ReminderState(spec: spec, urgency: ReminderUrgency.ok);
    }
    final remaining = due - odometerKm;
    return ReminderState(
      spec: spec,
      urgency: remaining <= 0
          ? ReminderUrgency.overdue
          : remaining <= spec.notifyBeforeKm
          ? ReminderUrgency.dueSoon
          : ReminderUrgency.ok,
      remainingKm: remaining,
    );
  }

  static ReminderState _document(ReminderSpec spec, DateTime today) {
    final due = spec.nextDueDate ?? spec.dueDate;
    if (due == null) {
      return ReminderState(spec: spec, urgency: ReminderUrgency.ok);
    }
    final remainingDays = DateTime(
      due.year,
      due.month,
      due.day,
    ).difference(DateTime(today.year, today.month, today.day)).inDays;
    return ReminderState(
      spec: spec,
      urgency: remainingDays < 0
          ? ReminderUrgency.overdue
          : remainingDays <= spec.notifyBeforeDays
          ? ReminderUrgency.dueSoon
          : ReminderUrgency.ok,
      remainingDays: remainingDays,
    );
  }

  /// Within one urgency level, the nearest deadline first: 20 km beats 400 km,
  /// 2 days beats 2 weeks.
  static int _rank(ReminderState r) {
    final distance = r.remainingKm ?? (r.remainingDays ?? 0) * 40;
    return distance.round();
  }

  /// Whether a notification should fire. Separate from [evaluate] so the
  /// scheduler can ask "is this new?" using [notificationId] without re-deriving
  /// the urgency itself.
  static bool shouldNotify(ReminderState state) => state.isActionable;

  /// Stable id so re-notifying the same rule replaces the previous notification
  /// instead of stacking up (system design 9).
  static String notificationId(ReminderSpec spec) =>
      'tankly.reminder.${spec.id ?? spec.title.hashCode}';

  /// Body text for the notification.
  static String notificationBody(
    ReminderState state,
  ) => switch (state.urgency) {
    ReminderUrgency.overdue => '${state.title} is overdue. ${state.subtitle}',
    ReminderUrgency.dueSoon => '${state.title} coming up. ${state.subtitle}',
    ReminderUrgency.ok => '${state.title} is on track',
  };
}
