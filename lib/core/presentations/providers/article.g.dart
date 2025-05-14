// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleHash() => r'153a0bc742dce7224934a101a3e2677809d2fedb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [article].
@ProviderFor(article)
const articleProvider = ArticleFamily();

/// See also [article].
class ArticleFamily extends Family<AsyncValue<ArticleEntity>> {
  /// See also [article].
  const ArticleFamily();

  /// See also [article].
  ArticleProvider call(int number) {
    return ArticleProvider(number);
  }

  @override
  ArticleProvider getProviderOverride(covariant ArticleProvider provider) {
    return call(provider.number);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'articleProvider';
}

/// See also [article].
class ArticleProvider extends AutoDisposeStreamProvider<ArticleEntity> {
  /// See also [article].
  ArticleProvider(int number)
    : this._internal(
        (ref) => article(ref as ArticleRef, number),
        from: articleProvider,
        name: r'articleProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$articleHash,
        dependencies: ArticleFamily._dependencies,
        allTransitiveDependencies: ArticleFamily._allTransitiveDependencies,
        number: number,
      );

  ArticleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
  }) : super.internal();

  final int number;

  @override
  Override overrideWith(
    Stream<ArticleEntity> Function(ArticleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArticleProvider._internal(
        (ref) => create(ref as ArticleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ArticleEntity> createElement() {
    return _ArticleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleProvider && other.number == number;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArticleRef on AutoDisposeStreamProviderRef<ArticleEntity> {
  /// The parameter `number` of this provider.
  int get number;
}

class _ArticleProviderElement
    extends AutoDisposeStreamProviderElement<ArticleEntity>
    with ArticleRef {
  _ArticleProviderElement(super.provider);

  @override
  int get number => (origin as ArticleProvider).number;
}

String _$articleCountHash() => r'd9b18f2a6aa97d7aee048c8d88a3bf8cdb1c2f11';

/// See also [articleCount].
@ProviderFor(articleCount)
final articleCountProvider = AutoDisposeStreamProvider<int>.internal(
  articleCount,
  name: r'articleCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$articleCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleCountRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
