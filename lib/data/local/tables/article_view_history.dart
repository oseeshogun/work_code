import 'package:drift/drift.dart';
import 'package:codedutravail/data/local/tables/articles.dart';

class ArticleViewHistory extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get articleNumber => integer().references(Articles, #number, onDelete: KeyAction.cascade)();

  DateTimeColumn get viewedAt => dateTime()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {articleNumber},
  ];
}
