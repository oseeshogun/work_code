import 'package:codedutravail/data/repositories/section_repository_impl.dart';
import 'package:codedutravail/domain/entities/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sections.g.dart';

@riverpod
Stream<List<SectionEntity>> sections(Ref ref, int titleNumber, int chapterNumber) {
  final repository = ref.watch(sectionRepositoryProvider);
  return repository.streamByChapter(titleNumber, chapterNumber);
}
