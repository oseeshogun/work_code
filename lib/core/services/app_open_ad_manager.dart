import 'package:codedutravail/core/config/env.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  static const _maxCacheDuration = Duration(hours: 4);

  AppOpenAd? _appOpenAd;
  bool _isLoadingAd = false;
  bool isShowingAd = false;
  DateTime? _appOpenLoadTime;

  bool get _isAdAvailable => _appOpenAd != null && _wasLoadTimeLessThanMaxCacheDuration();

  bool _wasLoadTimeLessThanMaxCacheDuration() {
    final loadTime = _appOpenLoadTime;
    if (loadTime == null) return false;
    return DateTime.now().difference(loadTime) < _maxCacheDuration;
  }

  void loadAd() {
    if (_isLoadingAd || _isAdAvailable) return;
    _isLoadingAd = true;
    AppOpenAd.load(
      adUnitId: Env.appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoadingAd = false;
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (_) {
          _isLoadingAd = false;
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (isShowingAd || !_isAdAvailable) {
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) => isShowingAd = true,
      onAdFailedToShowFullScreenContent: (ad, _) {
        isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
