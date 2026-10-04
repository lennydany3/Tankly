import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'package:tankly/core/result.dart';

/// One log line.
class LogLine {
  const LogLine({
    required this.level,
    required this.tag,
    required this.message,
    this.data = const {},
    this.at,
  });

  final LogLevel level;
  final String tag;
  final String message;
  final Map<String, Object?> data;
  final DateTime? at;

  /// Never includes [data]: a value can hold an email or a token.
  @override
  String toString() {
    final stamp = (at ?? DateTime.now()).toIso8601String();
    return '${level.pad} $stamp [$tag] $message';
  }

  /// For the in-app diagnostics screen. Safe because callers pass display-safe
  /// data, never rows.
  String get verbose {
    if (data.isEmpty) return toString();
    final pairs = data.entries.map((e) => '${e.key}=${e.value}').join(' ');
    return '$toString $pairs';
  }
}

enum LogLevel {
  debug('DEBUG'),
  info('INFO '),
  warn('WARN '),
  error('ERROR');

  const LogLevel(this.pad);
  final String pad;

  bool get isError => this == LogLevel.error;
}

/// The app's only logger.
///
/// `dart:developer` rather than `print`, so release builds do not spam logcat
/// and Crashlytics picks up errors with their stack. `[logError]` takes a
/// [Failure] rather than a string because a failure already carries a kind and a
/// user-safe message.
abstract final class AppLog {
  /// Silences debug output in a release build without touching the code paths.
  static bool debugOnly = kDebugMode;

  static void d(
    String tag,
    String message, [
    Map<String, Object?> data = const {},
  ]) => _emit(LogLevel.debug, tag, message, data);

  static void i(
    String tag,
    String message, [
    Map<String, Object?> data = const {},
  ]) => _emit(LogLevel.info, tag, message, data);

  static void w(
    String tag,
    String message, [
    Map<String, Object?> data = const {},
    Object? error,
  ]) {
    if (error != null) data = {...data, 'error': error};
    _emit(LogLevel.warn, tag, message, data);
  }

  /// [error] is logged in full; [failure] is what the rider is shown.
  static void e(
    String tag,
    String message, [
    Map<String, Object?> data = const {},
    Object? error,
    Failure? failure,
  ]) {
    var payload = data;
    if (failure != null) payload = {...payload, 'kind': failure.kind.name};
    if (error != null) payload = {...payload, 'error': error};
    if (failure?.detail != null) {
      payload = {...payload, 'detail': failure!.detail};
    }
    _emit(LogLevel.error, tag, message, payload, error: error);
  }

  static void _emit(
    LogLevel level,
    String tag,
    String message,
    Map<String, Object?> data, {
    Object? error,
  }) {
    if (level == LogLevel.debug && !debugOnly) return;
    final line = LogLine(level: level, tag: tag, message: message, data: data);
    developer.log(
      line.message,
      name: 'tankly.$tag',
      level: switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warn => 900,
        LogLevel.error => 1000,
      },
      error: error,
      stackTrace: error == null ? null : StackTrace.current,
    );
  }
}
