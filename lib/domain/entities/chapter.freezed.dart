// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterEntity {

 int get number; String get text; int get titleNumber; Set<int> get articles;
/// Create a copy of ChapterEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterEntityCopyWith<ChapterEntity> get copyWith => _$ChapterEntityCopyWithImpl<ChapterEntity>(this as ChapterEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&(identical(other.titleNumber, titleNumber) || other.titleNumber == titleNumber)&&const DeepCollectionEquality().equals(other.articles, articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,titleNumber,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'ChapterEntity(number: $number, text: $text, titleNumber: $titleNumber, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $ChapterEntityCopyWith<$Res>  {
  factory $ChapterEntityCopyWith(ChapterEntity value, $Res Function(ChapterEntity) _then) = _$ChapterEntityCopyWithImpl;
@useResult
$Res call({
 int number, String text, int titleNumber, Set<int> articles
});




}
/// @nodoc
class _$ChapterEntityCopyWithImpl<$Res>
    implements $ChapterEntityCopyWith<$Res> {
  _$ChapterEntityCopyWithImpl(this._self, this._then);

  final ChapterEntity _self;
  final $Res Function(ChapterEntity) _then;

/// Create a copy of ChapterEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? text = null,Object? titleNumber = null,Object? articles = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,titleNumber: null == titleNumber ? _self.titleNumber : titleNumber // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// @nodoc


class _ChapterEntity implements ChapterEntity {
  const _ChapterEntity({required this.number, required this.text, required this.titleNumber, required final  Set<int> articles}): _articles = articles;
  

@override final  int number;
@override final  String text;
@override final  int titleNumber;
 final  Set<int> _articles;
@override Set<int> get articles {
  if (_articles is EqualUnmodifiableSetView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_articles);
}


/// Create a copy of ChapterEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterEntityCopyWith<_ChapterEntity> get copyWith => __$ChapterEntityCopyWithImpl<_ChapterEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&(identical(other.titleNumber, titleNumber) || other.titleNumber == titleNumber)&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,titleNumber,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'ChapterEntity(number: $number, text: $text, titleNumber: $titleNumber, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$ChapterEntityCopyWith<$Res> implements $ChapterEntityCopyWith<$Res> {
  factory _$ChapterEntityCopyWith(_ChapterEntity value, $Res Function(_ChapterEntity) _then) = __$ChapterEntityCopyWithImpl;
@override @useResult
$Res call({
 int number, String text, int titleNumber, Set<int> articles
});




}
/// @nodoc
class __$ChapterEntityCopyWithImpl<$Res>
    implements _$ChapterEntityCopyWith<$Res> {
  __$ChapterEntityCopyWithImpl(this._self, this._then);

  final _ChapterEntity _self;
  final $Res Function(_ChapterEntity) _then;

/// Create a copy of ChapterEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? text = null,Object? titleNumber = null,Object? articles = null,}) {
  return _then(_ChapterEntity(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,titleNumber: null == titleNumber ? _self.titleNumber : titleNumber // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
