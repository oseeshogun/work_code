import 'dart:math';

import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'article_of_the_day.g.dart';

/// Key used to store the article of the day visibility in SharedPreferences
const String _articleOfDayVisibilityKey = 'article_of_day_hidden_date';

@riverpod
Future<int> articleOfTheDayNumber(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateTime.now().toIso8601String().split('T')[0]; // Get current date in YYYY-MM-DD format
  final lastUpdateDate = prefs.getString('article_of_day_date');
  final savedArticleNumber = prefs.getInt('article_of_day_number');

  if (lastUpdateDate == today && savedArticleNumber != null) {
    return savedArticleNumber;
  }

  final random = Random();
  final articleNumber = random.nextInt(344) + 1;

  await prefs.setString('article_of_day_date', today);
  await prefs.setInt('article_of_day_number', articleNumber);

  return articleNumber;
}

@riverpod
Future<ArticleEntity> articleOfTheDay(Ref ref) async {
  final articleNumber = await ref.watch(articleOfTheDayNumberProvider.future);
  final repository = ref.watch(articleRepositoryProvider);
  return await repository.getArticleById(articleNumber);
}

@riverpod
class ArticleOfDayVisibility extends _$ArticleOfDayVisibility {
  @override
  Future<bool> build() async {
    return _isArticleOfDayVisible();
  }

  Future<bool> _isArticleOfDayVisible() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final hiddenDate = prefs.getString(_articleOfDayVisibilityKey);

    return hiddenDate != today;
  }

  Future<void> hideForToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    await prefs.setString(_articleOfDayVisibilityKey, today);
    state = const AsyncValue.data(false);
  }

  Future<void> show() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_articleOfDayVisibilityKey);
    state = const AsyncValue.data(true);
  }
}
