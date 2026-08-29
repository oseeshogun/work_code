import 'dart:math';

import 'package:codedutravail/core/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Ad slot that randomly shows a Google banner ad 40% of the time and the
/// given [promo] widget 60% of the time. Falls back to [promo] if the banner
/// fails to load. The choice is stable for the lifetime of the widget.
class RandomAdSlot extends HookWidget {
  const RandomAdSlot({super.key, required this.promo});

  /// The in-house promo shown 60% of the time (and as banner fallback).
  final Widget promo;

  @override
  Widget build(BuildContext context) {
    final showPromo = useMemoized(() => Random().nextDouble() < 0.6);
    final bannerAd = useState<BannerAd?>(null);
    final bannerFailed = useState(false);

    useEffect(() {
      if (showPromo) {
        return null;
      }
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
    }, [showPromo]);

    final ad = bannerAd.value;
    if (showPromo || bannerFailed.value) {
      return promo;
    }
    if (ad == null) {
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
