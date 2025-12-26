import 'package:codedutravail/core/presentations/widgets/ai_answer_bubble.dart';
import 'package:codedutravail/core/presentations/widgets/question_bubble.dart';
import 'package:codedutravail/core/presentations/widgets/info_bubble.dart';
import 'package:codedutravail/core/presentations/widgets/thinking_indicator.dart';
import 'package:codedutravail/domain/entities/agent_message.dart';
import 'package:codedutravail/domain/providers/ai/ai_responses.dart';
import 'package:codedutravail/presentation/widgets/animated_gradient_border_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const int _kListMaxLength = 10;

class AiAgentScreen extends HookConsumerWidget {
  const AiAgentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final scrollController = useScrollController();
    final isFocused = useState(false);
    final messagesList = useState<AgentMessagesList>(AgentMessagesList(list: []));
    final limitReached = useMemoized(() => messagesList.value.list.length >= _kListMaxLength, [messagesList.value]);
    final aiResponseAsync = messagesList.value.list.isEmpty
        ? AsyncValue.data(null)
        : ref.watch(streamAiResponsesProvider(messagesList.value));

    useEffect(() {
      void onFocusChange() {
        isFocused.value = focusNode.hasFocus;
      }

      focusNode.addListener(onFocusChange);
      return () => focusNode.removeListener(onFocusChange);
    }, [focusNode]);

    useEffect(() {
      if (kDebugMode && aiResponseAsync.hasError) {
        debugPrint('AI Response Error: ${aiResponseAsync.error}');
        debugPrint('Stack Trace: ${aiResponseAsync.stackTrace}');
      }
      return null;
    }, [aiResponseAsync.hasError]);

    useEffect(() {
      if ((messagesList.value.list.isNotEmpty || aiResponseAsync.value != null) && scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
          textController.clear();
        });
      }
      return null;
    }, [messagesList.value.list.length, aiResponseAsync.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Assistant Code du travail', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: .center,
          children: [
            Visibility(
              visible: messagesList.value.list.isNotEmpty,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/Android-pana.svg', height: 150.0),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Bienvenue dans l\'assistant IA du Code du Travail !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Cet agent est un outil d\'assistance à la recherche et à la consultation du Code du travail. '
                    'Il ne fournit pas de conseil juridique et ne se substitue pas à un professionnel du droit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: messagesList.value.list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final message = messagesList.value.list[index];
                  return switch (message.role) {
                    AgentMessageType.user => QuestionBubble(text: message.content),
                    AgentMessageType.assistant => AiAnswerBubble(text: message.content),
                    AgentMessageType.system => InfoBubble(text: message.content),
                  };
                },
              ),
            ),
            if (aiResponseAsync.isLoading)
              Container(margin: const EdgeInsets.symmetric(vertical: 8.0), child: const ThinkingIndicator()),
            if (aiResponseAsync.hasError) ...[
              InfoBubble(text: 'Une erreur est survenue lors de la récupération de la réponse. Veuillez réessayer.'),
              const SizedBox(height: 8.0),
              IconButton(
                onPressed: () => ref.invalidate(streamAiResponsesProvider(messagesList.value)),
                icon: const Icon(Icons.refresh),
              ),
            ] else if (aiResponseAsync.value != null)
              AiAnswerBubble(text: aiResponseAsync.value!.token),
            const SizedBox(height: 12.0),

            Visibility(
              visible: !limitReached,
              replacement: const Text(
                'Vous avez atteint le nombre maximum de questions autorisées. '
                'Veuillez revenir en arrière et commencer une nouvelle session.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent),
              ),
              child: AnimatedGradientBorderTextField(
                controller: textController,
                isFocused: isFocused.value,
                focusNode: focusNode,
                thinking: aiResponseAsync.isLoading,
                minLines: 2,
                maxLines: 6,
                hintText: 'Posez votre question sur le Code du travail...',
                labelText: 'Votre question',
                onSubmit: (value) {
                  // Handle question submission
                  final message = AgentMessage(content: value, role: AgentMessageType.user);
                  messagesList.value = AgentMessagesList(
                    list: [
                      ...messagesList.value.list,
                      if (aiResponseAsync.value != null)
                        AgentMessage(content: aiResponseAsync.value!.token, role: AgentMessageType.assistant),
                      message,
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              "Les réponses fournies par l'assistant IA sont générées et peuvent ne pas être exactes ou complètes. ",
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
