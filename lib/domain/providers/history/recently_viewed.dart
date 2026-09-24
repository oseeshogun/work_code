import 'package:codedutravail/data/repositories/article_view_history_repository_impl.dart';
import 'package:codedutravail/domain/entities/viewed_article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recently_viewed.g.dart';

@riverpod
Stream<List<ViewedArticleEntity>> recentlyViewedArticles(Ref ref) {
  final repository = ref.watch(articleViewHistoryRepositoryProvider);
  return repository.streamRecentlyViewed(limit: 30);
}
