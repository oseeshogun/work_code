import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatelessWidget {
  final BannerAd? ad;
  
  const BannerAdWidget({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ad != null,
      child: SizedBox(
        width: ad!.size.width.toDouble(),
        height: ad!.size.height.toDouble(),
        child: AdWidget(ad: ad!),
      ),
    );
  }
}
