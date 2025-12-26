import 'package:codedutravail/domain/entities/agent_message.dart';
import 'package:codedutravail/domain/entities/ai_response.dart';

abstract interface class AiAgentRepository {
  Stream<AiResponse> getAgentResponse({required List<AgentMessage> messages});
}
