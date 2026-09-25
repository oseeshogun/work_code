import 'dart:io';

abstract class Env {
  static const String _articleBannerAdUnitIdAndroid = String.fromEnvironment('articleBannerAdUnitIdAndroid');
  static const String _articleBannerAdUnitIdIos = String.fromEnvironment('articleBannerAdUnitIdIos');
  static const String _appOpenAdUnitIdAndroid = String.fromEnvironment('appOpenAdUnitIdAndroid');
  static const String _appOpenAdUnitIdIos = String.fromEnvironment('appOpenAdUnitIdIos');

  static String get articleBannerAdUnitId => Platform.isIOS ? _articleBannerAdUnitIdIos : _articleBannerAdUnitIdAndroid;

  static String get appOpenAdUnitId => Platform.isIOS ? _appOpenAdUnitIdIos : _appOpenAdUnitIdAndroid;
}
