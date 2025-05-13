import 'package:drift/drift.dart';

class Articles extends Table {
  IntColumn get number => integer()();

  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {number};
}
