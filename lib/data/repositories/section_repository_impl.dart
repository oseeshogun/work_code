import 'package:codedutravail/core/data/database.dart';
import 'package:codedutravail/data/tables/sections.dart';
import 'package:codedutravail/domain/entities/section.dart';
import 'package:codedutravail/domain/repositories/section_repository.dart';
import 'package:drift/drift.dart';

part 'section_repository_impl.g.dart';

@DriftAccessor(tables: [Sections])
class SectionRepositoryImpl extends DatabaseAccessor<AppDatabase> with _$SectionRepositoryImplMixin, SectionRepository {
  SectionRepositoryImpl(super.attachedDatabase);

  @override
  Future<void> insertAll(List<SectionEntity> entries) {
    final rows = entries.map(
      (entry) =>
          SectionsCompanion.insert(
            articles: entry.articles,
            value: entry.text,
            number: Value.absentIfNull(entry.number),
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
      ..where((t) => t.titleId.equals(titleNumber) & t.chapterId.equals(chapterNumber)))
        .watch()
        .asyncMap(
          (values) =>
              values
                  .map((value) => SectionEntity(
                        number: value.number,
                        text: value.value,
                        chapterNumber: value.chapterId,
                        titleNumber: value.titleId,
                        articles: value.articles,
                      ))
                  .toList(),
        );
  }
}
