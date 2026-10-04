/// Either a value or a failure, without exceptions for expected outcomes.
///
/// Repositories return this instead of throwing, so a missing row or a failed
/// write is an ordinary value the caller must handle. Genuinely unexpected
/// faults are still [Error]s and still crash loudly in debug.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  /// The value, or null. Use [fold] or [match] when the failure matters.
  T? get valueOrNull => switch (this) {
    Ok<T>(:final value) => value,
    Err<T>() => null,
  };

  T unwrap() => switch (this) {
    Ok<T>(:final value) => value,
    Err<T>(:final error) => throw StateError('$error'),
  };

  R fold<R>(R Function(T value) onOk, R Function(Failure error) onErr) =>
      switch (this) {
        Ok<T>(:final value) => onOk(value),
        Err<T>(:final error) => onErr(error),
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok<T>(:final value) => Ok(transform(value)),
    Err<T>(:final error) => Err(error),
  };
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;

  @override
  String toString() => 'Ok($value)';
}

class Err<T> extends Result<T> {
  const Err(this.error);
  final Failure error;

  @override
  String toString() => 'Err($error)';
}

/// Why something failed. Deliberately small: every case here is something the
/// UI can explain to a rider in one line.
enum FailureKind {
  /// A row the caller expected does not exist.
  notFound,

  /// The write failed. [message] carries the SQLite text.
  write,

  /// No network, or the request timed out.
  network,

  /// The server rejected it: signed out, or the row failed a constraint.
  conflict,

  /// A sync row failed a rule on the way in or out.
  rejected,

  /// Permissions denied: location, notifications, background.
  permission,

  /// A platform channel threw. Usually a plugin on an unsupported OS version.
  platform,

  unknown,
}

/// A failure with enough context to log and enough restraint to display.
class Failure {
  const Failure(this.kind, {this.message, this.detail, this.cause});

  const Failure.notFound([String? what])
    : this(
        FailureKind.notFound,
        message: what == null ? null : '$what not found',
      );

  const Failure.network([String? message])
    : this(FailureKind.network, message: message);
  const Failure.permission([String? message])
    : this(FailureKind.permission, message: message);
  const Failure.platform([String? message])
    : this(FailureKind.platform, message: message);

  final FailureKind kind;

  /// One line, safe to show.
  final String? message;

  /// Developer-facing extra: SQL, the offending field, the status code.
  final String? detail;

  final Object? cause;

  /// A sentence for the UI. Never leaks [detail].
  String get userMessage => switch (kind) {
    FailureKind.notFound => message ?? 'That record no longer exists',
    FailureKind.write => message ?? 'Could not save. Nothing was changed',
    FailureKind.network =>
      message ?? 'No connection. Your data is safe on this phone',
    FailureKind.conflict => message ?? 'This changed on another device',
    FailureKind.rejected => message ?? 'That change could not be applied',
    FailureKind.permission => message ?? 'Permission needed',
    FailureKind.platform => message ?? 'Not supported on this device',
    FailureKind.unknown => message ?? 'Something went wrong',
  };

  Failure withDetail(String value) =>
      Failure(kind, message: message, detail: value, cause: cause);

  @override
  String toString() => detail == null
      ? 'Failure(${kind.name}${message == null ? '' : ': $message'})'
      : 'Failure(${kind.name}: $message | $detail)';
}
