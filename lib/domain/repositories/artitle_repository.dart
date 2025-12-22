import 'package:codedutravail/domain/entities/article.dart';

mixin ArticleRepository {
  Future<void> insertAll(List<ArticleEntity> entries);

  Stream<List<ArticleEntity>> streamAll();

  Stream<ArticleEntity> streamArticleById(int id);

  Future<ArticleEntity> getArticleById(int id);

  Stream<int> articlesCount();

  Future<void> toggleArticleToFavorite(int articleNumber);
}
