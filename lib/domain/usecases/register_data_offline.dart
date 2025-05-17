import 'package:codedutravail/core/domain/usecases/usecase.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/data/repositories/chapter_repository_impl.dart';
import 'package:codedutravail/data/repositories/section_repository_impl.dart';
import 'package:codedutravail/data/repositories/title_repository_impl.dart';
import 'package:codedutravail/domain/entities/article.dart';
import 'package:codedutravail/domain/entities/chapter.dart';
import 'package:codedutravail/domain/entities/section.dart';
import 'package:codedutravail/domain/entities/title.dart';
import 'package:codedutravail/domain/repositories/artitle_repository.dart';
import 'package:codedutravail/domain/repositories/chapter_repository.dart';
import 'package:codedutravail/domain/repositories/section_repository.dart';
import 'package:codedutravail/domain/repositories/title_repository.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:yaml/yaml.dart';

part 'register_data_offline.g.dart';

@Riverpod(keepAlive: true)
RegisterDataOnOfflineUseCase registerDataOffline(Ref ref) {
  final TitleRepository titleRepository = ref.watch(titleRepositoryProvider);
  final SectionRepository sectionRepository = ref.watch(sectionRepositoryProvider);
  final ChapterRepository chapterRepository = ref.watch(chapterRepositoryProvider);
  final ArticleRepository articleRepository = ref.watch(articleRepositoryProvider);

  return RegisterDataOnOfflineUseCase(titleRepository, sectionRepository, chapterRepository, articleRepository);
}

class RegisterDataOnOfflineUseCase extends UseCase<void> {
  final TitleRepository _titleRepository;
  final SectionRepository _sectionRepository;
  final ChapterRepository _chapterRepository;
  final ArticleRepository _articleRepository;

  RegisterDataOnOfflineUseCase(
    this._titleRepository,
    this._sectionRepository,
    this._chapterRepository,
    this._articleRepository,
  );

  @override
  Future<void> execute() async {
    // Get YAML String from assets
    final String content = await rootBundle.loadString("assets/work_code.yaml");

    // Parse YAML content
    final YamlMap yamlData = await loadYaml(content) as YamlMap;

    // Extract and transform data
    final result = await _transformData(yamlData);

    // Save to database
    await _saveToDatabase(
      articles: result.articles,
      titles: result.titles,
      chapters: result.chapters,
      sections: result.sections,
    );
  }

  Future<_TransformedData> _transformData(YamlMap yamlData) async {
    final rawArticles = yamlData['articles'] as YamlList;
    final rawTitles = yamlData['titles'] as YamlList;

    // Transform to Entities
    final titles = <TitleEntity>[];
    final chapters = <ChapterEntity>[];
    final sections = <SectionEntity>[];
    final articles = <ArticleEntity>[];

    // Process articles
    for (final article in rawArticles) {
      final key = (article as YamlMap).keys.first.toString();
      final value = article.values.first.toString();

      final articleNumber = int.parse(key.replaceFirst('article_', ''));

      articles.add(ArticleEntity(number: articleNumber, text: value, slug: value.toLowerCase().toSlug));
    }

    // Process titles, chapters, and sections
    for (final title in rawTitles) {
      final key = (title as YamlMap).keys.first.toString();
      final value = title.values.first as YamlMap;

      final titleNumber = int.parse(key.replaceFirst('title_', ''));
      final titleArticles = _extractArticlesList(value['articles']);

      titles.add(TitleEntity(number: titleNumber, text: value['name'].toString(), articles: titleArticles));

      final rawChapters = value['chapters'] as YamlList? ?? YamlList();

      for (final chapter in rawChapters) {
        final chapKey = (chapter as YamlMap).keys.first.toString();
        final chapValue = chapter.values.first as YamlMap;

        final chapterNumber = int.parse(chapKey.replaceFirst('chapter_', ''));
        final chapterArticles = _extractArticlesList(chapValue['articles']);

        chapters.add(
          ChapterEntity(
            number: chapterNumber,
            text: chapValue['name'].toString(),
            titleNumber: titleNumber,
            articles: chapterArticles,
          ),
        );

        final rawSections = chapValue['sections'] as YamlList? ?? YamlList();

        for (final section in rawSections) {
          final secKey = (section as YamlMap).keys.first.toString();
          final secValue = section.values.first as YamlMap;

          final sectionNumber = int.parse(secKey.replaceFirst('section_', ''));
          final sectionArticles = _extractArticlesList(secValue['articles']);

          sections.add(
            SectionEntity(
              number: sectionNumber,
              text: secValue['name'].toString(),
              chapterNumber: chapterNumber,
              titleNumber: titleNumber,
              articles: sectionArticles,
            ),
          );
        }
      }
    }

    return _TransformedData(titles: titles, chapters: chapters, sections: sections, articles: articles);
  }

  Set<int> _extractArticlesList(dynamic articlesData) {
    if (articlesData == null) return {};

    final articles = articlesData as YamlList;
    return articles.map((item) => item as int).toSet();
  }

  Future<void> _saveToDatabase({
    required List<ArticleEntity> articles,
    required List<TitleEntity> titles,
    required List<ChapterEntity> chapters,
    required List<SectionEntity> sections,
  }) async {
    await _articleRepository.insertAll(articles);
    await _titleRepository.insertAll(titles);
    await _chapterRepository.insertAll(chapters);
    await _sectionRepository.insertAll(sections);
  }
}

class _TransformedData {
  final List<TitleEntity> titles;
  final List<ChapterEntity> chapters;
  final List<SectionEntity> sections;
  final List<ArticleEntity> articles;

  _TransformedData({required this.titles, required this.chapters, required this.sections, required this.articles});
}
