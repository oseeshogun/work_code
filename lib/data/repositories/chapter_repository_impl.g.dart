// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_repository_impl.dart';

// ignore_for_file: type=lint
mixin _$ChapterRepositoryImplMixin on DatabaseAccessor<AppDatabase> {
  $TitlesTable get titles => attachedDatabase.titles;
  $ChaptersTable get chapters => attachedDatabase.chapters;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chapterRepositoryHash() => r'706738495c03af48f3086c248e4e3285bca37eed';

/// See also [chapterRepository].
@ProviderFor(chapterRepository)
final chapterRepositoryProvider = Provider<ChapterRepository>.internal(
  chapterRepository,
  name: r'chapterRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chapterRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChapterRepositoryRef = ProviderRef<ChapterRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
