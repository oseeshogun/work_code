import 'package:codedutravail/core/data/database.dart';
import 'package:codedutravail/data/tables/sections.dart';
import 'package:codedutravail/domain/entities/section.dart';
import 'package:codedutravail/domain/repositories/section_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'section_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SectionRepository sectionRepository(Ref ref) {
  final db = ref.watch(dbProvider);

  return SectionRepositoryImpl(db);
}

@DriftAccessor(tables: [Sections])
class SectionRepositoryImpl extends DatabaseAccessor<AppDatabase> with _$SectionRepositoryImplMixin, SectionRepository {
  SectionRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> insertAll(List<SectionEntity> entries) {
    final rows = entries.map(
      (entry) => SectionsCompanion.insert(
        articles: entry.articles,
        value: entry.text,
        number: entry.number,
        chapterId: entry.chapterNumber,
        titleId: entry.titleNumber,
      ),
    );
    return batch((batch) {
      batch.insertAllOnConflictUpdate(sections, rows);
    });
  }

  @override
  Stream<List<SectionEntity>> streamByChapter(int titleNumber, int chapterNumber) {
    return (select(sections)
      ..where((t) => t.titleId.equals(titleNumber) & t.chapterId.equals(chapterNumber))).watch().asyncMap(
      (values) =>
          values
              .map(
                (value) => SectionEntity(
                  number: value.number,
                  text: value.value,
                  chapterNumber: value.chapterId,
                  titleNumber: value.titleId,
                  articles: value.articles,
                ),
              )
              .toList(),
    );
  }
}
