import 'package:codedutravail/data/repositories/ai_agent_repository_impl.dart';
import 'package:codedutravail/domain/entities/agent_message.dart';
import 'package:codedutravail/domain/entities/ai_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_responses.g.dart';

@riverpod
Stream<AiResponse> streamAiResponses(Ref ref, AgentMessagesList messages) {
  final repository = ref.watch(aiAgentRepositoryProvider);

  return repository.getAgentResponse(messages: messages.list);
}

@riverpod
Future<bool> doesReachDailyChatLimit(Ref ref) {
  final repository = ref.watch(aiAgentRepositoryProvider);

  return repository.doesReachDailyChatLimit();
}