// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
  $articleRoute,
  $infoRoute,
  $aboutRoute,
  $aiSearchRoute,
];

RouteBase get $homeRoute =>
    GoRouteData.$route(path: '/', factory: $HomeRouteExtension._fromState);

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $articleRoute => GoRouteData.$route(
  path: '/article/:number',

  factory: $ArticleRouteExtension._fromState,
);

extension $ArticleRouteExtension on ArticleRoute {
  static ArticleRoute _fromState(GoRouterState state) =>
      ArticleRoute(int.parse(state.pathParameters['number']!)!);

  String get location => GoRouteData.$location(
    '/article/${Uri.encodeComponent(number.toString())}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $infoRoute =>
    GoRouteData.$route(path: '/info', factory: $InfoRouteExtension._fromState);

extension $InfoRouteExtension on InfoRoute {
  static InfoRoute _fromState(GoRouterState state) => InfoRoute();

  String get location => GoRouteData.$location('/info');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aboutRoute => GoRouteData.$route(
  path: '/about',

  factory: $AboutRouteExtension._fromState,
);

extension $AboutRouteExtension on AboutRoute {
  static AboutRoute _fromState(GoRouterState state) => AboutRoute();

  String get location => GoRouteData.$location('/about');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aiSearchRoute => GoRouteData.$route(
  path: '/ai_search',

  factory: $AiSearchRouteExtension._fromState,
);

extension $AiSearchRouteExtension on AiSearchRoute {
  static AiSearchRoute _fromState(GoRouterState state) => AiSearchRoute();

  String get location => GoRouteData.$location('/ai_search');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
