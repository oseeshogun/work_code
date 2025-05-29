import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:codedutravail/core/domain/errors/session_limit_exception.dart';
import 'package:codedutravail/core/presentations/providers/ads/interstitial_ad.dart';
import 'package:codedutravail/core/presentations/providers/ads/rewarded_add.dart';
import 'package:codedutravail/core/services/limits_service.dart';
import 'package:codedutravail/domain/usecases/limited_send_chat_message.dart';
import 'package:codedutravail/presentation/providers/ai/limited_chat_session.dart';
import 'package:codedutravail/presentation/widgets/animated_gradient_border_text_field.dart';
import 'package:codedutravail/presentation/widgets/session_limit_view.dart';
import 'package:codedutravail/presentation/widgets/thinking_indicator.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AiSearchScreen extends HookConsumerWidget {
  const AiSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limitedSendChatMessageAsync = ref.watch(limitedSendChatMessageProvider);
    final remainingQueries = ref.watch(remainingQueriesProvider).value ?? 0;
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);
    final thinking = useState(false);
    final chats = useState<Map<String, GenerateContentResponse>>({});
    final scrollController = useScrollController();
    final interstitialAdShown = useState(false);
    final interstitialAd = ref.watch(interstitialAdNotifierProvider);
    final rewardedAd = ref.watch(rewardedAdNotifierProvider);
    final loadingReward = useState(false);

    showRewardedAd() {
      rewardedAd?.setImmersiveMode(true);
      rewardedAd!.show(
        onUserEarnedReward: (_, reward) async {
          if (context.mounted) loadingReward.value = true;
          await ref.read(limitsServiceProvider).addExtraSessionFromRewardAd();
          ref.invalidate(limitedChatSessionProvider);
          if (context.mounted) loadingReward.value = false;
        },
      );
    }

    // Show interstitial ad when the screen is first built
    useEffect(() {
      if (interstitialAd != null && !interstitialAdShown.value) {
        interstitialAd.show();
        interstitialAdShown.value = true;
      }
      return null;
    }, [interstitialAd]);

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
              child: Visibility(
                visible: chats.value.isNotEmpty,
                replacement: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svgs/Android-pana.svg', height: 150),
                      const SizedBox(height: 20),
                      Text('Posez une question pour commencer', style: TextStyle(color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chats.value.length * 2,
                  itemBuilder: (context, index) {
                    final isQuestion = index % 2 == 0;
                    final entryIndex = index ~/ 2;
                    final entry = chats.value.entries.elementAt(entryIndex);

                    return Visibility(
                      visible: isQuestion,
                      replacement: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: switch (Theme.of(context).brightness) {
                              Brightness.dark => Colors.grey.shade800,
                              Brightness.light => Colors.grey.shade200,
                            },
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                          child: MarkdownBody(
                            data: entry.value.text ?? 'Pas de réponse',
                            selectable: true,
                            styleSheet: MarkdownStyleSheet(
                              p: Theme.of(context).textTheme.bodyMedium,
                              h1: Theme.of(context).textTheme.titleLarge,
                              h2: Theme.of(context).textTheme.titleMedium,
                              h3: Theme.of(context).textTheme.titleSmall,
                              code: TextStyle(
                                backgroundColor: switch (Theme.of(context).brightness) {
                                  Brightness.dark => Colors.grey.shade700,
                                  Brightness.light => Colors.grey.shade300,
                                },
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                              codeblockDecoration: BoxDecoration(
                                color: switch (Theme.of(context).brightness) {
                                  Brightness.dark => Colors.grey.shade700,
                                  Brightness.light => Colors.grey.shade300,
                                },
                                borderRadius: BorderRadius.circular(4),
                              ),
                              blockquote: TextStyle(
                                color: switch (Theme.of(context).brightness) {
                                  Brightness.dark => Colors.grey.shade300,
                                  Brightness.light => Colors.grey.shade700,
                                },
                                fontStyle: FontStyle.italic,
                              ),
                              blockquoteDecoration: BoxDecoration(
                                color: switch (Theme.of(context).brightness) {
                                  Brightness.dark => Colors.grey.shade900,
                                  Brightness.light => Colors.grey.shade100,
                                },
                                borderRadius: BorderRadius.circular(4),
                                border: Border(
                                  left: BorderSide(
                                    color: switch (Theme.of(context).brightness) {
                                      Brightness.dark => Colors.blue.shade700,
                                      Brightness.light => Colors.blue.shade300,
                                    },
                                    width: 4,
                                  ),
                                ),
                              ),
                              blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                            ),
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: switch (Theme.of(context).brightness) {
                              Brightness.dark => Colors.blue.shade800,
                              Brightness.light => Colors.blue.shade100,
                            },
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(entry.key),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (thinking.value) ThinkingIndicator(),
            const SizedBox(height: 16),
            Column(
              children: [
                limitedSendChatMessageAsync.when(
                  data:
                      (sendMessageUseCase) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Requêtes restantes: $remainingQueries/${LimitsService.maxQueriesPerChat}',
                              style: TextStyle(fontSize: 12, color: remainingQueries < 3 ? Colors.red : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => SizedBox(),
                ),
                loadingReward.value ? const Center(child: CircularProgressIndicator()) : SizedBox(),
                limitedSendChatMessageAsync.when(
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

                          // Check remaining queries
                          if (remainingQueries <= 0) {
                            showOkAlertDialog(
                              context: context,
                              title: 'Limite atteinte',
                              message: 'Vous avez atteint la limite de requêtes pour cette session.',
                            );
                            return;
                          }

                          thinking.value = true;
                          // Send the message with limits check
                          sendMessageUseCase.call(message).then((value) {
                            thinking.value = false;
                            value.fold(
                              (l) {
                                showOkAlertDialog(context: context, title: 'Erreur', message: l.message);
                              },
                              (r) {
                                textController.clear();
                                chats.value = {...chats.value, message: r};
                                // Refresh the remaining queries count
                                final _ = ref.refresh(remainingQueriesProvider);
                              },
                            );
                          });
                        },
                      ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) {
                    if (e is SessionLimitException) {
                      return SessionLimitView(
                        onRetry: null,
                        onWatchAd: rewardedAd != null ? () => showRewardedAd() : null,
                      );
                    }

                    return Column(
                      children: [
                        Text('Erreur: ${e.runtimeType.toString()}', style: TextStyle(color: Colors.red)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            final _ = ref.refresh(limitedChatSessionProvider);
                          },
                          child: const Text('Réessayer'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
