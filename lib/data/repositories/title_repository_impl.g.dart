// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_repository_impl.dart';

// ignore_for_file: type=lint
mixin _$TitleRepositoryImplMixin on DatabaseAccessor<AppDatabase> {
  $TitlesTable get titles => attachedDatabase.titles;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$titleRepositoryHash() => r'216a25b6b1fd3e251cf7c258ae53ca575e8a12b0';

/// See also [titleRepository].
@ProviderFor(titleRepository)
final titleRepositoryProvider = Provider<TitleRepository>.internal(
  titleRepository,
  name: r'titleRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$titleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TitleRepositoryRef = ProviderRef<TitleRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
