import 'package:codedutravail/domain/entities/article.dart';

mixin ArticleRepository {
  Future<void> insertAll(List<ArticleEntity> entries);

  Stream<ArticleEntity> streamArticleById(int id);

  Stream<List<ArticleEntity>> streamArticles(List<int> ids);

  Stream<List<ArticleEntity>> search(String query);

  Future<ArticleEntity> getArticleById(int id);
}
