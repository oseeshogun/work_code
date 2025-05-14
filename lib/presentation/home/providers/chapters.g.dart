// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapters.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chaptersHash() => r'17597ff2cb9b25116d988d692b7c44cde7194536';

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

/// See also [chapters].
@ProviderFor(chapters)
const chaptersProvider = ChaptersFamily();

/// See also [chapters].
class ChaptersFamily extends Family<AsyncValue<List<ChapterEntity>>> {
  /// See also [chapters].
  const ChaptersFamily();

  /// See also [chapters].
  ChaptersProvider call(int titleNumber) {
    return ChaptersProvider(titleNumber);
  }

  @override
  ChaptersProvider getProviderOverride(covariant ChaptersProvider provider) {
    return call(provider.titleNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chaptersProvider';
}

/// See also [chapters].
class ChaptersProvider extends AutoDisposeStreamProvider<List<ChapterEntity>> {
  /// See also [chapters].
  ChaptersProvider(int titleNumber)
    : this._internal(
        (ref) => chapters(ref as ChaptersRef, titleNumber),
        from: chaptersProvider,
        name: r'chaptersProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$chaptersHash,
        dependencies: ChaptersFamily._dependencies,
        allTransitiveDependencies: ChaptersFamily._allTransitiveDependencies,
        titleNumber: titleNumber,
      );

  ChaptersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.titleNumber,
  }) : super.internal();

  final int titleNumber;

  @override
  Override overrideWith(
    Stream<List<ChapterEntity>> Function(ChaptersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChaptersProvider._internal(
        (ref) => create(ref as ChaptersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        titleNumber: titleNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ChapterEntity>> createElement() {
    return _ChaptersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChaptersProvider && other.titleNumber == titleNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, titleNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChaptersRef on AutoDisposeStreamProviderRef<List<ChapterEntity>> {
  /// The parameter `titleNumber` of this provider.
  int get titleNumber;
}

class _ChaptersProviderElement
    extends AutoDisposeStreamProviderElement<List<ChapterEntity>>
    with ChaptersRef {
  _ChaptersProviderElement(super.provider);

  @override
  int get titleNumber => (origin as ChaptersProvider).titleNumber;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
