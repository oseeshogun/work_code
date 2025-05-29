import 'package:codedutravail/core/services/ads/ads_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_ad.g.dart';

@riverpod
class BannerAdNotifier extends _$BannerAdNotifier {
  @override
  BannerAd build() {
    return BannerAd(
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
  }
}
