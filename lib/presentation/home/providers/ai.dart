import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_ai/firebase_ai.dart';

part 'ai.g.dart';

@riverpod
Future<String> systemPrompt(Ref ref) => rootBundle.loadString('assets/system_prompt.md');

@riverpod
Future<GenerativeModel> geminiModel(Ref ref) async {
  final systemPrompt = await ref.watch(systemPromptProvider.future);

  final model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.0-flash',
    systemInstruction: Content.system(systemPrompt),
  );
  return model;
}

@riverpod
Future<ChatSession> chatSession(Ref ref) async {
  final model = await ref.watch(geminiModelProvider.future);
  return model.startChat();
}
