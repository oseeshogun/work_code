import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:codedutravail/core/router/router.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:codedutravail/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  await FirebaseCrashlytics.instance.setUserIdentifier('anonymous_user');

  await FirebaseAnalytics.instance.logAppOpen();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? AndroidDebugProvider(debugToken: "98640F4B-D45F-4FB2-96E6-A6F92479B521")
        : AndroidPlayIntegrityProvider(),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final analytics = ref.watch(analyticsProvider);

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

// TODO: Future Features roadmap
//
// 🤖 AI ENHANCEMENTS
// - TODO : Contextual Chat: "Ask Assistant" button on Article Screen for specific content questions.
// - TODO : AI Summary: One-tap button to summarize long legal articles.
// - TODO : Voice Commands: Voice-to-text questions for hands-free navigation.
// - TODO : Smart Search: Semantic search for natural language queries (e.g., "What happens if I'm fired?").
//
// 🔍 SEARCH & NAVIGATION
// - TODO : Interactive Table of Contents: Hierarchical tree view to browse the Code structurally.
// - TODO : Recent History: "Recently Viewed" section on home screen.
// - TODO : Advanced Filtering: Filter by Active/Repealed or specific legal domains.
//
// 📱 USER EXPERIENCE (UX)
// - TODO : Annotations & Highlights: Highlight sentences and save to "My Notes".
// - TODO : Customizable Reader: Adjust font size, spacing, and weight.

