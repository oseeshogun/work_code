import 'package:codedutravail/core/providers/analytics.dart';
import 'package:codedutravail/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:codedutravail/firebase_options.dart';

// TODO: add ads to have extra query and sessions
// TODO: no ads on first day of use

/// Initialize Firebase Crashlytics
Future<void> _initializeCrashlytics() async {
  // Enable collection of crash reports
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  
  // Set user identifiers for crash reports (optional)
  // This could be set after user login if you have user authentication
  await FirebaseCrashlytics.instance.setUserIdentifier('anonymous_user');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure Crashlytics
  await _initializeCrashlytics();

  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  // Log app open event
  await FirebaseAnalytics.instance.logAppOpen();

  // Catch Flutter errors and report to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  // Catch async errors that aren't caught by the Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final analytics = ref.watch(analyticsProvider);

    // Configure analytics collection
    analytics.setAnalyticsCollectionEnabled(true);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: router,
      builder: (context, child) => UpgradeAlert(child: child),
    );
  }
}
