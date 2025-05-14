import 'package:codedutravail/domain/entities/chapter.dart';

mixin ChapterRepository {
  Future<void> insertAll(List<ChapterEntity> entries);

  Stream<List<ChapterEntity>> streamByTitle(int titleNumber);
}
