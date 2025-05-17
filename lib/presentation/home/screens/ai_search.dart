import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:codedutravail/core/services/ads/ads_service.dart';
import 'package:codedutravail/core/services/limits_service.dart';
import 'package:codedutravail/domain/usecases/limited_send_chat_message.dart';
import 'package:codedutravail/presentation/home/providers/limited_chat_session.dart';
import 'package:codedutravail/presentation/home/widgets/animated_gradient_border_text_field.dart';
import 'package:codedutravail/presentation/home/widgets/session_limit_view.dart';
import 'package:codedutravail/presentation/home/widgets/thinking_indicator.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AiSearchScreen extends HookConsumerWidget {
  const AiSearchScreen({super.key});

  // Handle watching a reward ad to gain an extra session
  void _handleWatchRewardAd(BuildContext context, WidgetRef ref) async {
    final adsService = ref.read(adsServiceProvider);
    final limitsService = ref.read(limitsServiceProvider);

    // Show loading indicator
    showDialog(
      context: ref.context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Chargement de la publicité...')],
            ),
          ),
    );

    // Show the rewarded ad
    final result = await adsService.showRewardedAd(
      onRewarded: () async {
        // Add an extra session when the user earns the reward
        await limitsService.addExtraSessionFromRewardAd();
      },
    );

    // Close the loading dialog
    if (context.mounted) Navigator.of(context).pop();

    if (result && context.mounted) {
      // Show success message
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Félicitations!'),
              content: const Text('Vous avez gagné une session supplémentaire!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Refresh the session provider to try again
                    final _ = ref.refresh(limitedChatSessionProvider);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else if (context.mounted) {
      // Show error message
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Erreur'),
              content: const Text("Impossible de charger la publicité. Veuillez réessayer plus tard."),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limitedSendChatMessageAsync = ref.watch(limitedSendChatMessageProvider);
    final remainingQueriesAsync = ref.watch(remainingQueriesProvider);
    final remainingSessionsAsync = ref.watch(remainingSessionsProvider);
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);
    final thinking = useState(false);
    final chats = useState<Map<String, GenerateContentResponse>>({});
    final scrollController = useScrollController();
    final adsService = ref.watch(adsServiceProvider);

    // Show interstitial ad when the screen is first built
    useEffect(() {
      // Use addPostFrameCallback to ensure the ad is shown after the UI is fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // First load the interstitial ad
        adsService.loadInterstitialAd().then((_) {
          // Then show it after it's loaded
          adsService.showInterstitialAd();
        });
      });
      return null;
    }, []);

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
                replacement: Center(
                  child: Text(
                    'Posez une question pour commencer',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ),
                child: ListView.builder(
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.blue.shade800
                                    : Colors.blue.shade100,
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
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
                                backgroundColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade300,
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                              codeblockDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              blockquote: TextStyle(
                                color:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                              blockquoteDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                                border: Border(
                                  left: BorderSide(
                                    color:
                                        Theme.of(context).brightness == Brightness.dark
                                            ? Colors.blue.shade700
                                            : Colors.blue.shade300,
                                    width: 4,
                                  ),
                                ),
                              ),
                              blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            if (thinking.value) ThinkingIndicator(),
            const SizedBox(height: 16),
            Column(
              children: [
                // Display remaining queries and sessions
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      remainingQueriesAsync.when(
                        data:
                            (count) => Text(
                              'Requêtes restantes: $count/10',
                              style: TextStyle(fontSize: 12, color: count < 3 ? Colors.red : Colors.grey),
                            ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      remainingSessionsAsync.when(
                        data:
                            (count) => Text(
                              'Sessions restantes: $count/2',
                              style: TextStyle(fontSize: 12, color: count < 1 ? Colors.red : Colors.grey),
                            ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                // Input field with limits
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
                          remainingQueriesAsync.whenData((remaining) {
                            if (remaining <= 0) {
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
                          });
                        },
                      ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) {
                    // Check if this is a session limit exception
                    if (e.toString().contains('limit') || e.toString().contains('session')) {
                      return SessionLimitView(onRetry: null, onWatchAd: () => _handleWatchRewardAd(context, ref));
                    }

                    // For other errors
                    return Column(
                      children: [
                        Text('Erreur: ${e.toString()}', style: TextStyle(color: Colors.red)),
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
