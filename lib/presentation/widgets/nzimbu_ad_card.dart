import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A promotional card for the Nzimbu app, shown on the home screen.
class NzimbuAdCard extends StatelessWidget {
  const NzimbuAdCard({super.key});

  static const String _url = 'https://nzimbu.oseemasuaku.com/app';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          if (await canLaunchUrlString(_url)) {
            await launchUrlString(_url, mode: LaunchMode.externalApplication);
          }
        },
        child: AspectRatio(
          aspectRatio: 1672 / 941,
          child: Image.asset('assets/images/nzimbu_ad.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
