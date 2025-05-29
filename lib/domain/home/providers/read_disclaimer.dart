import 'package:codedutravail/core/presentations/providers/preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_disclaimer.g.dart';

@riverpod
AsyncValue<bool> readDisclaimer(Ref ref) {
  final prefsAsync = ref.watch(prefsProvider);

  return prefsAsync.when(
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    loading: () => AsyncValue.loading(),
    data: (prefs) => AsyncValue.data(prefs.getBool('read_disclaimer') ?? false),
  );
}
