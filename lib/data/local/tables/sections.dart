import 'package:codedutravail/data/local/converters/list_int_converter.dart';
import 'package:codedutravail/data/local/tables/chapters.dart';
import 'package:drift/drift.dart';
import 'package:codedutravail/data/local/tables/titles.dart';

class Sections extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get number => integer()();

  TextColumn get value => text()();

  IntColumn get chapterId => integer().references(Chapters, #number)();

  IntColumn get titleId => integer().references(Titles, #number, onDelete: KeyAction.cascade)();

  TextColumn get articles => text().map(const ListIntConverter())();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {number, chapterId, titleId},
  ];
}
