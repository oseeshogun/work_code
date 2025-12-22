import 'package:drift/drift.dart';

class Articles extends Table {
  IntColumn get number => integer()();

  TextColumn get value => text()();

  TextColumn get valueSlug => text()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {number};
}
