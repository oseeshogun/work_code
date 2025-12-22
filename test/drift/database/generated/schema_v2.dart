// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Titles extends Table with TableInfo<Titles, TitlesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Titles(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> articles = GeneratedColumn<String>(
    'articles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [number, title, articles];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'titles';
  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  TitlesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TitlesData(
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      articles:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}articles'],
          )!,
    );
  }

  @override
  Titles createAlias(String alias) {
    return Titles(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(number)'];
  @override
  bool get dontWriteConstraints => true;
}

class TitlesData extends DataClass implements Insertable<TitlesData> {
  final int number;
  final String title;
  final String articles;
  const TitlesData({
    required this.number,
    required this.title,
    required this.articles,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['title'] = Variable<String>(title);
    map['articles'] = Variable<String>(articles);
    return map;
  }

  TitlesCompanion toCompanion(bool nullToAbsent) {
    return TitlesCompanion(
      number: Value(number),
      title: Value(title),
      articles: Value(articles),
    );
  }

  factory TitlesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TitlesData(
      number: serializer.fromJson<int>(json['number']),
      title: serializer.fromJson<String>(json['title']),
      articles: serializer.fromJson<String>(json['articles']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'title': serializer.toJson<String>(title),
      'articles': serializer.toJson<String>(articles),
    };
  }

  TitlesData copyWith({int? number, String? title, String? articles}) =>
      TitlesData(
        number: number ?? this.number,
        title: title ?? this.title,
        articles: articles ?? this.articles,
      );
  TitlesData copyWithCompanion(TitlesCompanion data) {
    return TitlesData(
      number: data.number.present ? data.number.value : this.number,
      title: data.title.present ? data.title.value : this.title,
      articles: data.articles.present ? data.articles.value : this.articles,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TitlesData(')
          ..write('number: $number, ')
          ..write('title: $title, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(number, title, articles);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TitlesData &&
          other.number == this.number &&
          other.title == this.title &&
          other.articles == this.articles);
}

class TitlesCompanion extends UpdateCompanion<TitlesData> {
  final Value<int> number;
  final Value<String> title;
  final Value<String> articles;
  const TitlesCompanion({
    this.number = const Value.absent(),
    this.title = const Value.absent(),
    this.articles = const Value.absent(),
  });
  TitlesCompanion.insert({
    this.number = const Value.absent(),
    required String title,
    required String articles,
  }) : title = Value(title),
       articles = Value(articles);
  static Insertable<TitlesData> custom({
    Expression<int>? number,
    Expression<String>? title,
    Expression<String>? articles,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (title != null) 'title': title,
      if (articles != null) 'articles': articles,
    });
  }

  TitlesCompanion copyWith({
    Value<int>? number,
    Value<String>? title,
    Value<String>? articles,
  }) {
    return TitlesCompanion(
      number: number ?? this.number,
      title: title ?? this.title,
      articles: articles ?? this.articles,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (articles.present) {
      map['articles'] = Variable<String>(articles.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TitlesCompanion(')
          ..write('number: $number, ')
          ..write('title: $title, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }
}

class Chapters extends Table with TableInfo<Chapters, ChaptersData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Chapters(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> titleId = GeneratedColumn<int>(
    'title_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES titles(number)ON DELETE CASCADE',
  );
  late final GeneratedColumn<String> articles = GeneratedColumn<String>(
    'articles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, number, value, titleId, articles];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {number, titleId},
  ];
  @override
  ChaptersData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChaptersData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      titleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}title_id'],
          )!,
      articles:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}articles'],
          )!,
    );
  }

  @override
  Chapters createAlias(String alias) {
    return Chapters(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(number, title_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChaptersData extends DataClass implements Insertable<ChaptersData> {
  final int id;
  final int number;
  final String value;
  final int titleId;
  final String articles;
  const ChaptersData({
    required this.id,
    required this.number,
    required this.value,
    required this.titleId,
    required this.articles,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<int>(number);
    map['value'] = Variable<String>(value);
    map['title_id'] = Variable<int>(titleId);
    map['articles'] = Variable<String>(articles);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      number: Value(number),
      value: Value(value),
      titleId: Value(titleId),
      articles: Value(articles),
    );
  }

  factory ChaptersData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChaptersData(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
      titleId: serializer.fromJson<int>(json['titleId']),
      articles: serializer.fromJson<String>(json['articles']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<int>(number),
      'value': serializer.toJson<String>(value),
      'titleId': serializer.toJson<int>(titleId),
      'articles': serializer.toJson<String>(articles),
    };
  }

  ChaptersData copyWith({
    int? id,
    int? number,
    String? value,
    int? titleId,
    String? articles,
  }) => ChaptersData(
    id: id ?? this.id,
    number: number ?? this.number,
    value: value ?? this.value,
    titleId: titleId ?? this.titleId,
    articles: articles ?? this.articles,
  );
  ChaptersData copyWithCompanion(ChaptersCompanion data) {
    return ChaptersData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      value: data.value.present ? data.value.value : this.value,
      titleId: data.titleId.present ? data.titleId.value : this.titleId,
      articles: data.articles.present ? data.articles.value : this.articles,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('titleId: $titleId, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, value, titleId, articles);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChaptersData &&
          other.id == this.id &&
          other.number == this.number &&
          other.value == this.value &&
          other.titleId == this.titleId &&
          other.articles == this.articles);
}

class ChaptersCompanion extends UpdateCompanion<ChaptersData> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> value;
  final Value<int> titleId;
  final Value<String> articles;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.value = const Value.absent(),
    this.titleId = const Value.absent(),
    this.articles = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required int number,
    required String value,
    required int titleId,
    required String articles,
  }) : number = Value(number),
       value = Value(value),
       titleId = Value(titleId),
       articles = Value(articles);
  static Insertable<ChaptersData> custom({
    Expression<int>? id,
    Expression<int>? number,
    Expression<String>? value,
    Expression<int>? titleId,
    Expression<String>? articles,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (value != null) 'value': value,
      if (titleId != null) 'title_id': titleId,
      if (articles != null) 'articles': articles,
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<int>? number,
    Value<String>? value,
    Value<int>? titleId,
    Value<String>? articles,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      value: value ?? this.value,
      titleId: titleId ?? this.titleId,
      articles: articles ?? this.articles,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (titleId.present) {
      map['title_id'] = Variable<int>(titleId.value);
    }
    if (articles.present) {
      map['articles'] = Variable<String>(articles.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('titleId: $titleId, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }
}

class Sections extends Table with TableInfo<Sections, SectionsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Sections(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES chapters(number)',
  );
  late final GeneratedColumn<int> titleId = GeneratedColumn<int>(
    'title_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES titles(number)ON DELETE CASCADE',
  );
  late final GeneratedColumn<String> articles = GeneratedColumn<String>(
    'articles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    number,
    value,
    chapterId,
    titleId,
    articles,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {number, chapterId, titleId},
  ];
  @override
  SectionsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionsData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      chapterId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter_id'],
          )!,
      titleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}title_id'],
          )!,
      articles:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}articles'],
          )!,
    );
  }

  @override
  Sections createAlias(String alias) {
    return Sections(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(number, chapter_id, title_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class SectionsData extends DataClass implements Insertable<SectionsData> {
  final int id;
  final int number;
  final String value;
  final int chapterId;
  final int titleId;
  final String articles;
  const SectionsData({
    required this.id,
    required this.number,
    required this.value,
    required this.chapterId,
    required this.titleId,
    required this.articles,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<int>(number);
    map['value'] = Variable<String>(value);
    map['chapter_id'] = Variable<int>(chapterId);
    map['title_id'] = Variable<int>(titleId);
    map['articles'] = Variable<String>(articles);
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      number: Value(number),
      value: Value(value),
      chapterId: Value(chapterId),
      titleId: Value(titleId),
      articles: Value(articles),
    );
  }

  factory SectionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionsData(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      titleId: serializer.fromJson<int>(json['titleId']),
      articles: serializer.fromJson<String>(json['articles']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<int>(number),
      'value': serializer.toJson<String>(value),
      'chapterId': serializer.toJson<int>(chapterId),
      'titleId': serializer.toJson<int>(titleId),
      'articles': serializer.toJson<String>(articles),
    };
  }

  SectionsData copyWith({
    int? id,
    int? number,
    String? value,
    int? chapterId,
    int? titleId,
    String? articles,
  }) => SectionsData(
    id: id ?? this.id,
    number: number ?? this.number,
    value: value ?? this.value,
    chapterId: chapterId ?? this.chapterId,
    titleId: titleId ?? this.titleId,
    articles: articles ?? this.articles,
  );
  SectionsData copyWithCompanion(SectionsCompanion data) {
    return SectionsData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      value: data.value.present ? data.value.value : this.value,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      titleId: data.titleId.present ? data.titleId.value : this.titleId,
      articles: data.articles.present ? data.articles.value : this.articles,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionsData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('chapterId: $chapterId, ')
          ..write('titleId: $titleId, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, number, value, chapterId, titleId, articles);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionsData &&
          other.id == this.id &&
          other.number == this.number &&
          other.value == this.value &&
          other.chapterId == this.chapterId &&
          other.titleId == this.titleId &&
          other.articles == this.articles);
}

class SectionsCompanion extends UpdateCompanion<SectionsData> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> value;
  final Value<int> chapterId;
  final Value<int> titleId;
  final Value<String> articles;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.value = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.titleId = const Value.absent(),
    this.articles = const Value.absent(),
  });
  SectionsCompanion.insert({
    this.id = const Value.absent(),
    required int number,
    required String value,
    required int chapterId,
    required int titleId,
    required String articles,
  }) : number = Value(number),
       value = Value(value),
       chapterId = Value(chapterId),
       titleId = Value(titleId),
       articles = Value(articles);
  static Insertable<SectionsData> custom({
    Expression<int>? id,
    Expression<int>? number,
    Expression<String>? value,
    Expression<int>? chapterId,
    Expression<int>? titleId,
    Expression<String>? articles,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (value != null) 'value': value,
      if (chapterId != null) 'chapter_id': chapterId,
      if (titleId != null) 'title_id': titleId,
      if (articles != null) 'articles': articles,
    });
  }

  SectionsCompanion copyWith({
    Value<int>? id,
    Value<int>? number,
    Value<String>? value,
    Value<int>? chapterId,
    Value<int>? titleId,
    Value<String>? articles,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      value: value ?? this.value,
      chapterId: chapterId ?? this.chapterId,
      titleId: titleId ?? this.titleId,
      articles: articles ?? this.articles,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (titleId.present) {
      map['title_id'] = Variable<int>(titleId.value);
    }
    if (articles.present) {
      map['articles'] = Variable<String>(articles.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('chapterId: $chapterId, ')
          ..write('titleId: $titleId, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }
}

class Articles extends Table with TableInfo<Articles, ArticlesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Articles(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> valueSlug = GeneratedColumn<String>(
    'value_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (is_favorite IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [number, value, valueSlug, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  ArticlesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticlesData(
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      valueSlug:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value_slug'],
          )!,
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_favorite'],
          )!,
    );
  }

  @override
  Articles createAlias(String alias) {
    return Articles(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(number)'];
  @override
  bool get dontWriteConstraints => true;
}

class ArticlesData extends DataClass implements Insertable<ArticlesData> {
  final int number;
  final String value;
  final String valueSlug;
  final int isFavorite;
  const ArticlesData({
    required this.number,
    required this.value,
    required this.valueSlug,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['value'] = Variable<String>(value);
    map['value_slug'] = Variable<String>(valueSlug);
    map['is_favorite'] = Variable<int>(isFavorite);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      number: Value(number),
      value: Value(value),
      valueSlug: Value(valueSlug),
      isFavorite: Value(isFavorite),
    );
  }

  factory ArticlesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticlesData(
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
      valueSlug: serializer.fromJson<String>(json['valueSlug']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'value': serializer.toJson<String>(value),
      'valueSlug': serializer.toJson<String>(valueSlug),
      'isFavorite': serializer.toJson<int>(isFavorite),
    };
  }

  ArticlesData copyWith({
    int? number,
    String? value,
    String? valueSlug,
    int? isFavorite,
  }) => ArticlesData(
    number: number ?? this.number,
    value: value ?? this.value,
    valueSlug: valueSlug ?? this.valueSlug,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  ArticlesData copyWithCompanion(ArticlesCompanion data) {
    return ArticlesData(
      number: data.number.present ? data.number.value : this.number,
      value: data.value.present ? data.value.value : this.value,
      valueSlug: data.valueSlug.present ? data.valueSlug.value : this.valueSlug,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesData(')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('valueSlug: $valueSlug, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(number, value, valueSlug, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticlesData &&
          other.number == this.number &&
          other.value == this.value &&
          other.valueSlug == this.valueSlug &&
          other.isFavorite == this.isFavorite);
}

class ArticlesCompanion extends UpdateCompanion<ArticlesData> {
  final Value<int> number;
  final Value<String> value;
  final Value<String> valueSlug;
  final Value<int> isFavorite;
  const ArticlesCompanion({
    this.number = const Value.absent(),
    this.value = const Value.absent(),
    this.valueSlug = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.number = const Value.absent(),
    required String value,
    required String valueSlug,
    this.isFavorite = const Value.absent(),
  }) : value = Value(value),
       valueSlug = Value(valueSlug);
  static Insertable<ArticlesData> custom({
    Expression<int>? number,
    Expression<String>? value,
    Expression<String>? valueSlug,
    Expression<int>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (value != null) 'value': value,
      if (valueSlug != null) 'value_slug': valueSlug,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  ArticlesCompanion copyWith({
    Value<int>? number,
    Value<String>? value,
    Value<String>? valueSlug,
    Value<int>? isFavorite,
  }) {
    return ArticlesCompanion(
      number: number ?? this.number,
      value: value ?? this.value,
      valueSlug: valueSlug ?? this.valueSlug,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (valueSlug.present) {
      map['value_slug'] = Variable<String>(valueSlug.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('number: $number, ')
          ..write('value: $value, ')
          ..write('valueSlug: $valueSlug, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final Titles titles = Titles(this);
  late final Chapters chapters = Chapters(this);
  late final Sections sections = Sections(this);
  late final Articles articles = Articles(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    titles,
    chapters,
    sections,
    articles,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'titles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chapters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'titles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sections', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  int get schemaVersion => 2;
}
