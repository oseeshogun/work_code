import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'article_of_day_visibility.g.dart';

/// Key used to store the article of the day visibility in SharedPreferences
const String _articleOfDayVisibilityKey = 'article_of_day_hidden_date';

/// Provider that tracks whether the Article of the Day should be visible
@riverpod
class ArticleOfDayVisibility extends _$ArticleOfDayVisibility {
  @override
  Future<bool> build() async {
    return _isArticleOfDayVisible();
  }
  
  /// Checks if the Article of the Day should be visible
  Future<bool> _isArticleOfDayVisible() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0]; // Get current date in YYYY-MM-DD format
    final hiddenDate = prefs.getString(_articleOfDayVisibilityKey);
    
    // If the hidden date is today, the article should be hidden
    return hiddenDate != today;
  }
  
  /// Hides the Article of the Day for the current day
  Future<void> hideForToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    // Save the current date as the hidden date
    await prefs.setString(_articleOfDayVisibilityKey, today);
    
    // Update the state
    state = const AsyncValue.data(false);
  }
  
  /// Shows the Article of the Day (even if it was hidden today)
  Future<void> show() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Remove the hidden date
    await prefs.remove(_articleOfDayVisibilityKey);
    
    // Update the state
    state = const AsyncValue.data(true);
  }
}
