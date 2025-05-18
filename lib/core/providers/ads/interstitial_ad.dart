import 'package:codedutravail/core/services/ads/ads_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interstitial_ad.g.dart';

@riverpod
class InterstitialAdNotifier extends _$InterstitialAdNotifier {
  @override
  InterstitialAd? build() {
    init();
    return null;
  }

  void init() {
    InterstitialAd.load(
      adUnitId: AdsConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          state = ad;

          state?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              state = null;
              // Preload next ad
              init();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              state = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          state = null;
        },
      ),
    );
  }
}
