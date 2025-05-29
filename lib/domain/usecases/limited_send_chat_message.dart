import 'package:codedutravail/core/domain/errors/session_limit_exception.dart';
import 'package:codedutravail/core/domain/usecases/usecase.dart';
import 'package:codedutravail/core/services/limits_service.dart';
import 'package:codedutravail/presentation/providers/ai/limited_chat_session.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'limited_send_chat_message.g.dart';

@riverpod
AsyncValue<LimitedSendChatMessageUseCase> limitedSendChatMessage(Ref ref) {
  final sessionAsync = ref.watch(limitedChatSessionProvider);
  final limitsService = ref.watch(limitsServiceProvider);

  return sessionAsync.when(
    data:
        (session) =>
            AsyncValue.data(LimitedSendChatMessageUseCase(session.chatSession, session.sessionId, limitsService)),
    loading: () => AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}

class LimitedSendChatMessageUseCase extends UseCaseFamily<GenerateContentResponse, String> {
  final ChatSession _session;
  final String _sessionId;
  final LimitsService _limitsService;

  LimitedSendChatMessageUseCase(this._session, this._sessionId, this._limitsService);

  @override
  Future<GenerateContentResponse> execute(String message) async {
    // Check if query limit is reached
    final hasReachedLimit = await _limitsService.hasReachedQueryLimit(_sessionId);
    if (hasReachedLimit) {
      throw SessionLimitException();
    }

    // Record the query
    await _limitsService.recordQuery(_sessionId);

    // Send the message
    return await _session.sendMessage(Content.text(message));
  }
}
