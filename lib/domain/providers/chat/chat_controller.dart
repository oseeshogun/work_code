import 'package:codedutravail/core/utils/logger.dart';
import 'package:codedutravail/domain/entities/chat_message.dart';
import 'package:codedutravail/domain/providers/chat/ai_agent_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

class ChatState {
  final List<ChatMessageEntity> messages;
  final bool isLoading;
  final String? statusMessage;

  const ChatState({this.messages = const [], this.isLoading = false, this.statusMessage});

  ChatState copyWith({
    List<ChatMessageEntity>? messages,
    bool? isLoading,
    String? statusMessage,
    bool clearStatusMessage = false,
  }) => ChatState(
    messages: messages ?? this.messages,
    isLoading: isLoading ?? this.isLoading,
    statusMessage: clearStatusMessage ? null : (statusMessage ?? this.statusMessage),
  );
}

/// Friendly French labels shown while the AI is working, so waiting feels
/// like visible progress rather than a silent spinner.
String _statusLabelFor(String toolName, Map<String, dynamic> args) {
  switch (toolName) {
    case 'get_code_structure':
      return 'Consultation du plan du code du travail...';
    case 'search_articles':
      final keywords = (args['keywords'] as List<dynamic>?)?.map((e) => e.toString()).join(', ');
      return (keywords != null && keywords.isNotEmpty)
          ? 'Recherche : $keywords'
          : "Recherche d'articles pertinents...";
    case 'get_article_by_number':
      return "Vérification de l'article ${args['number']}...";
    default:
      return 'Réflexion en cours...';
  }
}

@riverpod
class ChatController extends _$ChatController {
  @override
  ChatState build() => const ChatState();

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.isLoading) return;

    state = state.copyWith(
      messages: [...state.messages, ChatMessageEntity(role: ChatRole.user, content: text)],
      isLoading: true,
      statusMessage: 'Réflexion en cours...',
    );

    try {
      final reply = await ref
          .read(aiAgentServiceProvider)
          .sendMessage(text, onToolCall: (name, args) => state = state.copyWith(statusMessage: _statusLabelFor(name, args)));

      state = state.copyWith(
        messages: [...state.messages, ChatMessageEntity(role: ChatRole.assistant, content: reply)],
        isLoading: false,
        clearStatusMessage: true,
      );
    } catch (e, st) {
      AppLogger.error('[ChatController] sendMessage failed', error: e, stackTrace: st);
      state = state.copyWith(
        messages: [
          ...state.messages,
          const ChatMessageEntity(
            role: ChatRole.assistant,
            content: 'Une erreur est survenue. Veuillez réessayer.',
            isError: true,
          ),
        ],
        isLoading: false,
        clearStatusMessage: true,
      );
    }
  }

  void reset() {
    ref.read(aiAgentServiceProvider).reset();
    state = const ChatState();
  }
}
