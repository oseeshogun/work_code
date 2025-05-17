import 'dart:math';

import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'article_of_the_day.g.dart';

/// Provider that returns a random article number for the "Article of the Day"
@riverpod
Future<int> articleOfTheDayNumber(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateTime.now().toIso8601String().split('T')[0]; // Get current date in YYYY-MM-DD format
  final lastUpdateDate = prefs.getString('article_of_day_date');
  final savedArticleNumber = prefs.getInt('article_of_day_number');
  
  // If we already have an article for today, return it
  if (lastUpdateDate == today && savedArticleNumber != null) {
    return savedArticleNumber;
  }
  
  // Otherwise, generate a new random article number
  final random = Random();
  final articleNumber = random.nextInt(344) + 1; // Random number between 1 and 344
  
  // Save the new article number and date
  await prefs.setString('article_of_day_date', today);
  await prefs.setInt('article_of_day_number', articleNumber);
  
  return articleNumber;
}

/// Provider that returns the Article of the Day
@riverpod
Future<ArticleEntity> articleOfTheDay(Ref ref) async {
  final articleNumber = await ref.watch(articleOfTheDayNumberProvider.future);
  // Get the article repository directly
  final repository = ref.watch(articleRepositoryProvider);
  // Get the article by ID
  return await repository.getArticleById(articleNumber);
}
