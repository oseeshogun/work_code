import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A slim promotional banner for the Nzimbu app.
class NzimbuBanner extends StatelessWidget {
  const NzimbuBanner({super.key});

  static const String _url = 'https://nzimbu.oseemasuaku.com/app';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrlString(_url)) {
          await launchUrlString(_url, mode: LaunchMode.externalApplication);
        }
      },
      child: AspectRatio(
        aspectRatio: 1774 / 240,
        child: Image.asset('assets/images/nzimbu_banner.png', fit: BoxFit.cover),
      ),
    );
  }
}
