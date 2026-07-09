import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedutravail/core/config/config.dart';
import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:codedutravail/data/remote/dio_client.dart';
import 'package:codedutravail/domain/entities/agent_message.dart';
import 'package:codedutravail/domain/entities/ai_response.dart';
import 'package:codedutravail/domain/repositories/ai_agent_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

part 'ai_agent_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AiAgentRepository aiAgentRepository(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  final dio = ref.watch(dioClientProvider);

  return AiAgentRepositoryImpl(dio, firestore);
}

class AiAgentRepositoryImpl implements AiAgentRepository {
  final Dio _dio;
  final FirebaseFirestore _firestore;
  
  AiAgentRepositoryImpl(this._dio, this._firestore);

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
              true => "Réfléxion...",
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
  
  @override
  Future<bool> doesReachDailyChatLimit() async {
    final identifier = await MobileDeviceIdentifier().getDeviceId();

    if (identifier == null) return true;

    final today = DateTime.now().toIso8601String().split('T').first;
    final ref = _firestore.collection('users').doc(identifier).collection('chats').doc(today);
    final doc = await ref.get();
    if (doc.exists) {
      final data = doc.data()!;
      return data['count'] >= Config.kDailyChatLimit;
    }
    return false;
  }

  @override
  Future<void> incrementDailyChatCount() async {
    final identifier = await MobileDeviceIdentifier().getDeviceId();

    if (identifier == null) return;

    final today = DateTime.now().toIso8601String().split('T').first;
    final ref = _firestore.collection('users').doc(identifier).collection('chats').doc(today);
    await ref.set({'count': FieldValue.increment(1)}, SetOptions(merge: true));
  }
}

