import 'package:codedutravail/core/config/ads_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewarded_add.g.dart';

@riverpod
class RewardedAdNotifier extends _$RewardedAdNotifier {
  @override
  RewardedAd? build() {
    init();
    return null;
  }

  void init() {
    RewardedAd.load(
      adUnitId: AdsConfig.rewardInterstitialAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
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
