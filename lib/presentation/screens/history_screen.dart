import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/domain/providers/history/recently_viewed.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(recentlyViewedArticlesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Consultés récemment')),
      body: historyAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(child: Text('Aucun article consulté pour le moment.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final viewedAt = entry.viewedAt;
              final time =
                  '${viewedAt.day.toString().padLeft(2, '0')}/${viewedAt.month.toString().padLeft(2, '0')} '
                  '${viewedAt.hour.toString().padLeft(2, '0')}:${viewedAt.minute.toString().padLeft(2, '0')}';

              return ListTile(
                title: Text('Article ${entry.article.number}'),
                subtitle: Text(entry.article.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: Text(time),
                onTap: () => ArticleRoute(entry.article.number).push(context),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur: $error')),
      ),
    );
  }
}
