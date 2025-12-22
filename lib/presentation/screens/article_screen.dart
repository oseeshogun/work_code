import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/providers/articles/article.dart';
import 'package:codedutravail/core/presentations/providers/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleScreen extends HookConsumerWidget {
  final int number;
  const ArticleScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleRepository = ref.read(articleRepositoryProvider);
    final articleAsyncValue = ref.watch(articleProvider(number));
    final tts = ref.watch(ttsProvider).value;
    final isReading = useState(false);

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
              final icon = article.isFavorite ? Icons.favorite : Icons.favorite_border;
              return IconButton(
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
                icon: Icon(icon),
                tooltip: article.isFavorite ? 'Already in Favorites' : 'Add to Favorites',
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
    );
  }
}
