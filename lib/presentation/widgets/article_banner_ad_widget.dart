import 'package:codedutravail/core/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ArticleBannerAdWidget extends HookWidget {
  const ArticleBannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerAd = useState<BannerAd?>(null);

    useEffect(() {
      final ad = BannerAd(
        adUnitId: Env.articleBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) => bannerAd.value = ad as BannerAd,
          onAdFailedToLoad: (ad, error) => ad.dispose(),
        ),
      )..load();
      return ad.dispose;
    }, const []);

    final ad = bannerAd.value;
    if (ad == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(width: ad.size.width.toDouble(), height: ad.size.height.toDouble(), child: AdWidget(ad: ad));
  }
}
