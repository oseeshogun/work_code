import 'package:codedutravail/core/presentations/widgets/article_widget.dart';
import 'package:codedutravail/core/utils/roman.dart';
import 'package:codedutravail/domain/entities/chapter.dart';
import 'package:codedutravail/domain/entities/section.dart';
import 'package:codedutravail/domain/entities/title.dart';
import 'package:codedutravail/presentation/home/providers/chapters.dart';
import 'package:codedutravail/presentation/home/providers/sections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitlesListWidget extends StatelessWidget {
  final List<TitleEntity> titles;

  const TitlesListWidget({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        final title = titles[index];
        return TitleExpansionTile(title: title);
      },
    );
  }
}

class TitleExpansionTile extends HookConsumerWidget {
  const TitleExpansionTile({super.key, required this.title});

  final TitleEntity title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(chaptersProvider(title.number));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text('Titre ${title.number.roman}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(title.text, maxLines: 2, overflow: TextOverflow.ellipsis),
        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        children: [
          if (title.articles.isNotEmpty)
            Column(
              children:
                  title.articles
                      .map(
                        (articleNumber) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ArticleWidget(number: articleNumber, maxLines: 3),
                        ),
                      )
                      .toList(),
            ),
          chaptersAsync.when(
            data: (chapters) {
              if (chapters.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Aucun chapitre disponible'),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Chapitres:', style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  ...chapters.map((chapter) => ChapterExpansionTile(chapter: chapter)),
                ],
              );
            },
            loading:
                () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.0)),
                  ),
                ),
            error:
                (error, _) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Erreur lors du chargement des chapitres: ${error.toString()}',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class ChapterExpansionTile extends HookConsumerWidget {
  final ChapterEntity chapter;

  const ChapterExpansionTile({super.key, required this.chapter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsAsync = ref.watch(sectionsProvider(chapter.titleNumber, chapter.number));
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text('Chapitre ${chapter.number.roman}', style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(chapter.text, maxLines: 2, overflow: TextOverflow.ellipsis),
        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
        children: [
          if (chapter.articles.isNotEmpty) ...[            
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Articles:', style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
            ),
            Column(
              children:
                  chapter.articles
                      .map(
                        (articleNumber) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ArticleWidget(number: articleNumber, maxLines: 3),
                        ),
                      )
                      .toList(),
            ),
          ],
          sectionsAsync.when(
            data: (sections) {
              if (sections.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Sections:', style: const TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  ...sections.map((section) => SectionExpansionTile(section: section)),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.0)),
              ),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Erreur lors du chargement des sections: ${error.toString()}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionExpansionTile extends StatelessWidget {
  final SectionEntity section;

  const SectionExpansionTile({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text('Section ${section.number.roman}', style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(section.text, maxLines: 2, overflow: TextOverflow.ellipsis),
        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
        children: [
          if (section.articles.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Articles:', style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
            ),
            Column(
              children:
                  section.articles
                      .map(
                        (articleNumber) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ArticleWidget(number: articleNumber, maxLines: 3),
                        ),
                      )
                      .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
