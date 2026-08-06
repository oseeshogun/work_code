import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session_limit.g.dart';

const int maxSessionsPerDay = 2;
const int bonusSessionsPerAd = 3;
const Duration bonusSessionsDuration = Duration(hours: 36);

const String _prefKeyDate = 'ai_chat_sessions_date';
const String _prefKeyCount = 'ai_chat_sessions_used';
const String _prefKeyBonusCount = 'ai_chat_bonus_sessions';
const String _prefKeyBonusExpiry = 'ai_chat_bonus_expiry';

String _today() {
  final now = DateTime.now();
  return '${now.year}-${now.month}-${now.day}';
}

class SessionLimitState {
  final int dailyUsed;
  final int bonusSessions;
  final DateTime? bonusExpiry;

  const SessionLimitState({required this.dailyUsed, required this.bonusSessions, this.bonusExpiry});

  bool get hasActiveBonus {
    final expiry = bonusExpiry;
    return expiry != null && bonusSessions > 0 && DateTime.now().isBefore(expiry);
  }

  int get dailyRemaining => (maxSessionsPerDay - dailyUsed).clamp(0, maxSessionsPerDay);

  int get bonusRemaining => hasActiveBonus ? bonusSessions : 0;

  int get remainingSessions => dailyRemaining + bonusRemaining;

  bool get isLimitReached => remainingSessions <= 0;
}

SessionLimitState _readState(SharedPreferences prefs) {
  final dailyUsed = prefs.getString(_prefKeyDate) == _today() ? (prefs.getInt(_prefKeyCount) ?? 0) : 0;
  final bonusSessions = prefs.getInt(_prefKeyBonusCount) ?? 0;
  final expiryMillis = prefs.getInt(_prefKeyBonusExpiry);
  final bonusExpiry = expiryMillis != null ? DateTime.fromMillisecondsSinceEpoch(expiryMillis) : null;
  return SessionLimitState(dailyUsed: dailyUsed, bonusSessions: bonusSessions, bonusExpiry: bonusExpiry);
}

@riverpod
class SessionLimit extends _$SessionLimit {
  @override
  Future<SessionLimitState> build() async {
    final prefs = await ref.watch(prefsProvider.future);
    return _readState(prefs);
  }

  /// Consumes one session for today: draws from the free daily allotment
  /// first, then from any active ad-earned bonus. Sets state directly (never
  /// `invalidateSelf`) so the provider doesn't cycle through a loading state
  /// that would remount dependent widgets and risk a double call.
  Future<void> consumeSession() async {
    final prefs = await ref.read(prefsProvider.future);
    final current = _readState(prefs);

    if (current.dailyRemaining > 0) {
      await prefs.setString(_prefKeyDate, _today());
      await prefs.setInt(_prefKeyCount, current.dailyUsed + 1);
    } else if (current.hasActiveBonus) {
      await prefs.setInt(_prefKeyBonusCount, current.bonusSessions - 1);
    }

    state = AsyncValue.data(_readState(prefs));
  }

  /// Grants a fresh batch of ad-earned bonus sessions, valid for
  /// [bonusSessionsDuration] from now.
  Future<void> grantBonusSessions() async {
    final prefs = await ref.read(prefsProvider.future);
    final expiry = DateTime.now().add(bonusSessionsDuration);

    await prefs.setInt(_prefKeyBonusCount, bonusSessionsPerAd);
    await prefs.setInt(_prefKeyBonusExpiry, expiry.millisecondsSinceEpoch);

    state = AsyncValue.data(_readState(prefs));
  }
}
