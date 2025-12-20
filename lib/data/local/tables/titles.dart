import 'package:codedutravail/data/local/converters/list_int_converter.dart';
import 'package:drift/drift.dart';

class Titles extends Table {
  late final number = integer()();

  TextColumn get title => text()();

  late final articles = text().map(const ListIntConverter())();

  @override
  Set<Column> get primaryKey => {number};
}
