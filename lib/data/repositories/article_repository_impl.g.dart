// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_repository_impl.dart';

// ignore_for_file: type=lint
mixin _$ArticleRepositoryImplMixin on DatabaseAccessor<AppDatabase> {
  $ArticlesTable get articles => attachedDatabase.articles;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleRepositoryHash() => r'334dc8841e07b21bb64f6808713bfa149ac91833';

/// See also [articleRepository].
@ProviderFor(articleRepository)
final articleRepositoryProvider = Provider<ArticleRepository>.internal(
  articleRepository,
  name: r'articleRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleRepositoryRef = ProviderRef<ArticleRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
