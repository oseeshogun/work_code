import 'package:freezed_annotation/freezed_annotation.dart';

part 'section.freezed.dart';

@freezed
abstract class SectionEntity with _$SectionEntity {
  const factory SectionEntity({
    required int number,
    required String text,
    required int chapterNumber,
    required int titleNumber,
    required Set<int> articles,
  }) = _SectionEntity;
}
