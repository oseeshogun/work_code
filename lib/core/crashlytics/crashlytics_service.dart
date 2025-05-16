import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// A service class to handle Firebase Crashlytics throughout the app
class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;

  CrashlyticsService(this._crashlytics);

  /// Record a non-fatal error
  Future<void> recordError(dynamic exception, StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Log a message to Crashlytics (useful for debugging)
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  /// Set a custom key/value pair for crash reports
  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Set user identifier for crash reports
  Future<void> setUserIdentifier(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }

  /// Force a crash for testing Crashlytics
  void crash() {
    _crashlytics.crash();
  }

  /// Enable/disable Crashlytics data collection
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }
}
