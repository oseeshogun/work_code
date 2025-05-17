import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A widget that displays a native banner ad
class NativeBannerAdWidget extends StatefulWidget {
  final NativeAd? ad;
  
  const NativeBannerAdWidget({
    super.key,
    required this.ad,
  });

  @override
  State<NativeBannerAdWidget> createState() => _NativeBannerAdWidgetState();
}

class _NativeBannerAdWidgetState extends State<NativeBannerAdWidget> {
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.ad != null) {
      _isAdLoaded = true;
    }
  }

  @override
  void dispose() {
    widget.ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || widget.ad == null) {
      return const SizedBox(height: 80);
    }
    
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: AdWidget(ad: widget.ad!),
    );
  }
}
