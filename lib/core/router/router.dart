import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:codedutravail/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

part 'router.g.dart';

final routerKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Get the analytics observer
  final analyticsObserver = ref.watch(analyticsObserverProvider);
  
  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: HomeRoute().location,
    routes: $appRoutes,
    observers: [analyticsObserver], // Add the analytics observer to track screen views
    redirect: (context, state) {
      // Log page views with custom parameters
      FirebaseAnalytics.instance.logScreenView(
        screenName: state.matchedLocation,
        screenClass: state.matchedLocation.split('/').first,
      );
      return null;
    },
  );
}
