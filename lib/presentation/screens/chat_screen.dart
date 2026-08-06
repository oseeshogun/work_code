import 'package:codedutravail/domain/providers/chat/chat_controller.dart';
import 'package:codedutravail/domain/providers/chat/session_limit.dart';
import 'package:codedutravail/presentation/widgets/ai_typing_indicator.dart';
import 'package:codedutravail/presentation/widgets/chat_empty_state.dart';
import 'package:codedutravail/presentation/widgets/chat_message_bubble.dart';
import 'package:codedutravail/presentation/widgets/rainbow_border.dart';
import 'package:codedutravail/presentation/widgets/session_limit_view.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final sessionConsumed = useRef(false);

    final sessionLimitAsync = ref.watch(sessionLimitProvider);
    final chatState = ref.watch(chatControllerProvider);
    final theme = Theme.of(context);

    useEffect(() {
      if (kDebugMode) return null;
      final limitState = sessionLimitAsync.value;
      if (!sessionConsumed.value && limitState != null && !limitState.isLimitReached) {
        sessionConsumed.value = true;
        Future.microtask(() => ref.read(sessionLimitProvider.notifier).consumeSession());
      }
      return null;
    }, [sessionLimitAsync.value]);

    useEffect(() {
      if (chatState.messages.isNotEmpty || chatState.isLoading) {
        Future.microtask(() {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          }
        });
      }
      return null;
    }, [chatState.messages.length, chatState.isLoading]);

    void send() {
      final text = textController.text;
      if (text.trim().isEmpty) return;
      textController.clear();
      ref.read(chatControllerProvider.notifier).sendMessage(text);
    }

    final isLimitReached = !kDebugMode && (sessionLimitAsync.value?.isLimitReached ?? false);
    final showEmptyState = chatState.messages.isEmpty && !chatState.isLoading;
    final itemCount = chatState.messages.length + (chatState.isLoading ? 1 : 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Elimu')),
      body: isLimitReached
          ? const SessionLimitView()
          : Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: showEmptyState
                        ? const ChatEmptyState(key: ValueKey('empty'))
                        : ListView.builder(
                            key: const ValueKey('list'),
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              if (index < chatState.messages.length) {
                                return ChatMessageBubble(message: chatState.messages[index]);
                              }
                              return AiTypingIndicator(statusMessage: chatState.statusMessage);
                            },
                          ),
                  ),
                ),
                if (chatState.messages.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, size: 13, color: theme.colorScheme.outline),
                        const SizedBox(width: 6),
                        Text(
                          "L'IA peut se tromper. Vérifiez les articles cités.",
                          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
                    child: RainbowBorder(
                      animate: chatState.isLoading,
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 10, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              controller: textController,
                              enabled: !chatState.isLoading,
                              minLines: 3,
                              maxLines: 8,
                              textInputAction: TextInputAction.newline,
                              style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 15),
                              decoration: const InputDecoration(
                                hintText: 'Votre question...',
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                            ),
                            const SizedBox(height: 6),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                              child: chatState.isLoading
                                  ? const Padding(
                                      key: ValueKey('sending'),
                                      padding: EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(strokeWidth: 2.5),
                                      ),
                                    )
                                  : IconButton.filled(
                                      key: const ValueKey('send'),
                                      onPressed: send,
                                      icon: const Icon(Icons.send),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
