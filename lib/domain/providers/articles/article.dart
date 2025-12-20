import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article.g.dart';

@riverpod
Stream<ArticleEntity> article(Ref ref, int number) {
  final repository = ref.watch(articleRepositoryProvider);
  return repository.streamArticleById(number);
}

@riverpod
Stream<int> articleCount(Ref ref) {
  final repository = ref.watch(articleRepositoryProvider);
  return repository.articlesCount();
}
