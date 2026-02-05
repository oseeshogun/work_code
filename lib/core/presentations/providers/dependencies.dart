import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

part 'dependencies.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> prefs(Ref ref) => SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
FirebaseAnalytics analytics(Ref ref) {
  return FirebaseAnalytics.instance;
}

@Riverpod(keepAlive: true)
FirebaseAnalyticsObserver analyticsObserver(Ref ref) {
  return FirebaseAnalyticsObserver(analytics: ref.watch(analyticsProvider));
}

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}
