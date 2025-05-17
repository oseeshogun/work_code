import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A widget that displays a banner ad
class BannerAdWidget extends StatelessWidget {
  final BannerAd? ad;
  
  const BannerAdWidget({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    if (ad == null) {
      return const SizedBox(height: 50);
    }
    
    return SizedBox(
      width: ad!.size.width.toDouble(),
      height: ad!.size.height.toDouble(),
      child: AdWidget(ad: ad!),
    );
  }
}
