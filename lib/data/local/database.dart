import 'dart:io';

import 'package:codedutravail/data/local/converters/list_int_converter.dart';
import 'package:codedutravail/data/local/database.steps.dart';
import 'package:codedutravail/data/local/tables/articles.dart';
import 'package:codedutravail/data/local/tables/chapters.dart';
import 'package:codedutravail/data/local/tables/sections.dart';
import 'package:codedutravail/data/local/tables/titles.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase db(Ref ref) => AppDatabase(
  DatabaseConnection.delayed(
    Future.sync(() async {
      final isolate = await createIsolateWithSpawn();
      return isolate.connect(singleClientMode: true);
    }),
  ),
);

@DriftDatabase(tables: [Titles, Chapters, Sections, Articles])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onUpgrade: _schemaUpgrade);
  }
}

extension Migrations on GeneratedDatabase {
  // Extracting the `stepByStep` call into a static field or method ensures that you're not
  // accidentally referring to the current database schema (via a getter on the database class).
  // This ensures that each step brings the database into the correct snapshot.
  OnUpgrade get _schemaUpgrade => stepByStep(
    from1To2: (m, schema) async {
      await m.addColumn(schema.articles, schema.articles.isFavorite);

      await m.createAll();
    },
  );
}

Future<DriftIsolate> createIsolateWithSpawn() async {
  final token = RootIsolateToken.instance;
  return await DriftIsolate.spawn(() {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);

    return _openConnection();
  });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file, logStatements: kDebugMode);
  });
}
