import 'dart:io';

/// Platform-aware store links.
///
/// Apple rejects apps whose iOS binary surfaces Google Play links/branding
/// (Guideline 2.3.10), so these URLs must never leak across platforms.
class StoreUrls {
  StoreUrls._();

  static const String _packageName = 'com.oseemasuaku.codedutravail';
  static const String _androidUrl = 'https://play.google.com/store/apps/details?id=$_packageName';
  static const String _iosUrl = 'https://apps.apple.com/us/app/code-du-travail-de-la-rdc/id6816248588';

  /// The App Store / Play Store link for the current platform.
  static String get current => Platform.isIOS ? _iosUrl : _androidUrl;
}
