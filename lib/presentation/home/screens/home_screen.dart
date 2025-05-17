import 'package:codedutravail/core/data/database.dart';
import 'package:codedutravail/core/presentations/providers/article.dart';
import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/domain/home/providers/read_disclaimer.dart';
import 'package:codedutravail/presentation/home/dialogs/disclaimer_dialog.dart';
import 'package:codedutravail/presentation/home/providers/titles.dart';
import 'package:codedutravail/presentation/home/widgets/article_search_delegate.dart';
import 'package:codedutravail/presentation/home/widgets/titles_empty_widget.dart';
import 'package:codedutravail/presentation/home/widgets/titles_error_widget.dart';
import 'package:codedutravail/presentation/home/widgets/titles_list_widget.dart';
import 'package:codedutravail/presentation/home/widgets/titles_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReadDisclaimer = ref.watch(readDisclaimerProvider).value;
    final titlesAsync = ref.watch(titlesProvider);
    final articleCountAsync = ref.watch(articleCountProvider);

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
          IconButton(onPressed: () => AiSearchRoute().push(context), icon: const Icon(Icons.assistant)),
          IconButton(onPressed: () => InfoRoute().push(context), icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: titlesAsync.when(
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
                (_, __) => Visibility(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final db = ref.read(dbProvider);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriftDbViewer(db)));
        },
        child: Icon(Icons.data_array),
      ),
    );
  }
}
