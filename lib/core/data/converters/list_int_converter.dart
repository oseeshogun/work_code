import 'package:drift/drift.dart';

class ListIntConverter extends TypeConverter<Set<int>, String> {
  const ListIntConverter();

  @override
  Set<int> fromSql(String fromDb) =>
      fromDb.split(',').where((i) => int.tryParse('i') != null).map((i) => int.parse(i)).toSet();

  @override
  String toSql(Set<int> value) => value.join(',');
}
