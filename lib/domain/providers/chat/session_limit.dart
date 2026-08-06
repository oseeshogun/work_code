import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_limit.g.dart';

const int maxSessionsPerDay = 2;
const String _prefKeyDate = 'ai_chat_sessions_date';
const String _prefKeyCount = 'ai_chat_sessions_used';

String _today() {
  final now = DateTime.now();
  return '${now.year}-${now.month}-${now.day}';
}

@riverpod
class SessionLimit extends _$SessionLimit {
  @override
  Future<int> build() async {
    final prefs = await ref.watch(prefsProvider.future);
    if (prefs.getString(_prefKeyDate) != _today()) return 0;
    return prefs.getInt(_prefKeyCount) ?? 0;
  }

  /// Consumes one session for today. Sets state directly (never
  /// `invalidateSelf`) so the provider doesn't cycle through a loading
  /// state that would remount dependent widgets and risk a double call.
  Future<void> consumeSession() async {
    final prefs = await ref.read(prefsProvider.future);
    final today = _today();
    final current = prefs.getString(_prefKeyDate) == today ? (prefs.getInt(_prefKeyCount) ?? 0) : 0;
    final next = current + 1;

    await prefs.setString(_prefKeyDate, today);
    await prefs.setInt(_prefKeyCount, next);
    state = AsyncValue.data(next);
  }
}
