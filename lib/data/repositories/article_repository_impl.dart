import 'package:codedutravail/data/local/database.dart';
import 'package:codedutravail/data/local/tables/articles.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:codedutravail/domain/repositories/artitle_repository.dart';
import 'package:diacritic/diacritic.dart';
import 'package:drift/drift.dart';
import 'package:string_extensions/string_extensions.dart';
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
      (entry) => ArticlesCompanion.insert(
        value: entry.text,
        number: Value.absentIfNull(entry.number),
        valueSlug: removeDiacritics(entry.text.toLowerCase().toSlug),
      ),
    );
    return batch((batch) {
      batch.insertAllOnConflictUpdate(articles, rows);
    });
  }

  @override
  Stream<ArticleEntity> streamArticleById(int id) {
    return (select(articles)..where((t) => t.number.equals(id))).map((row) => row.toEntity()).watchSingle();
  }

  @override
  Future<ArticleEntity> getArticleById(int id) async {
    final result = await (select(articles)..where((t) => t.number.equals(id))).map((row) => row.toEntity()).getSingle();
    return result;
  }

  @override
  Stream<int> articlesCount() {
    final count = articles.number.count();
    return (selectOnly(articles)..addColumns([count])).map((row) => row.read(count) ?? 0).watchSingle();
  }

  @override
  Stream<List<ArticleEntity>> streamAll() {
    return (select(articles)).map((row) => row.toEntity()).watch();
  }

  @override
  Future<void> toggleArticleToFavorite(int articleNumber) {
    return (update(articles)..where(
      (t) => t.number.equals(articleNumber),
    )).write(ArticlesCompanion.custom(isFavorite: articles.isFavorite.not()));
  }

  @override
  Stream<List<ArticleEntity>> streamFavoriteArticles() {
    return (select(articles)..where((t) => t.isFavorite.equals(true))).map((row) => row.toEntity()).watch();
  }
}

extension ArticleToEntity on Article {
  ArticleEntity toEntity() {
    return ArticleEntity(number: number, text: value, slug: valueSlug, isFavorite: isFavorite);
  }
}
