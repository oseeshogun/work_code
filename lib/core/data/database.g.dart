// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TitlesTable extends Titles with TableInfo<$TitlesTable, Title> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TitlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Set<int>, String> articles =
      GeneratedColumn<String>(
        'articles',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<int>>($TitlesTable.$converterarticles);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [number, articles, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'titles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Title> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  Title map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Title(
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      articles: $TitlesTable.$converterarticles.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}articles'],
        )!,
      ),
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
    );
  }

  @override
  $TitlesTable createAlias(String alias) {
    return $TitlesTable(attachedDatabase, alias);
  }

  static TypeConverter<Set<int>, String> $converterarticles =
      const ListIntConverter();
}

class Title extends DataClass implements Insertable<Title> {
  final int number;
  final Set<int> articles;
  final String title;
  const Title({
    required this.number,
    required this.articles,
    required this.title,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    {
      map['articles'] = Variable<String>(
        $TitlesTable.$converterarticles.toSql(articles),
      );
    }
    map['title'] = Variable<String>(title);
    return map;
  }

  TitlesCompanion toCompanion(bool nullToAbsent) {
    return TitlesCompanion(
      number: Value(number),
      articles: Value(articles),
      title: Value(title),
    );
  }

  factory Title.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Title(
      number: serializer.fromJson<int>(json['number']),
      articles: serializer.fromJson<Set<int>>(json['articles']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'articles': serializer.toJson<Set<int>>(articles),
      'title': serializer.toJson<String>(title),
    };
  }

  Title copyWith({int? number, Set<int>? articles, String? title}) => Title(
    number: number ?? this.number,
    articles: articles ?? this.articles,
    title: title ?? this.title,
  );
  Title copyWithCompanion(TitlesCompanion data) {
    return Title(
      number: data.number.present ? data.number.value : this.number,
      articles: data.articles.present ? data.articles.value : this.articles,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Title(')
          ..write('number: $number, ')
          ..write('articles: $articles, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(number, articles, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Title &&
          other.number == this.number &&
          other.articles == this.articles &&
          other.title == this.title);
}

class TitlesCompanion extends UpdateCompanion<Title> {
  final Value<int> number;
  final Value<Set<int>> articles;
  final Value<String> title;
  const TitlesCompanion({
    this.number = const Value.absent(),
    this.articles = const Value.absent(),
    this.title = const Value.absent(),
  });
  TitlesCompanion.insert({
    this.number = const Value.absent(),
    required Set<int> articles,
    required String title,
  }) : articles = Value(articles),
       title = Value(title);
  static Insertable<Title> custom({
    Expression<int>? number,
    Expression<String>? articles,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (articles != null) 'articles': articles,
      if (title != null) 'title': title,
    });
  }

  TitlesCompanion copyWith({
    Value<int>? number,
    Value<Set<int>>? articles,
    Value<String>? title,
  }) {
    return TitlesCompanion(
      number: number ?? this.number,
      articles: articles ?? this.articles,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (articles.present) {
      map['articles'] = Variable<String>(
        $TitlesTable.$converterarticles.toSql(articles.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TitlesCompanion(')
          ..write('number: $number, ')
          ..write('articles: $articles, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleIdMeta = const VerificationMeta(
    'titleId',
  );
  @override
  late final GeneratedColumn<int> titleId = GeneratedColumn<int>(
    'title_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES titles (number) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Set<int>, String> articles =
      GeneratedColumn<String>(
        'articles',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<int>>($ChaptersTable.$converterarticles);
  @override
  List<GeneratedColumn> get $columns => [id, number, value, titleId, articles];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('title_id')) {
      context.handle(
        _titleIdMeta,
        titleId.isAcceptableOrUnknown(data['title_id']!, _titleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_titleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {number, titleId},
  ];
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
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
      articles: $ChaptersTable.$converterarticles.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}articles'],
        )!,
      ),
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }

  static TypeConverter<Set<int>, String> $converterarticles =
      const ListIntConverter();
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final int number;
  final String value;
  final int titleId;
  final Set<int> articles;
  const Chapter({
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
    {
      map['articles'] = Variable<String>(
        $ChaptersTable.$converterarticles.toSql(articles),
      );
    }
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

  factory Chapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
      titleId: serializer.fromJson<int>(json['titleId']),
      articles: serializer.fromJson<Set<int>>(json['articles']),
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
      'articles': serializer.toJson<Set<int>>(articles),
    };
  }

  Chapter copyWith({
    int? id,
    int? number,
    String? value,
    int? titleId,
    Set<int>? articles,
  }) => Chapter(
    id: id ?? this.id,
    number: number ?? this.number,
    value: value ?? this.value,
    titleId: titleId ?? this.titleId,
    articles: articles ?? this.articles,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      value: data.value.present ? data.value.value : this.value,
      titleId: data.titleId.present ? data.titleId.value : this.titleId,
      articles: data.articles.present ? data.articles.value : this.articles,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
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
      (other is Chapter &&
          other.id == this.id &&
          other.number == this.number &&
          other.value == this.value &&
          other.titleId == this.titleId &&
          other.articles == this.articles);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> value;
  final Value<int> titleId;
  final Value<Set<int>> articles;
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
    required Set<int> articles,
  }) : number = Value(number),
       value = Value(value),
       titleId = Value(titleId),
       articles = Value(articles);
  static Insertable<Chapter> custom({
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
    Value<Set<int>>? articles,
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
      map['articles'] = Variable<String>(
        $ChaptersTable.$converterarticles.toSql(articles.value),
      );
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

class $SectionsTable extends Sections with TableInfo<$SectionsTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (number)',
    ),
  );
  static const VerificationMeta _titleIdMeta = const VerificationMeta(
    'titleId',
  );
  @override
  late final GeneratedColumn<int> titleId = GeneratedColumn<int>(
    'title_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES titles (number) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Set<int>, String> articles =
      GeneratedColumn<String>(
        'articles',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<int>>($SectionsTable.$converterarticles);
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
  VerificationContext validateIntegrity(
    Insertable<Section> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('title_id')) {
      context.handle(
        _titleIdMeta,
        titleId.isAcceptableOrUnknown(data['title_id']!, _titleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_titleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {number, chapterId, titleId},
  ];
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
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
      articles: $SectionsTable.$converterarticles.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}articles'],
        )!,
      ),
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }

  static TypeConverter<Set<int>, String> $converterarticles =
      const ListIntConverter();
}

class Section extends DataClass implements Insertable<Section> {
  final int id;
  final int number;
  final String value;
  final int chapterId;
  final int titleId;
  final Set<int> articles;
  const Section({
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
    {
      map['articles'] = Variable<String>(
        $SectionsTable.$converterarticles.toSql(articles),
      );
    }
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

  factory Section.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      titleId: serializer.fromJson<int>(json['titleId']),
      articles: serializer.fromJson<Set<int>>(json['articles']),
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
      'articles': serializer.toJson<Set<int>>(articles),
    };
  }

  Section copyWith({
    int? id,
    int? number,
    String? value,
    int? chapterId,
    int? titleId,
    Set<int>? articles,
  }) => Section(
    id: id ?? this.id,
    number: number ?? this.number,
    value: value ?? this.value,
    chapterId: chapterId ?? this.chapterId,
    titleId: titleId ?? this.titleId,
    articles: articles ?? this.articles,
  );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
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
    return (StringBuffer('Section(')
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
      (other is Section &&
          other.id == this.id &&
          other.number == this.number &&
          other.value == this.value &&
          other.chapterId == this.chapterId &&
          other.titleId == this.titleId &&
          other.articles == this.articles);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> value;
  final Value<int> chapterId;
  final Value<int> titleId;
  final Value<Set<int>> articles;
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
    required Set<int> articles,
  }) : number = Value(number),
       value = Value(value),
       chapterId = Value(chapterId),
       titleId = Value(titleId),
       articles = Value(articles);
  static Insertable<Section> custom({
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
    Value<Set<int>>? articles,
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
      map['articles'] = Variable<String>(
        $SectionsTable.$converterarticles.toSql(articles.value),
      );
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

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [number, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Article> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
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
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final int number;
  final String value;
  const Article({required this.number, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['value'] = Variable<String>(value);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(number: Value(number), value: Value(value));
  }

  factory Article.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      number: serializer.fromJson<int>(json['number']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'value': serializer.toJson<String>(value),
    };
  }

  Article copyWith({int? number, String? value}) =>
      Article(number: number ?? this.number, value: value ?? this.value);
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      number: data.number.present ? data.number.value : this.number,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('number: $number, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(number, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.number == this.number &&
          other.value == this.value);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> number;
  final Value<String> value;
  const ArticlesCompanion({
    this.number = const Value.absent(),
    this.value = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.number = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<Article> custom({
    Expression<int>? number,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (value != null) 'value': value,
    });
  }

  ArticlesCompanion copyWith({Value<int>? number, Value<String>? value}) {
    return ArticlesCompanion(
      number: number ?? this.number,
      value: value ?? this.value,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('number: $number, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TitlesTable titles = $TitlesTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
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
}

typedef $$TitlesTableCreateCompanionBuilder =
    TitlesCompanion Function({
      Value<int> number,
      required Set<int> articles,
      required String title,
    });
typedef $$TitlesTableUpdateCompanionBuilder =
    TitlesCompanion Function({
      Value<int> number,
      Value<Set<int>> articles,
      Value<String> title,
    });

final class $$TitlesTableReferences
    extends BaseReferences<_$AppDatabase, $TitlesTable, Title> {
  $$TitlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChaptersTable, List<Chapter>> _chaptersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.chapters,
    aliasName: $_aliasNameGenerator(db.titles.number, db.chapters.titleId),
  );

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.titleId.number.sqlEquals($_itemColumn<int>('number')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SectionsTable, List<Section>> _sectionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sections,
    aliasName: $_aliasNameGenerator(db.titles.number, db.sections.titleId),
  );

  $$SectionsTableProcessedTableManager get sectionsRefs {
    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.titleId.number.sqlEquals($_itemColumn<int>('number')!));

    final cache = $_typedResult.readTableOrNull(_sectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TitlesTableFilterComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<int>, Set<int>, String> get articles =>
      $composableBuilder(
        column: $table.articles,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chaptersRefs(
    Expression<bool> Function($$ChaptersTableFilterComposer f) f,
  ) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.titleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sectionsRefs(
    Expression<bool> Function($$SectionsTableFilterComposer f) f,
  ) {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.titleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TitlesTableOrderingComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articles => $composableBuilder(
    column: $table.articles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TitlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Set<int>, String> get articles =>
      $composableBuilder(column: $table.articles, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  Expression<T> chaptersRefs<T extends Object>(
    Expression<T> Function($$ChaptersTableAnnotationComposer a) f,
  ) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.titleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sectionsRefs<T extends Object>(
    Expression<T> Function($$SectionsTableAnnotationComposer a) f,
  ) {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.titleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TitlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TitlesTable,
          Title,
          $$TitlesTableFilterComposer,
          $$TitlesTableOrderingComposer,
          $$TitlesTableAnnotationComposer,
          $$TitlesTableCreateCompanionBuilder,
          $$TitlesTableUpdateCompanionBuilder,
          (Title, $$TitlesTableReferences),
          Title,
          PrefetchHooks Function({bool chaptersRefs, bool sectionsRefs})
        > {
  $$TitlesTableTableManager(_$AppDatabase db, $TitlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TitlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TitlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TitlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<Set<int>> articles = const Value.absent(),
                Value<String> title = const Value.absent(),
              }) => TitlesCompanion(
                number: number,
                articles: articles,
                title: title,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required Set<int> articles,
                required String title,
              }) => TitlesCompanion.insert(
                number: number,
                articles: articles,
                title: title,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TitlesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            chaptersRefs = false,
            sectionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chaptersRefs) db.chapters,
                if (sectionsRefs) db.sections,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chaptersRefs)
                    await $_getPrefetchedData<Title, $TitlesTable, Chapter>(
                      currentTable: table,
                      referencedTable: $$TitlesTableReferences
                          ._chaptersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TitlesTableReferences(
                                db,
                                table,
                                p0,
                              ).chaptersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.titleId == item.number,
                          ),
                      typedResults: items,
                    ),
                  if (sectionsRefs)
                    await $_getPrefetchedData<Title, $TitlesTable, Section>(
                      currentTable: table,
                      referencedTable: $$TitlesTableReferences
                          ._sectionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TitlesTableReferences(
                                db,
                                table,
                                p0,
                              ).sectionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.titleId == item.number,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TitlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TitlesTable,
      Title,
      $$TitlesTableFilterComposer,
      $$TitlesTableOrderingComposer,
      $$TitlesTableAnnotationComposer,
      $$TitlesTableCreateCompanionBuilder,
      $$TitlesTableUpdateCompanionBuilder,
      (Title, $$TitlesTableReferences),
      Title,
      PrefetchHooks Function({bool chaptersRefs, bool sectionsRefs})
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required int number,
      required String value,
      required int titleId,
      required Set<int> articles,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<int> number,
      Value<String> value,
      Value<int> titleId,
      Value<Set<int>> articles,
    });

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TitlesTable _titleIdTable(_$AppDatabase db) => db.titles.createAlias(
    $_aliasNameGenerator(db.chapters.titleId, db.titles.number),
  );

  $$TitlesTableProcessedTableManager get titleId {
    final $_column = $_itemColumn<int>('title_id')!;

    final manager = $$TitlesTableTableManager(
      $_db,
      $_db.titles,
    ).filter((f) => f.number.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_titleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SectionsTable, List<Section>> _sectionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sections,
    aliasName: $_aliasNameGenerator(db.chapters.number, db.sections.chapterId),
  );

  $$SectionsTableProcessedTableManager get sectionsRefs {
    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.chapterId.number.sqlEquals($_itemColumn<int>('number')!));

    final cache = $_typedResult.readTableOrNull(_sectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<int>, Set<int>, String> get articles =>
      $composableBuilder(
        column: $table.articles,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$TitlesTableFilterComposer get titleId {
    final $$TitlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableFilterComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sectionsRefs(
    Expression<bool> Function($$SectionsTableFilterComposer f) f,
  ) {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articles => $composableBuilder(
    column: $table.articles,
    builder: (column) => ColumnOrderings(column),
  );

  $$TitlesTableOrderingComposer get titleId {
    final $$TitlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableOrderingComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Set<int>, String> get articles =>
      $composableBuilder(column: $table.articles, builder: (column) => column);

  $$TitlesTableAnnotationComposer get titleId {
    final $$TitlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableAnnotationComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sectionsRefs<T extends Object>(
    Expression<T> Function($$SectionsTableAnnotationComposer a) f,
  ) {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, $$ChaptersTableReferences),
          Chapter,
          PrefetchHooks Function({bool titleId, bool sectionsRefs})
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> titleId = const Value.absent(),
                Value<Set<int>> articles = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                number: number,
                value: value,
                titleId: titleId,
                articles: articles,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int number,
                required String value,
                required int titleId,
                required Set<int> articles,
              }) => ChaptersCompanion.insert(
                id: id,
                number: number,
                value: value,
                titleId: titleId,
                articles: articles,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ChaptersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({titleId = false, sectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sectionsRefs) db.sections],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (titleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.titleId,
                            referencedTable: $$ChaptersTableReferences
                                ._titleIdTable(db),
                            referencedColumn:
                                $$ChaptersTableReferences
                                    ._titleIdTable(db)
                                    .number,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, Section>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences
                          ._sectionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).sectionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.chapterId == item.number,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, $$ChaptersTableReferences),
      Chapter,
      PrefetchHooks Function({bool titleId, bool sectionsRefs})
    >;
typedef $$SectionsTableCreateCompanionBuilder =
    SectionsCompanion Function({
      Value<int> id,
      required int number,
      required String value,
      required int chapterId,
      required int titleId,
      required Set<int> articles,
    });
typedef $$SectionsTableUpdateCompanionBuilder =
    SectionsCompanion Function({
      Value<int> id,
      Value<int> number,
      Value<String> value,
      Value<int> chapterId,
      Value<int> titleId,
      Value<Set<int>> articles,
    });

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, Section> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias(
        $_aliasNameGenerator(db.sections.chapterId, db.chapters.number),
      );

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.number.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TitlesTable _titleIdTable(_$AppDatabase db) => db.titles.createAlias(
    $_aliasNameGenerator(db.sections.titleId, db.titles.number),
  );

  $$TitlesTableProcessedTableManager get titleId {
    final $_column = $_itemColumn<int>('title_id')!;

    final manager = $$TitlesTableTableManager(
      $_db,
      $_db.titles,
    ).filter((f) => f.number.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_titleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<int>, Set<int>, String> get articles =>
      $composableBuilder(
        column: $table.articles,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TitlesTableFilterComposer get titleId {
    final $$TitlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableFilterComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articles => $composableBuilder(
    column: $table.articles,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TitlesTableOrderingComposer get titleId {
    final $$TitlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableOrderingComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Set<int>, String> get articles =>
      $composableBuilder(column: $table.articles, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TitlesTableAnnotationComposer get titleId {
    final $$TitlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.titleId,
      referencedTable: $db.titles,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TitlesTableAnnotationComposer(
            $db: $db,
            $table: $db.titles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionsTable,
          Section,
          $$SectionsTableFilterComposer,
          $$SectionsTableOrderingComposer,
          $$SectionsTableAnnotationComposer,
          $$SectionsTableCreateCompanionBuilder,
          $$SectionsTableUpdateCompanionBuilder,
          (Section, $$SectionsTableReferences),
          Section,
          PrefetchHooks Function({bool chapterId, bool titleId})
        > {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> chapterId = const Value.absent(),
                Value<int> titleId = const Value.absent(),
                Value<Set<int>> articles = const Value.absent(),
              }) => SectionsCompanion(
                id: id,
                number: number,
                value: value,
                chapterId: chapterId,
                titleId: titleId,
                articles: articles,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int number,
                required String value,
                required int chapterId,
                required int titleId,
                required Set<int> articles,
              }) => SectionsCompanion.insert(
                id: id,
                number: number,
                value: value,
                chapterId: chapterId,
                titleId: titleId,
                articles: articles,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SectionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({chapterId = false, titleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$SectionsTableReferences
                                ._chapterIdTable(db),
                            referencedColumn:
                                $$SectionsTableReferences
                                    ._chapterIdTable(db)
                                    .number,
                          )
                          as T;
                }
                if (titleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.titleId,
                            referencedTable: $$SectionsTableReferences
                                ._titleIdTable(db),
                            referencedColumn:
                                $$SectionsTableReferences
                                    ._titleIdTable(db)
                                    .number,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionsTable,
      Section,
      $$SectionsTableFilterComposer,
      $$SectionsTableOrderingComposer,
      $$SectionsTableAnnotationComposer,
      $$SectionsTableCreateCompanionBuilder,
      $$SectionsTableUpdateCompanionBuilder,
      (Section, $$SectionsTableReferences),
      Section,
      PrefetchHooks Function({bool chapterId, bool titleId})
    >;
typedef $$ArticlesTableCreateCompanionBuilder =
    ArticlesCompanion Function({Value<int> number, required String value});
typedef $$ArticlesTableUpdateCompanionBuilder =
    ArticlesCompanion Function({Value<int> number, Value<String> value});

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$ArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTable,
          Article,
          $$ArticlesTableFilterComposer,
          $$ArticlesTableOrderingComposer,
          $$ArticlesTableAnnotationComposer,
          $$ArticlesTableCreateCompanionBuilder,
          $$ArticlesTableUpdateCompanionBuilder,
          (Article, BaseReferences<_$AppDatabase, $ArticlesTable, Article>),
          Article,
          PrefetchHooks Function()
        > {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => ArticlesCompanion(number: number, value: value),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String value,
              }) => ArticlesCompanion.insert(number: number, value: value),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTable,
      Article,
      $$ArticlesTableFilterComposer,
      $$ArticlesTableOrderingComposer,
      $$ArticlesTableAnnotationComposer,
      $$ArticlesTableCreateCompanionBuilder,
      $$ArticlesTableUpdateCompanionBuilder,
      (Article, BaseReferences<_$AppDatabase, $ArticlesTable, Article>),
      Article,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TitlesTableTableManager get titles =>
      $$TitlesTableTableManager(_db, _db.titles);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'8e0cccd7648ba0b2ca3b59959f82bdf36ffa8f53';

/// See also [db].
@ProviderFor(db)
final dbProvider = Provider<AppDatabase>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DbRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
