import 'package:codedutravail/core/config/env.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isLoadingAd = false;

  bool get isAdAvailable => _rewardedAd != null;

  void loadAd() {
    if (_isLoadingAd || isAdAvailable) return;
    _isLoadingAd = true;
    RewardedAd.load(
      adUnitId: Env.aiRewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoadingAd = false;
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (_) {
          _isLoadingAd = false;
        },
      ),
    );
  }

  /// Shows the cached ad if one is ready. [onRewardEarned] fires only once the
  /// user has watched enough of the ad to earn the reward. If no ad is ready
  /// yet, [onAdUnavailable] fires immediately and a new one starts loading.
  void showAd({required void Function() onRewardEarned, void Function()? onAdUnavailable}) {
    final ad = _rewardedAd;
    if (ad == null) {
      onAdUnavailable?.call();
      loadAd();
      return;
    }

    _rewardedAd = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadAd();
      },
    );

    ad.show(onUserEarnedReward: (_, _) => onRewardEarned());
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
