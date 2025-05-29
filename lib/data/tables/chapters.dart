import 'package:codedutravail/data/converters/list_int_converter.dart';
import 'package:drift/drift.dart';
import 'package:codedutravail/data/tables/titles.dart';

class Chapters extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get number => integer()();

  TextColumn get value => text()();

  IntColumn get titleId => integer().references(Titles, #number, onDelete: KeyAction.cascade)();

  TextColumn get articles => text().map(const ListIntConverter())();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {number, titleId},
  ];
}
