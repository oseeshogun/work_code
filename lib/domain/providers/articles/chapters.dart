import 'package:codedutravail/data/repositories/chapter_repository_impl.dart';
import 'package:codedutravail/domain/entities/chapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapters.g.dart';

@riverpod
Stream<List<ChapterEntity>> chapters(Ref ref, int titleNumber) {
  final repository = ref.watch(chapterRepositoryProvider);
  return repository.streamByTitle(titleNumber);
}
