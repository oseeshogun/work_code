import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_message.freezed.dart';
part 'agent_message.g.dart';

enum AgentMessageType { user, assistant, system }

@freezed
abstract class AgentMessage with _$AgentMessage {
  const factory AgentMessage({required String content, required AgentMessageType role}) = _AgentMessage;
  
  factory AgentMessage.fromJson(Map<String, Object?> json) => _$AgentMessageFromJson(json);
}


@freezed
abstract class AgentMessagesList with _$AgentMessagesList {
  const factory AgentMessagesList({required List<AgentMessage> list}) = _AgentMessagesList;

  factory AgentMessagesList.fromJson(Map<String, Object?> json) => _$AgentMessagesListFromJson(json);
}