import 'package:codedutravail/core/domain/usecases/usecase.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:codedutravail/presentation/home/providers/ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_chat_message.g.dart';

@riverpod
AsyncValue<SendChatMessageUseCase> sendChatMessage(Ref ref) {
  final sessionAsync = ref.watch(chatSessionProvider);
  return sessionAsync.when(
    data: (session) => AsyncValue.data(SendChatMessageUseCase(session)),
    loading: () => AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}

class SendChatMessageUseCase extends UseCaseFamily<GenerateContentResponse, String> {
  final ChatSession _session;

  SendChatMessageUseCase(this._session);

  @override
  Future<GenerateContentResponse> execute(String message) {
    return _session.sendMessage(Content.text(message));
  }
} 