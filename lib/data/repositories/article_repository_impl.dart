import 'package:codedutravail/core/data/database.dart';
import 'package:codedutravail/data/tables/articles.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:codedutravail/domain/repositories/artitle_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ArticleRepository articleRepository(Ref ref) {
  final db = ref.watch(dbProvider);

  return ArticleRepositoryImpl(db);
}

@DriftAccessor(tables: [Articles])
class ArticleRepositoryImpl extends DatabaseAccessor<AppDatabase> with _$ArticleRepositoryImplMixin, ArticleRepository {
  ArticleRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> insertAll(List<ArticleEntity> entries) {
    final rows = entries.map(
      (entry) => ArticlesCompanion.insert(value: entry.text, number: Value.absentIfNull(entry.number)),
    );
    return batch((batch) {
      batch.insertAllOnConflictUpdate(articles, rows);
    });
  }

  @override
  Stream<ArticleEntity> streamArticleById(int id) {
    return (select(articles)..where(
      (t) => t.number.equals(id),
    )).watchSingle().map((value) => ArticleEntity(number: value.number, text: value.value));
  }

  @override
  Stream<List<ArticleEntity>> streamArticles(List<int> ids) {
    return (select(articles)..where(
      (t) => t.number.isIn(ids),
    )).watch().map((values) => values.map((value) => ArticleEntity(number: value.number, text: value.value)).toList());
  }

  @override
  Stream<List<ArticleEntity>> search(String query) {
    final lowerQuery = query.toLowerCase();
    return (select(articles)..where(
      (t) => t.value.lower().contains(lowerQuery),
    )).watch().map((values) => values.map((value) => ArticleEntity(number: value.number, text: value.value)).toList());
  }

  @override
  Future<ArticleEntity> getArticleById(int id) async {
    final result = await (select(articles)..where((t) => t.number.equals(id))).getSingle();
    return ArticleEntity(number: result.number, text: result.value);
  }
}
