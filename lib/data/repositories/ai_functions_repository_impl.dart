import 'package:codedutravail/core/utils/lexical_search.dart';
import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:codedutravail/data/repositories/chapter_repository_impl.dart';
import 'package:codedutravail/data/repositories/section_repository_impl.dart';
import 'package:codedutravail/data/repositories/title_repository_impl.dart';
import 'package:codedutravail/domain/entities/chapter.dart';
import 'package:codedutravail/domain/repositories/artitle_repository.dart';
import 'package:codedutravail/domain/repositories/ai_functions_repository.dart';
import 'package:codedutravail/domain/repositories/chapter_repository.dart';
import 'package:codedutravail/domain/repositories/section_repository.dart';
import 'package:codedutravail/domain/repositories/title_repository.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_functions_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AiFunctionsRepository aiFunctionsRepository(Ref ref) {
  return AiFunctionsRepositoryImpl(
    ref.watch(titleRepositoryProvider),
    ref.watch(chapterRepositoryProvider),
    ref.watch(sectionRepositoryProvider),
    ref.watch(articleRepositoryProvider),
  );
}

class AiFunctionsRepositoryImpl with AiFunctionsRepository {
  final TitleRepository _titleRepository;
  final ChapterRepository _chapterRepository;
  final SectionRepository _sectionRepository;
  final ArticleRepository _articleRepository;

  AiFunctionsRepositoryImpl(
    this._titleRepository,
    this._chapterRepository,
    this._sectionRepository,
    this._articleRepository,
  );

  @override
  Future<Map<String, dynamic>> getCodeStructure() async {
    final titles = await _titleRepository.streamAll().first;
    final titleMaps = <Map<String, dynamic>>[];

    for (final title in titles) {
      final chapters = await _chapterRepository.streamByTitle(title.number).first;
      final chapterMaps = <Map<String, dynamic>>[];

      for (final chapter in chapters) {
        final sections = await _sectionRepository.streamByChapter(title.number, chapter.number).first;
        chapterMaps.add({
          'number': chapter.number,
          'name': chapter.text,
          if (sections.isNotEmpty) 'sections': sections.map((s) => {'number': s.number, 'name': s.text}).toList(),
        });
      }

      titleMaps.add({'number': title.number, 'name': title.text, 'chapters': chapterMaps});
    }

    return {'titles': titleMaps};
  }

  @override
  Future<List<Map<String, dynamic>>> searchArticles({
    required List<String> keywords,
    int? titleNumber,
    int? chapterNumber,
    int? sectionNumber,
    int limit = 5,
  }) async {
    final clampedLimit = limit.clamp(1, 10);
    final bound = await _resolveBound(
      titleNumber: titleNumber,
      chapterNumber: chapterNumber,
      sectionNumber: sectionNumber,
    );

    final allArticles = await _articleRepository.streamAll().first;
    final candidates = bound == null ? allArticles : allArticles.where((a) => bound.contains(a.number)).toList();

    if (keywords.isEmpty) {
      return candidates.take(clampedLimit).map((a) => {'number': a.number, 'text': a.text}).toList();
    }

    final query = keywords.join(' ');
    final matches = candidates.where((a) => matchesQuery('${a.text} ${a.slug}', query)).toList();
    return matches.take(clampedLimit).map((a) => {'number': a.number, 'text': a.text}).toList();
  }

  @override
  Future<Map<String, dynamic>?> getArticleByNumber(int number) async {
    try {
      final article = await _articleRepository.getArticleById(number);
      return {'number': article.number, 'text': article.text};
    } catch (_) {
      return null;
    }
  }

  /// Resolves a title/chapter/section bound into the concrete set of article
  /// numbers it covers. Returns null when no bound was given (search everything).
  ///
  /// Titles never carry articles directly in the source data (only `chapters:`),
  /// and a chapter's own `articles` list is empty whenever it has `sections:`
  /// instead — so bounding by title or chapter requires aggregating from children
  /// rather than reading a single row.
  Future<Set<int>?> _resolveBound({int? titleNumber, int? chapterNumber, int? sectionNumber}) async {
    if (titleNumber == null) return null;

    final chapters = await _chapterRepository.streamByTitle(titleNumber).first;

    if (chapterNumber == null) {
      final result = <int>{};
      for (final chapter in chapters) {
        result.addAll(await _resolveChapterArticles(chapter));
      }
      return result;
    }

    final chapter = chapters.firstWhereOrNull((c) => c.number == chapterNumber);
    if (chapter == null) return {};

    if (sectionNumber == null) {
      return _resolveChapterArticles(chapter);
    }

    final sections = await _sectionRepository.streamByChapter(titleNumber, chapterNumber).first;
    final section = sections.firstWhereOrNull((s) => s.number == sectionNumber);
    return section?.articles ?? {};
  }

  Future<Set<int>> _resolveChapterArticles(ChapterEntity chapter) async {
    if (chapter.articles.isNotEmpty) return chapter.articles;
    final sections = await _sectionRepository.streamByChapter(chapter.titleNumber, chapter.number).first;
    return sections.expand((s) => s.articles).toSet();
  }
}
