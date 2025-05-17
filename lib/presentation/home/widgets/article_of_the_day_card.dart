import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:flutter/material.dart';

/// A card widget that displays the Article of the Day
class ArticleOfTheDayCard extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback? onClose;
  
  const ArticleOfTheDayCard({
    super.key,
    required this.article,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => ArticleRoute(article.number).push(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Article du jour',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  if (onClose != null)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                      tooltip: 'Masquer pour aujourd\'hui',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Article ${article.number}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                article.text.length > 150
                    ? '${article.text.substring(0, 150)}...'
                    : article.text,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => ArticleRoute(article.number).push(context),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Lire plus'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
