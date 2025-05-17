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
  /// Initialize the Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
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
