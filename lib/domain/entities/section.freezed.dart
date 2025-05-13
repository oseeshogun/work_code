// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectionEntity {

 int get number; String get text; int get chapterNumber; int get titleNumber; Set<int> get articles;
/// Create a copy of SectionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionEntityCopyWith<SectionEntity> get copyWith => _$SectionEntityCopyWithImpl<SectionEntity>(this as SectionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber)&&(identical(other.titleNumber, titleNumber) || other.titleNumber == titleNumber)&&const DeepCollectionEquality().equals(other.articles, articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,chapterNumber,titleNumber,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'SectionEntity(number: $number, text: $text, chapterNumber: $chapterNumber, titleNumber: $titleNumber, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $SectionEntityCopyWith<$Res>  {
  factory $SectionEntityCopyWith(SectionEntity value, $Res Function(SectionEntity) _then) = _$SectionEntityCopyWithImpl;
@useResult
$Res call({
 int number, String text, int chapterNumber, int titleNumber, Set<int> articles
});




}
/// @nodoc
class _$SectionEntityCopyWithImpl<$Res>
    implements $SectionEntityCopyWith<$Res> {
  _$SectionEntityCopyWithImpl(this._self, this._then);

  final SectionEntity _self;
  final $Res Function(SectionEntity) _then;

/// Create a copy of SectionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? text = null,Object? chapterNumber = null,Object? titleNumber = null,Object? articles = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as int,titleNumber: null == titleNumber ? _self.titleNumber : titleNumber // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// @nodoc


class _SectionEntity implements SectionEntity {
  const _SectionEntity({required this.number, required this.text, required this.chapterNumber, required this.titleNumber, required final  Set<int> articles}): _articles = articles;
  

@override final  int number;
@override final  String text;
@override final  int chapterNumber;
@override final  int titleNumber;
 final  Set<int> _articles;
@override Set<int> get articles {
  if (_articles is EqualUnmodifiableSetView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_articles);
}


/// Create a copy of SectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionEntityCopyWith<_SectionEntity> get copyWith => __$SectionEntityCopyWithImpl<_SectionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber)&&(identical(other.titleNumber, titleNumber) || other.titleNumber == titleNumber)&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,chapterNumber,titleNumber,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'SectionEntity(number: $number, text: $text, chapterNumber: $chapterNumber, titleNumber: $titleNumber, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$SectionEntityCopyWith<$Res> implements $SectionEntityCopyWith<$Res> {
  factory _$SectionEntityCopyWith(_SectionEntity value, $Res Function(_SectionEntity) _then) = __$SectionEntityCopyWithImpl;
@override @useResult
$Res call({
 int number, String text, int chapterNumber, int titleNumber, Set<int> articles
});




}
/// @nodoc
class __$SectionEntityCopyWithImpl<$Res>
    implements _$SectionEntityCopyWith<$Res> {
  __$SectionEntityCopyWithImpl(this._self, this._then);

  final _SectionEntity _self;
  final $Res Function(_SectionEntity) _then;

/// Create a copy of SectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? text = null,Object? chapterNumber = null,Object? titleNumber = null,Object? articles = null,}) {
  return _then(_SectionEntity(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as int,titleNumber: null == titleNumber ? _self.titleNumber : titleNumber // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
