import 'package:codedutravail/core/services/analytics_service.dart';
import 'package:codedutravail/core/services/crashlytics_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

// Provider for the Analytics Service
@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  final analytics = FirebaseAnalytics.instance;
  return AnalyticsService(analytics);
}

// Create a provider for Firebase Analytics
@Riverpod(keepAlive: true)
FirebaseAnalytics analytics(Ref ref) {
  return FirebaseAnalytics.instance;
}

// Create a provider for Firebase Analytics Observer
@Riverpod(keepAlive: true)
FirebaseAnalyticsObserver analyticsObserver(Ref ref) {
  return FirebaseAnalyticsObserver(analytics: ref.watch(analyticsProvider));
}

// Provider for the Crashlytics Service
@Riverpod(keepAlive: true)
CrashlyticsService crashlyticsService(Ref ref) {
  final crashlytics = FirebaseCrashlytics.instance;
  return CrashlyticsService(crashlytics);
}

// Create a provider for Firebase Crashlytics
@Riverpod(keepAlive: true)
FirebaseCrashlytics crashlytics(Ref ref) {
  return FirebaseCrashlytics.instance;
}
