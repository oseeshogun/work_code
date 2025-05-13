import 'package:codedutravail/domain/entities/section.dart';

mixin SectionRepository {
  Future<void> insertAll(List<SectionEntity> entries);

  Stream<List<SectionEntity>> streamByChapter(int titleNumber, int chapterNumber);
}
