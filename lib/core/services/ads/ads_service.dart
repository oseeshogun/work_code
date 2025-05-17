import 'dart:async';

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
  // Keep track of the loaded ads
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  /// Initialize the Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    
    // Preload ads
    loadInterstitialAd();
    loadRewardedAd();
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

  /// Load a rewarded ad
  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AdsConfig.rewardInterstitialAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          if (kDebugMode) {
            print('Rewarded ad loaded: ${ad.adUnitId}');
          }

          // Set up full screen callback
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) {
                print('Rewarded ad dismissed');
              }
              ad.dispose();
              _rewardedAd = null;
              // Preload next ad
              loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              if (kDebugMode) {
                print('Rewarded ad failed to show: $error');
              }
              ad.dispose();
              _rewardedAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (kDebugMode) {
            print('Rewarded ad failed to load: $error');
          }
          _rewardedAd = null;
        },
      ),
    );
  }

  /// Show the rewarded ad if it's loaded
  /// Returns a Future that completes with true if the user earned the reward
  Future<bool> showRewardedAd({Function? onRewarded, int retryCount = 0}) async {
    if (_rewardedAd != null) {
      try {
        final completer = Completer<bool>();

        // Set up the reward callback
        _rewardedAd!.setImmersiveMode(true);
        _rewardedAd!.show(
          onUserEarnedReward: (_, reward) {
            if (kDebugMode) {
              print('User earned reward: ${reward.amount} ${reward.type}');
            }
            if (onRewarded != null) {
              onRewarded();
            }
            completer.complete(true);
          },
        );

        return completer.future;
      } catch (e) {
        if (kDebugMode) {
          print('Error showing rewarded ad: $e');
        }
        return false;
      }
    } else {
      if (kDebugMode) {
        print(
          'Rewarded ad not loaded yet. ${retryCount > 0 ? "Retry attempt: $retryCount" : "Will retry in 1 second"}',
        );
      }

      // Load the ad for next time
      loadRewardedAd();

      // Retry showing the ad after 1 second, up to 3 times
      if (retryCount < 3) {
        await Future.delayed(const Duration(seconds: 1));
        return showRewardedAd(onRewarded: onRewarded, retryCount: retryCount + 1);
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
