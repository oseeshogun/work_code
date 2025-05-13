import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';

@freezed
abstract class ChapterEntity with _$ChapterEntity {
  const factory ChapterEntity({
    required int number,
    required String text,
    required int titleNumber,
    required Set<int> articles,
  }) = _ChapterEntity;
}
