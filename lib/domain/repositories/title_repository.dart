import 'package:codedutravail/domain/entities/title.dart';

mixin TitleRepository {
  Future<void> insertAll(List<TitleEntity> entries);

  Stream<List<TitleEntity>> streamAll();
}
