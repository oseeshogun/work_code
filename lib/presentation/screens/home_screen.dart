import 'package:codedutravail/domain/providers/articles/article.dart';
import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/providers/home/read_disclaimer.dart';
import 'package:codedutravail/presentation/dialogs/disclaimer_dialog.dart';
import 'package:codedutravail/domain/providers/articles/article_of_the_day.dart';
import 'package:codedutravail/domain/providers/articles/titles.dart';
import 'package:codedutravail/presentation/widgets/article_of_the_day_card.dart';
import 'package:codedutravail/presentation/widgets/article_search_delegate.dart';
import 'package:codedutravail/presentation/widgets/titles_empty_widget.dart';
import 'package:codedutravail/presentation/widgets/titles_error_widget.dart';
import 'package:codedutravail/presentation/widgets/titles_list_widget.dart';
import 'package:codedutravail/presentation/widgets/titles_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReadDisclaimer = ref.watch(readDisclaimerProvider).value;
    final titlesAsync = ref.watch(titlesProvider);
    final articleCountAsync = ref.watch(articleCountProvider);
    final articleOfTheDayAsync = ref.watch(articleOfTheDayProvider);
    final articleVisibilityAsync = ref.watch(articleOfDayVisibilityProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (hasReadDisclaimer is bool && !hasReadDisclaimer) {
          showDisclaimerDialog(context);
        }
      });
      return null;
    }, [hasReadDisclaimer]);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/drc_law.png', height: 30.0),
        title: Text('Code du Travail', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ArticleSearchDelegate(articleRepository: ref.read(articleRepositoryProvider), ref: ref),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () => InfoRoute().push(context), icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: Column(
        children: [
          articleVisibilityAsync.when(
            data:
                (isVisible) =>
                    isVisible
                        ? articleOfTheDayAsync.when(
                          data:
                              (article) => ArticleOfTheDayCard(
                                article: article,
                                onClose: () {
                                  ref.read(articleOfDayVisibilityProvider.notifier).hideForToday();
                                },
                              ),
                          loading: () => const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
                          error: (_, _) => const SizedBox(),
                        )
                        : const SizedBox(),
            loading: () => const SizedBox(),
            error: (_, _) => const SizedBox(),
          ),
          Expanded(
            child: titlesAsync.when(
              data: (titles) {
                return articleCountAsync.when(
                  data: (articleCount) {
                    if (titles.isEmpty || articleCount == 0) {
                      return const TitlesEmptyWidget();
                    }
                    return TitlesListWidget(titles: titles);
                  },
                  loading:
                      () => Visibility(
                        visible: titles.isNotEmpty,
                        replacement: const TitlesEmptyWidget(),
                        child: TitlesListWidget(titles: titles),
                      ),
                  error:
                      (_, _) => Visibility(
                        visible: titles.isNotEmpty,
                        replacement: const TitlesEmptyWidget(),
                        child: TitlesListWidget(titles: titles),
                      ),
                );
              },
              loading: () => const TitlesLoadingWidget(),
              error:
                  (error, stackTrace) =>
                      TitlesErrorWidget(errorMessage: error.toString(), onRetry: () => ref.invalidate(titlesProvider)),
            ),
          ),
        ],
      ),
    );
  }
}
