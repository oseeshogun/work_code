import 'package:firebase_analytics/firebase_analytics.dart';

/// A service class to handle Firebase Analytics events throughout the app
class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  /// Log when a user views an article
  Future<void> logArticleView(int articleNumber, String articleTitle) async {
    await _analytics.logEvent(
      name: 'article_view',
      parameters: {
        'article_number': articleNumber,
        'article_title': articleTitle,
      },
    );
  }

  /// Log when a user searches for content
  Future<void> logSearch(String searchTerm) async {
    await _analytics.logSearch(searchTerm: searchTerm);
  }

  /// Log when a user clicks on external links
  Future<void> logExternalLinkClick(String linkType, String url) async {
    await _analytics.logEvent(
      name: 'external_link_click',
      parameters: {
        'link_type': linkType,
        'url': url,
      },
    );
  }

  /// Log when a user toggles between light and dark mode
  Future<void> logThemeChange(String theme) async {
    await _analytics.logEvent(
      name: 'theme_change',
      parameters: {
        'theme': theme,
      },
    );
  }

  /// Log when a user uses text-to-speech feature
  Future<void> logTextToSpeech(String content) async {
    await _analytics.logEvent(
      name: 'text_to_speech',
      parameters: {
        'content_length': content.length,
      },
    );
  }

  /// Log when a user shares content
  Future<void> logShare(String contentType, String contentId) async {
    await _analytics.logShare(
      contentType: contentType,
      itemId: contentId,
      method: 'app',
    );
  }

  /// Log a custom event
  Future<void> logCustomEvent(String eventName, Map<String, Object> parameters) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
