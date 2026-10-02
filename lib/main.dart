import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:codedutravail/core/router/router.dart';
import 'package:codedutravail/core/services/app_open_ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:codedutravail/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await MobileAds.instance.initialize();

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  await FirebaseCrashlytics.instance.setUserIdentifier('anonymous_user');

  await FirebaseAnalytics.instance.logAppOpen();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const ProviderScope(child: MyApp()));
}

/// Shows the iOS App Tracking Transparency prompt before any SDK that could
/// collect data (Firebase Analytics, AdMob) is started.
Future<void> _requestTrackingPermission() async {
  if (defaultTargetPlatform != TargetPlatform.iOS) return;
  try {
    if (await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
      // The prompt is ignored unless the app is active, so give the UI a moment.
      await Future.delayed(const Duration(milliseconds: 500));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } catch (e) {
    debugPrint('ATT request failed: $e');
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final analytics = ref.watch(analyticsProvider);

    analytics.setAnalyticsCollectionEnabled(true);

    final appOpenAdManager = useMemoized(() => AppOpenAdManager()..loadAd());
    final lifecycleState = useAppLifecycleState();

    useEffect(() {
      if (lifecycleState == AppLifecycleState.resumed) {
        appOpenAdManager.showAdIfAvailable();
      }
      _requestTrackingPermission();
      return null;
    }, [lifecycleState]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: router,
      builder: (context, child) => UpgradeAlert(
        navigatorKey: routerKey,
        onUpdate: () {
          AppOpenAdManager.notifyAppInitiatedNavigation();
          return true;
        },
        child: child,
      ),
    );
  }
}
