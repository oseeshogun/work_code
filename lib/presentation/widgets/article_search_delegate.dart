import 'package:codedutravail/presentation/widgets/article_widget.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:codedutravail/domain/repositories/artitle_repository.dart';
import 'package:codedutravail/presentation/providers/search.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleSearchDelegate extends SearchDelegate<ArticleEntity?> {
  final ArticleRepository articleRepository;
  final WidgetRef ref;

  ArticleSearchDelegate({required this.articleRepository, required this.ref})
    : super(
        searchFieldLabel: 'Rechercher un article...',
        searchFieldStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _buildEmptySearchPrompt(context);
    }

    return Consumer(
      builder: (context, ref, child) {
        final articlesAsync = ref.watch(searchProvider(query));

        return articlesAsync.when(
          data: (articles) {
            if (articles.isEmpty) {
              return _buildEmptySearchPrompt(context);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleWidget(number: article.number, maxLines: 3);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) => Center(
                child: Text(
                  'Erreur lors de la recherche: $error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildEmptySearchPrompt(context);
    }

    return Consumer(
      builder: (context, ref, child) {
        final articlesAsync = ref.watch(searchProvider(query));

        return articlesAsync.when(
          data: (articles) {
            if (articles.isEmpty) {
              return _buildEmptySearchPrompt(context);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleWidget(number: article.number, maxLines: 3);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) => Center(
                child: Text(
                  'Erreur lors de la recherche: $error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
        );
      },
    );
  }

  Widget _buildEmptySearchPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Rechercher un article...',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Astuces: Tapez 18,23,14 pour avoir les articles 18, 23 et 14',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
