import 'package:flutter/foundation.dart';

abstract class AdsConfig {
  // Production ad units
  static const String _prodBannerAdUnitId = String.fromEnvironment('GOOGLE_MOBILE_ADS_BANNER_AD_UNIT_ID');
  static const String _prodOnStartAdUnitId = String.fromEnvironment('GOOGLE_MOBILE_ADS_ON_START_AD_UNIT_ID');
  static const String _prodInterstitialAdUnitId = String.fromEnvironment('GOOGLE_MOBILE_ADS_INTERSTITIAL_AD_UNIT_ID');
  static const String _prodRewardInterstitialAdUnitId = String.fromEnvironment('GOOGLE_MOBILE_ADS_REWARDED_INTERSTITIAL_AD_UNIT_ID');
  
  // Test ad units
  static const String _testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testOnStartAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  static const String _testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewardInterstitialAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  
  // Return the appropriate ad unit ID based on build mode
  static String get bannerAdUnitId => kDebugMode ? _testBannerAdUnitId : _prodBannerAdUnitId;
  static String get onStartAdUnitId => kDebugMode ? _testOnStartAdUnitId : _prodOnStartAdUnitId;
  static String get interstitialAdUnitId => kDebugMode ? _testInterstitialAdUnitId : _prodInterstitialAdUnitId;
  static String get rewardInterstitialAdUnitId => kDebugMode ? _testRewardInterstitialAdUnitId : _prodRewardInterstitialAdUnitId;
}