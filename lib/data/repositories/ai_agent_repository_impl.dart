import 'dart:convert';

import 'package:codedutravail/data/remote/dio_client.dart';
import 'package:codedutravail/domain/entities/agent_message.dart';
import 'package:codedutravail/domain/entities/ai_response.dart';
import 'package:codedutravail/domain/repositories/ai_agent_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_agent_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AiAgentRepository aiAgentRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);

  return AiAgentRepositoryImpl(dio);
}

class AiAgentRepositoryImpl implements AiAgentRepository {
  final Dio _dio;

  AiAgentRepositoryImpl(this._dio);

  @override
  Stream<AiResponse> getAgentResponse({required List<AgentMessage> messages}) async* {
    final response = await _dio.post<ResponseBody>(
      '/agent/chat/stream',
      data: {'messages': messages.map((m) => m.toJson()).toList()},
      options: Options(responseType: ResponseType.stream),
    );

    final responseStream = response.data!.stream;

    yield* utf8.decoder
        .bind(responseStream)
        .transform(const LineSplitter())
        .map((line) {
          try {
            return jsonDecode(line);
          } catch (e) {
            return null;
          }
        })
        .where((json) => json != null)
        .where((json) => json?['event'] == 'token')
        .map((json) {
          final data = jsonDecode(json['data']);
          final token = data['token'];
          
          return AiResponse(
            token: switch (token == messages.last.content){
              true => "...",
              false => switch (token is String) {
                true => token,
                false => token is List<dynamic> ? token.first['text'] : '',
              },
            },
            modelName: data['model_name'],
            modelProvider: data['model_provider'],
            totalTokens: data['total_tokens'],
            functionName: data['function_name'],
          );
        });
  }
}

