import 'package:codedutravail/core/services/ads/ads_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_service.g.dart';

/// Provider for the ads service
@riverpod
AdsService adsService(Ref ref) {
  return AdsService();
}

/// Service for managing ads
class AdsService {
  // Keep track of the loaded interstitial ad
  InterstitialAd? _interstitialAd;

  /// Initialize the Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  /// Load an interstitial ad
  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdsConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          if (kDebugMode) {
            print('Interstitial ad loaded: ${ad.adUnitId}');
          }

          // Set up full screen callback
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) {
                print('Interstitial ad dismissed');
              }
              ad.dispose();
              _interstitialAd = null;
              // Preload next ad
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              if (kDebugMode) {
                print('Interstitial ad failed to show: $error');
              }
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (kDebugMode) {
            print('Interstitial ad failed to load: $error');
          }
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Show the interstitial ad if it's loaded
  /// If the ad is not loaded, it will retry after 1 second
  Future<bool> showInterstitialAd({int retryCount = 0}) async {
    if (_interstitialAd != null) {
      try {
        await _interstitialAd!.show();
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('Error showing interstitial ad: $e');
        }
        return false;
      }
    } else {
      if (kDebugMode) {
        print('Interstitial ad not loaded yet. ${retryCount > 0 ? "Retry attempt: $retryCount" : "Will retry in 1 second"}');
      }
      
      // Load the ad for next time
      loadInterstitialAd();
      
      // Retry showing the ad after 1 second, up to 3 times
      if (retryCount < 3) {
        await Future.delayed(const Duration(seconds: 1));
        return showInterstitialAd(retryCount: retryCount + 1);
      }
      
      return false;
    }
  }

  /// Load a banner ad
  Future<BannerAd?> loadBannerAd() async {
    final bannerAd = BannerAd(
      adUnitId: AdsConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('Banner ad loaded: ${ad.adUnitId}');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('Banner ad failed to load: ${ad.adUnitId}, $error');
          }
          ad.dispose();
        },
      ),
    );

    try {
      await bannerAd.load();
      return bannerAd;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banner ad: $e');
      }
      return null;
    }
  }
}
