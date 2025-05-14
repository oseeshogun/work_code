import 'dart:io';

import 'package:codedutravail/core/data/converters/list_int_converter.dart';
import 'package:codedutravail/data/tables/articles.dart';
import 'package:codedutravail/data/tables/chapters.dart';
import 'package:codedutravail/data/tables/sections.dart';
import 'package:codedutravail/data/tables/titles.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  int get schemaVersion => 1;
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
