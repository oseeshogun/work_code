import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/providers/articles/article.dart';
import 'package:codedutravail/core/presentations/providers/flutter_tts.dart';
import 'package:codedutravail/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ArticleScreen extends HookConsumerWidget {
  final int number;
  const ArticleScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleRepository = ref.read(articleRepositoryProvider);
    final articleAsyncValue = ref.watch(articleProvider(number));
    final tts = ref.watch(ttsProvider).value;
    final isReading = useState(false);

    const packageName = 'com.oseemasuaku.codedutravail';
    final androidUrl = 'https://play.google.com/store/apps/details?id=$packageName';

    speak(String text) {
      isReading.value = tts != null;
      tts?.speak(text);
      tts?.setCompletionHandler(() {
        isReading.value = false;
      });
    }

    useEffect(() {
      return () => tts?.stop();
    }, [tts]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Article $number', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0)),
        actions: [
          if (isReading.value)
            IconButton(icon: const Icon(Icons.close), onPressed: () => tts?.stop(), tooltip: 'Stop Reading'),
          articleAsyncValue.when(
            error: (error, stackTrace) => SizedBox.shrink(),
            loading: () => SizedBox.shrink(),
            data: (article) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final box = context.findRenderObject() as RenderBox?;
                      final origin = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                      SharePlus.instance.share(
                        ShareParams(
                          text: 'Article ${article.number} - Code du Travail\n\n${article.text}\n\n$androidUrl',
                          sharePositionOrigin: origin,
                        ),
                      );
                    },
                    icon: const Icon(Icons.share),
                    tooltip: 'Partager l\'article',
                  ),
                  IconButton(
                    onPressed: () {
                      articleRepository.toggleArticleToFavorite(article.number).catchError((_) {
                        if (context.mounted) {
                          showOkAlertDialog(
                            context: context,
                            message: 'Une erreur est survenue lors de l\'ajout aux favoris.',
                          );
                        }
                      });
                    },
                    icon: Icon(article.isFavorite ? Icons.favorite : Icons.favorite_border),
                    tooltip: article.isFavorite ? 'Déjà dans les favoris' : 'Ajouter aux favoris',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Article content
          Expanded(
            child: articleAsyncValue.when(
              data: (article) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Article ${article.number}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            if (!isReading.value)
                              IconButton(
                                onPressed: () => speak(article.text),
                                icon: const Icon(Icons.volume_up),
                                tooltip: 'Lire',
                              )
                            else
                              const Icon(Icons.voice_chat, color: Colors.grey),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () => AiAgentRoute().push(context),
                              icon: const Icon(Icons.chat_bubble),
                              label: const Text("Assistant IA"),
                            ),
                            const SizedBox(width: 12),
                          ],
                        );
                      } else if (index == 1) {
                        return const SizedBox(height: 20);
                      } else {
                        return Text(article.text);
                      }
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (number > 1)
                FilledButton.tonalIcon(
                  onPressed: () => ArticleRoute(number - 1).replace(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Précédent'),
                )
              else
                const SizedBox.shrink(),
              if (number < 334)
                FilledButton.tonalIcon(
                  onPressed: () => ArticleRoute(number + 1).replace(context),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Suivant'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
