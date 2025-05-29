import 'package:codedutravail/presentation/providers/articles/article.dart';
import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/core/utils/roman.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleWidget extends HookConsumerWidget {
  final int number;
  final bool useRomanNumerals;
  final int? maxLines;
  final int? maxLength;

  const ArticleWidget({
    super.key,
    required this.number,
    this.useRomanNumerals = false,
    this.maxLines,
    this.maxLength = 150,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleAsync = ref.watch(articleProvider(number));

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Theme.of(context).dividerColor.withAlpha((0.3 * 255).toInt())),
      ),
      child: articleAsync.when(
        data: (article) {
          final String articleNumber = useRomanNumerals ? article.number.roman : article.number.toString();
          final String displayText =
              maxLength != null && article.text.length > maxLength!
                  ? '${article.text.substring(0, maxLength)}...'
                  : article.text;

          return InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => ArticleRoute(article.number).push(context),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: maxLines,
                    overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Article $articleNumber: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        TextSpan(
                          text: displayText,
                          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading:
            () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.0))),
            ),
        error:
            (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Erreur lors du chargement de l\'article: ${error.toString()}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
      ),
    );
  }
}
