import 'package:codedutravail/presentation/home/screens/article_screen.dart';
import 'package:codedutravail/presentation/home/screens/home_screen.dart';
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
  Widget build(BuildContext context, GoRouterState state) => const ArticleScreen();
}
