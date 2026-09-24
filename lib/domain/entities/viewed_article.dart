import 'package:codedutravail/domain/entities/article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'viewed_article.freezed.dart';

@freezed
abstract class ViewedArticleEntity with _$ViewedArticleEntity {
  const factory ViewedArticleEntity({required ArticleEntity article, required DateTime viewedAt}) =
      _ViewedArticleEntity;
}
