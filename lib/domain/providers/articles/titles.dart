import 'package:codedutravail/data/repositories/title_repository_impl.dart';
import 'package:codedutravail/domain/entities/title.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'titles.g.dart';

@riverpod
Stream<List<TitleEntity>> titles(Ref ref) {
  final repository = ref.watch(titleRepositoryProvider);
  return repository.streamAll();
}
