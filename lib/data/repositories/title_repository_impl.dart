import 'package:codedutravail/data/local/database.dart';
import 'package:codedutravail/data/local/tables/titles.dart';
import 'package:codedutravail/domain/entities/title.dart';
import 'package:codedutravail/domain/repositories/title_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'title_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TitleRepository titleRepository(Ref ref) {
  final db = ref.watch(dbProvider);

  return TitleRepositoryImpl(db);
}

@DriftAccessor(tables: [Titles])
class TitleRepositoryImpl extends DatabaseAccessor<AppDatabase> with _$TitleRepositoryImplMixin, TitleRepository {
  TitleRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> insertAll(List<TitleEntity> entries) {
    final rows = entries.map(
      (entry) =>
          TitlesCompanion.insert(articles: entry.articles, title: entry.text, number: Value.absentIfNull(entry.number)),
    );
    return batch((batch) {
      batch.insertAllOnConflictUpdate(titles, rows);
    });
  }

  @override
  Stream<List<TitleEntity>> streamAll() {
    return (select(titles)).watch().asyncMap(
      (values) =>
          values
              .map((value) => TitleEntity(number: value.number, text: value.title, articles: value.articles))
              .toList(),
    );
  }
}
