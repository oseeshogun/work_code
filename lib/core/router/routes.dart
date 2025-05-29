import 'package:codedutravail/presentation/screens/about_work_code.dart';
import 'package:codedutravail/presentation/screens/article_screen.dart';
import 'package:codedutravail/presentation/screens/ai_search.dart';
import 'package:codedutravail/presentation/screens/home_screen.dart';
import 'package:codedutravail/presentation/screens/info_screen.dart';
import 'package:flutter/material.dart' show BuildContext, Widget;
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<ArticleRoute>(path: '/article/:number')
class ArticleRoute extends GoRouteData {
  final int number;

  ArticleRoute(this.number);

  @override
  Widget build(BuildContext context, GoRouterState state) => ArticleScreen(number: number);
}

@TypedGoRoute<InfoRoute>(path: '/info')
class InfoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const InfoScreen();
}

@TypedGoRoute<AboutRoute>(path: '/about')
class AboutRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const AboutWorkCode();
}

@TypedGoRoute<AiSearchRoute>(path: '/ai_search')
class AiSearchRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const AiSearchScreen();
}
