import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedutravail/core/domain/errors/session_limit_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'limits_service.g.dart';

/// Service for tracking and enforcing usage limits
@riverpod
LimitsService limitsService(Ref ref) => LimitsService();

class LimitsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MobileDeviceIdentifier _deviceIdentifier = MobileDeviceIdentifier();

  /// Maximum number of sessions allowed per day
  static const int maxSessionsPerDay = 10;

  /// Maximum number of queries allowed per chat session
  static const int maxQueriesPerChat = 15;

  /// Collection name for storing usage data
  static const String _usageCollection = 'usage';

  /// Gets the unique device identifier
  Future<String> _getDeviceId() async {
    final deviceId = await _deviceIdentifier.getDeviceId();
    return deviceId ?? DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Gets the document reference for the current device
  Future<DocumentReference> _getDeviceDocRef() async {
    final deviceId = await _getDeviceId();
    return _firestore.collection(_usageCollection).doc(deviceId);
  }

  /// Gets today's date in YYYY-MM-DD format
  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Checks if the user has reached the daily session limit, considering both regular and reward-based sessions
  Future<bool> hasReachedDailySessionLimit() async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return false;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final dailyData = data[today] as Map<String, dynamic>? ?? {};

    final sessionsCount = dailyData['sessions'] as int? ?? 0;
    final rewardSessions = dailyData['reward_sessions'] as int? ?? 0;
    final totalAllowedSessions = maxSessionsPerDay + rewardSessions;
    
    return sessionsCount >= totalAllowedSessions;
  }

  /// Checks if the user has reached the daily session limit and throws a SessionLimitException if they have
  /// This is useful when you want to handle the exception rather than just checking a boolean
  Future<void> checkDailySessionLimit() async {
    final hasReachedLimit = await hasReachedDailySessionLimit();
    if (hasReachedLimit) {
      throw SessionLimitException();
    }
  }

  /// Checks if the user has reached the query limit for the current session
  Future<bool> hasReachedQueryLimit(String sessionId) async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return false;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final dailyData = data[today] as Map<String, dynamic>? ?? {};
    final sessions = dailyData['session_data'] as Map<String, dynamic>? ?? {};

    final sessionData = sessions[sessionId] as Map<String, dynamic>? ?? {};
    final queryCount = sessionData['queries'] as int? ?? 0;

    return queryCount >= maxQueriesPerChat;
  }

  /// Records a new session
  Future<String> recordNewSession() async {
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    await docRef.set({
      today: {
        'sessions': FieldValue.increment(1),
        'session_data': {
          sessionId: {'created_at': FieldValue.serverTimestamp(), 'queries': 0},
        },
      },
    }, SetOptions(merge: true));

    return sessionId;
  }

  /// Records a new query for the given session
  Future<void> recordQuery(String sessionId) async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    await docRef.set({
      today: {
        'session_data': {
          sessionId: {'queries': FieldValue.increment(1), 'last_query_at': FieldValue.serverTimestamp()},
        },
      },
    }, SetOptions(merge: true));
  }

  /// Gets the remaining sessions for today
  Future<int> getRemainingSessionsToday() async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return maxSessionsPerDay;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final dailyData = data[today] as Map<String, dynamic>? ?? {};

    final sessionsCount = dailyData['sessions'] as int? ?? 0;
    return maxSessionsPerDay - sessionsCount;
  }

  /// Gets the remaining queries for the current session
  Future<int> getRemainingQueriesForSession(String sessionId) async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return maxQueriesPerChat;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final dailyData = data[today] as Map<String, dynamic>? ?? {};
    final sessions = dailyData['session_data'] as Map<String, dynamic>? ?? {};

    final sessionData = sessions[sessionId] as Map<String, dynamic>? ?? {};
    final queryCount = sessionData['queries'] as int? ?? 0;

    return maxQueriesPerChat - queryCount;
  }
  
  /// Adds an extra session for today when a user watches a reward ad
  /// Returns true if the extra session was successfully added
  Future<bool> addExtraSessionFromRewardAd() async {
    try {
      final docRef = await _getDeviceDocRef();
      final today = _getTodayDateString();
      
      // Get current sessions count
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        // If no document exists yet, create it with a counter for reward-based sessions
        await docRef.set({
          today: {
            'sessions': 0,
            'reward_sessions': 1,
          },
        });
        return true;
      }
      
      // Update the document with an extra reward session
      await docRef.set({
        today: {
          'reward_sessions': FieldValue.increment(1),
        },
      }, SetOptions(merge: true));
      
      return true;
    } catch (e) {
      debugPrint('Error adding extra session from reward ad: $e');
      return false;
    }
  }
  
  /// Gets the total available sessions for today (including regular and reward-based)
  Future<int> getTotalAvailableSessionsToday() async {
    final docRef = await _getDeviceDocRef();
    final today = _getTodayDateString();

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return maxSessionsPerDay;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final dailyData = data[today] as Map<String, dynamic>? ?? {};

    final rewardSessions = dailyData['reward_sessions'] as int? ?? 0;
    return maxSessionsPerDay + rewardSessions;
  }
}
