import 'package:codedutravail/presentation/home/providers/articles/article.dart';
import 'package:codedutravail/core/providers/ads/banner_ad.dart';
import 'package:codedutravail/core/providers/flutter_tts.dart';
import 'package:codedutravail/presentation/home/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleScreen extends HookConsumerWidget {
  final int number;
  const ArticleScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleAsyncValue = ref.watch(articleProvider(number));
    final tts = ref.watch(ttsProvider).value;
    final isReading = useState(false);
    final bannerAd = ref.watch(bannerAdNotifierProvider);
    
    // Load the banner ad when the screen is first built
    useEffect(() {
      bannerAd.load();
      return () => bannerAd.dispose();
    }, []);

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
          
          // Banner ad at the bottom
          BannerAdWidget(ad: bannerAd),
        ],
      ),
    );
  }
}
