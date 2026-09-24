import 'package:codedutravail/core/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Ad slot that shows a Google banner ad, hiding itself if the ad fails to
/// load.
class RandomAdSlot extends HookWidget {
  const RandomAdSlot({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerAd = useState<BannerAd?>(null);
    final bannerFailed = useState(false);

    useEffect(() {
      final ad = BannerAd(
        adUnitId: Env.articleBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) => bannerAd.value = ad as BannerAd,
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            bannerFailed.value = true;
          },
        ),
      )..load();
      return ad.dispose;
    }, const []);

    final ad = bannerAd.value;
    if (bannerFailed.value || ad == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: SizedBox(
          width: ad.size.width.toDouble(),
          height: ad.size.height.toDouble(),
          child: AdWidget(ad: ad),
        ),
      ),
    );
  }
}
