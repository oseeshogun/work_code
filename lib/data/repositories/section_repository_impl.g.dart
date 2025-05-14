// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_repository_impl.dart';

// ignore_for_file: type=lint
mixin _$SectionRepositoryImplMixin on DatabaseAccessor<AppDatabase> {
  $TitlesTable get titles => attachedDatabase.titles;
  $ChaptersTable get chapters => attachedDatabase.chapters;
  $SectionsTable get sections => attachedDatabase.sections;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectionRepositoryHash() => r'ce6dbdb72e5f46d6b91dd5b1a6871cb3faab336b';

/// See also [sectionRepository].
@ProviderFor(sectionRepository)
final sectionRepositoryProvider = Provider<SectionRepository>.internal(
  sectionRepository,
  name: r'sectionRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sectionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SectionRepositoryRef = ProviderRef<SectionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
