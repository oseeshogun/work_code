import 'package:codedutravail/core/data/database.dart';
import 'package:codedutravail/data/tables/chapters.dart';
import 'package:codedutravail/domain/entities/chapter.dart';
import 'package:codedutravail/domain/repositories/chapter_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ChapterRepository chapterRepository(Ref ref) {
  final db = ref.watch(dbProvider);

  return ChapterRepositoryImpl(db);
}

@DriftAccessor(tables: [Chapters])
class ChapterRepositoryImpl extends DatabaseAccessor<AppDatabase> with _$ChapterRepositoryImplMixin, ChapterRepository {
  ChapterRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> insertAll(List<ChapterEntity> entries) {
    final rows = entries.map(
      (entry) => ChaptersCompanion.insert(
        articles: entry.articles,
        value: entry.text,
        number: entry.number,
        titleId: entry.titleNumber,
      ),
    );
    return batch((batch) {
      batch.insertAllOnConflictUpdate(chapters, rows);
    });
  }

  @override
  Stream<List<ChapterEntity>> streamByTitle(int titleId) {
    return (select(chapters)..where((t) => t.titleId.equals(titleId))).watch().asyncMap(
      (values) =>
          values
              .map(
                (value) => ChapterEntity(
                  number: value.number,
                  text: value.value,
                  titleNumber: value.titleId,
                  articles: value.articles,
                ),
              )
              .toList(),
    );
  }
}
