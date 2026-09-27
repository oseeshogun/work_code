import 'package:codedutravail/data/local/database.dart';
import 'package:codedutravail/data/local/tables/article_view_history.dart';
import 'package:codedutravail/data/local/tables/articles.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart' show ArticleToEntity;
import 'package:codedutravail/domain/entities/viewed_article.dart';
import 'package:codedutravail/domain/repositories/article_view_history_repository.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_view_history_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ArticleViewHistoryRepository articleViewHistoryRepository(Ref ref) {
  final db = ref.watch(dbProvider);

  return ArticleViewHistoryRepositoryImpl(db);
}

@DriftAccessor(tables: [ArticleViewHistory, Articles])
class ArticleViewHistoryRepositoryImpl extends DatabaseAccessor<AppDatabase>
    with _$ArticleViewHistoryRepositoryImplMixin, ArticleViewHistoryRepository {
  ArticleViewHistoryRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> recordView(int articleNumber) async {
    final now = DateTime.now();
    await into(articleViewHistory).insert(
      ArticleViewHistoryCompanion.insert(articleNumber: articleNumber, viewedAt: now),
      onConflict: DoUpdate(
        (old) => ArticleViewHistoryCompanion(viewedAt: Value(now)),
        target: [articleViewHistory.articleNumber],
      ),
    );
  }

  @override
  Stream<List<ViewedArticleEntity>> streamRecentlyViewed({int limit = 30}) {
    final query =
        select(articleViewHistory).join([
            innerJoin(articles, articles.number.equalsExp(articleViewHistory.articleNumber)),
          ])
          ..orderBy([OrderingTerm.desc(articleViewHistory.viewedAt)])
          ..limit(limit);

    return query.watch().map(
      (rows) =>
          rows
              .map(
                (row) => ViewedArticleEntity(
                  article: row.readTable(articles).toEntity(),
                  viewedAt: row.readTable(articleViewHistory).viewedAt,
                ),
              )
              .toList(),
    );
  }
}
