import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:codedutravail/domain/usecases/send_chat_message.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math' as math;

class AiSearchScreen extends HookConsumerWidget {
  const AiSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sendChatMessageAsync = ref.watch(sendChatMessageProvider);
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);
    final thinking = useState(false);
    final chats = useState<Map<String, GenerateContentResponse>>({});
    final scrollController = useScrollController();

    // Auto-scroll to bottom when new messages arrive
    useEffect(() {
      if (chats.value.isNotEmpty && scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
      return null;
    }, [chats.value.length]);

    useEffect(() {
      void onFocusChange() {
        isFocused.value = focusNode.hasFocus;
      }

      focusNode.addListener(onFocusChange);
      return () => focusNode.removeListener(onFocusChange);
    }, [focusNode]);

    return Scaffold(
      appBar: AppBar(title: const Text('Recherche par IA'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  chats.value.isEmpty
                      ? const Center(
                        child: Text('Posez une question pour commencer', style: TextStyle(color: Colors.grey)),
                      )
                      : ListView.builder(
                        controller: scrollController,
                        itemCount: chats.value.length * 2, // Each entry has a question and answer
                        itemBuilder: (context, index) {
                          final isQuestion = index % 2 == 0;
                          final entryIndex = index ~/ 2;
                          final entry = chats.value.entries.elementAt(entryIndex);

                          if (isQuestion) {
                            // Question bubble
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(entry.key),
                              ),
                            );
                          } else {
                            // Response bubble
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                                ),
                                child: MarkdownBody(
                                  data: entry.value.text ?? 'Pas de réponse',
                                  selectable: true,
                                  styleSheet: MarkdownStyleSheet(
                                    p: Theme.of(context).textTheme.bodyMedium,
                                    h1: Theme.of(context).textTheme.titleLarge,
                                    h2: Theme.of(context).textTheme.titleMedium,
                                    h3: Theme.of(context).textTheme.titleSmall,
                                    code: TextStyle(
                                      backgroundColor: Colors.grey.shade300,
                                      fontFamily: 'monospace',
                                      fontSize: 14,
                                    ),
                                    codeblockDecoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
            ),
            if (thinking.value) _buildThinkingIndicator(),
            const SizedBox(height: 16),
            sendChatMessageAsync.when(
              data:
                  (sendMessageUseCase) => AnimatedGradientBorderTextField(
                    thinking: thinking.value,
                    controller: textController,
                    focusNode: focusNode,
                    isFocused: isFocused.value,
                    minLines: 3,
                    maxLines: 4, // Reduced max lines to save space for chat
                    hintText: 'Posez votre question ici...',
                    labelText: 'AI Search',
                    onSubmit: (message) {
                      if (thinking.value) return;
                      if (message.trim().isEmpty) return;
                      thinking.value = true;
                      // Clear the text field after submission
                      sendMessageUseCase.call(message).then((value) {
                        thinking.value = false;
                        value.fold(
                          (l) {
                            showOkAlertDialog(context: context, message: l.message);
                          },
                          (r) {
                            textController.clear();
                            chats.value = {...chats.value, message: r};
                          },
                        );
                      });
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Erreur: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThinkingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DotPulse(delay: 0),
            SizedBox(width: 4),
            _DotPulse(delay: 300),
            SizedBox(width: 4),
            _DotPulse(delay: 600),
          ],
        ),
      ),
    );
  }
}

class _DotPulse extends StatefulWidget {
  final int delay;

  const _DotPulse({required this.delay});

  @override
  State<_DotPulse> createState() => _DotPulseState();
}

class _DotPulseState extends State<_DotPulse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 8 + (4 * _animation.value),
          height: 8 + (4 * _animation.value),
          decoration: BoxDecoration(color: Colors.grey.shade500, shape: BoxShape.circle),
        );
      },
    );
  }
}

class AnimatedGradientBorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;
  final int minLines;
  final int maxLines;
  final String hintText;
  final String labelText;
  final Function(String) onSubmit;
  final bool thinking;

  const AnimatedGradientBorderTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isFocused,
    this.minLines = 1,
    this.maxLines = 1,
    required this.hintText,
    required this.labelText,
    required this.onSubmit,
    this.thinking = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient:
            isFocused
                ? const LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        border: Border.all(color: isFocused ? Colors.transparent : Colors.grey.shade300, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              TextField(
                controller: controller,
                focusNode: focusNode,
                minLines: minLines,
                maxLines: maxLines,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 48, 16), // Add right padding for the button
                  border: InputBorder.none,
                  labelText: labelText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: false,
                  labelStyle: TextStyle(color: isFocused ? Colors.blue : Colors.grey, fontWeight: FontWeight.bold),
                ),
                onSubmitted: onSubmit,
              ),
              if (!thinking)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // Handle submit action
                        if (controller.text.trim().isNotEmpty) {
                          onSubmit(controller.text);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient:
                              isFocused
                                  ? const LinearGradient(
                                    colors: [Colors.blue, Colors.purple, Colors.red],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                  : null,
                          color: isFocused ? null : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Transform.rotate(
                          angle: -math.pi / 6, // Negative pi/4 (-45 degrees)
                          child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
