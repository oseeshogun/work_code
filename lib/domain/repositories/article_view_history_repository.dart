import 'package:codedutravail/domain/entities/viewed_article.dart';

mixin ArticleViewHistoryRepository {
  Future<void> recordView(int articleNumber);

  Stream<List<ViewedArticleEntity>> streamRecentlyViewed({int limit = 30});
}
