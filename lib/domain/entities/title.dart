import 'package:freezed_annotation/freezed_annotation.dart';

part 'title.freezed.dart';

@freezed
abstract class TitleEntity with _$TitleEntity {
  const factory TitleEntity({required int number, required String text, required Set<int> articles}) = _TitleEntity;
}
