import 'package:codedutravail/data/local/database.dart';
import 'package:codedutravail/data/repositories/article_view_history_repository_impl.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ArticleViewHistoryRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = ArticleViewHistoryRepositoryImpl(db);
    await db
        .into(db.articles)
        .insert(ArticlesCompanion.insert(number: const Value(1), value: 'Article text', valueSlug: 'slug'));
  });

  tearDown(() async {
    await db.close();
  });

  test('recordView upserts instead of inserting duplicate rows', () async {
    await repository.recordView(1);
    await repository.recordView(1);

    final rows = await db.select(db.articleViewHistory).get();
    expect(rows, hasLength(1));
  });

  test('recordView updates viewedAt to the latest view', () async {
    await repository.recordView(1);
    final firstViewedAt = (await db.select(db.articleViewHistory).getSingle()).viewedAt;

    // drift stores DateTime columns as unix-epoch seconds by default, so the
    // delay must cross a full second boundary for the two views to differ.
    await Future.delayed(const Duration(seconds: 1));
    await repository.recordView(1);
    final secondViewedAt = (await db.select(db.articleViewHistory).getSingle()).viewedAt;

    expect(secondViewedAt.isAfter(firstViewedAt), isTrue);
  });

  test('streamRecentlyViewed orders by most recently viewed first', () async {
    await db
        .into(db.articles)
        .insert(ArticlesCompanion.insert(number: const Value(2), value: 'Second article', valueSlug: 'slug2'));

    await repository.recordView(1);
    await Future.delayed(const Duration(seconds: 1));
    await repository.recordView(2);

    final entries = await repository.streamRecentlyViewed().first;

    expect(entries.map((e) => e.article.number).toList(), [2, 1]);
  });
}
