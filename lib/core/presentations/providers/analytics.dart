import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

@Riverpod(keepAlive: true)
FirebaseAnalytics analytics(Ref ref) {
  return FirebaseAnalytics.instance;
}

@Riverpod(keepAlive: true)
FirebaseAnalyticsObserver analyticsObserver(Ref ref) {
  return FirebaseAnalyticsObserver(analytics: ref.watch(analyticsProvider));
}
