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
    return (select(articles)..where(
      (t) => t.number.equals(id),
    )).watchSingle().map((value) => ArticleEntity(number: value.number, text: value.value, slug: value.valueSlug));
  }

  @override
  Future<ArticleEntity> getArticleById(int id) async {
    final result = await (select(articles)..where((t) => t.number.equals(id))).getSingle();
    return ArticleEntity(number: result.number, text: result.value, slug: result.valueSlug);
  }

  @override
  Stream<int> articlesCount() {
    final count = articles.number.count();
    return (selectOnly(articles)..addColumns([count])).map((row) => row.read(count) ?? 0).watchSingle();
  }

  @override
  Stream<List<ArticleEntity>> streamAll() {
    return (select(articles)).watch().map(
      (values) =>
          values.map((value) => ArticleEntity(number: value.number, text: value.value, slug: value.valueSlug)).toList(),
    );
  }
}
