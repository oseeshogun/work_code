import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode || kProfileMode;
  }
}

abstract class AppLogger {
  static void debug(String? value) {
    final logger = Logger(filter: _AppLogFilter());
    logger.d(value);
  }

  static void info(String? value) {
    final logger = Logger(filter: _AppLogFilter());
    logger.i(value);
  }

  static void warn(String? value) {
    final logger = Logger(filter: _AppLogFilter());
    logger.w(value);
  }

  static void error(String? value, {Object? error, StackTrace? stackTrace}) {
    final logger = Logger(filter: _AppLogFilter());
    logger.e(value, stackTrace: stackTrace, error: error);
  }

  static void wtf(String? value, {Object? error, StackTrace? stackTrace}) {
    final logger = Logger(filter: _AppLogFilter());
    logger.f(value, stackTrace: stackTrace, error: error);
  }
}
