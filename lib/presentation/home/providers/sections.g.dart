// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sections.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectionsHash() => r'f4a3695ca06b39bd090241013b906715d8931a46';

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

/// See also [sections].
@ProviderFor(sections)
const sectionsProvider = SectionsFamily();

/// See also [sections].
class SectionsFamily extends Family<AsyncValue<List<SectionEntity>>> {
  /// See also [sections].
  const SectionsFamily();

  /// See also [sections].
  SectionsProvider call(int titleNumber, int chapterNumber) {
    return SectionsProvider(titleNumber, chapterNumber);
  }

  @override
  SectionsProvider getProviderOverride(covariant SectionsProvider provider) {
    return call(provider.titleNumber, provider.chapterNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sectionsProvider';
}

/// See also [sections].
class SectionsProvider extends AutoDisposeStreamProvider<List<SectionEntity>> {
  /// See also [sections].
  SectionsProvider(int titleNumber, int chapterNumber)
    : this._internal(
        (ref) => sections(ref as SectionsRef, titleNumber, chapterNumber),
        from: sectionsProvider,
        name: r'sectionsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$sectionsHash,
        dependencies: SectionsFamily._dependencies,
        allTransitiveDependencies: SectionsFamily._allTransitiveDependencies,
        titleNumber: titleNumber,
        chapterNumber: chapterNumber,
      );

  SectionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.titleNumber,
    required this.chapterNumber,
  }) : super.internal();

  final int titleNumber;
  final int chapterNumber;

  @override
  Override overrideWith(
    Stream<List<SectionEntity>> Function(SectionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectionsProvider._internal(
        (ref) => create(ref as SectionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        titleNumber: titleNumber,
        chapterNumber: chapterNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<SectionEntity>> createElement() {
    return _SectionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectionsProvider &&
        other.titleNumber == titleNumber &&
        other.chapterNumber == chapterNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, titleNumber.hashCode);
    hash = _SystemHash.combine(hash, chapterNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SectionsRef on AutoDisposeStreamProviderRef<List<SectionEntity>> {
  /// The parameter `titleNumber` of this provider.
  int get titleNumber;

  /// The parameter `chapterNumber` of this provider.
  int get chapterNumber;
}

class _SectionsProviderElement
    extends AutoDisposeStreamProviderElement<List<SectionEntity>>
    with SectionsRef {
  _SectionsProviderElement(super.provider);

  @override
  int get titleNumber => (origin as SectionsProvider).titleNumber;
  @override
  int get chapterNumber => (origin as SectionsProvider).chapterNumber;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
