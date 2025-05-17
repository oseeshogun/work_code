import 'package:codedutravail/core/services/limits_service.dart';
import 'package:codedutravail/presentation/home/providers/ai.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'limited_chat_session.g.dart';

/// Represents the current chat session with its ID for tracking limits
class LimitedChatSession {
  final ChatSession chatSession;
  final String sessionId;
  final int remainingQueries;

  LimitedChatSession({
    required this.chatSession,
    required this.sessionId,
    required this.remainingQueries,
  });
}

/// Provider for the limited chat session
@riverpod
Future<LimitedChatSession> limitedChatSession(Ref ref) async {
  final limitsService = ref.watch(limitsServiceProvider);
  
  // Check if daily session limit is reached and throw a custom exception if it is
  await limitsService.checkDailySessionLimit();
  
  // Record a new session
  final sessionId = await limitsService.recordNewSession();
  
  // Get the chat session
  final chatSession = await ref.watch(chatSessionProvider.future);
  
  // Get remaining queries for this session
  final remainingQueries = await limitsService.getRemainingQueriesForSession(sessionId);
  
  return LimitedChatSession(
    chatSession: chatSession,
    sessionId: sessionId,
    remainingQueries: remainingQueries,
  );
}

/// Provider for the remaining queries in the current session
@riverpod
Future<int> remainingQueries(Ref ref) async {
  final limitedSessionAsync = ref.watch(limitedChatSessionProvider);
  
  return limitedSessionAsync.when(
    data: (session) async {
      final limitsService = ref.watch(limitsServiceProvider);
      return limitsService.getRemainingQueriesForSession(session.sessionId);
    },
    loading: () async => 0,
    error: (_, __) async => 0,
  );
}

/// Provider for the remaining sessions today
@riverpod
Future<int> remainingSessions(Ref ref) {
  final limitsService = ref.watch(limitsServiceProvider);
  return limitsService.getRemainingSessionsToday();
}
