// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TitleEntity {

 int get number; String get text; Set<int> get articles;
/// Create a copy of TitleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TitleEntityCopyWith<TitleEntity> get copyWith => _$TitleEntityCopyWithImpl<TitleEntity>(this as TitleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TitleEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.articles, articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'TitleEntity(number: $number, text: $text, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $TitleEntityCopyWith<$Res>  {
  factory $TitleEntityCopyWith(TitleEntity value, $Res Function(TitleEntity) _then) = _$TitleEntityCopyWithImpl;
@useResult
$Res call({
 int number, String text, Set<int> articles
});




}
/// @nodoc
class _$TitleEntityCopyWithImpl<$Res>
    implements $TitleEntityCopyWith<$Res> {
  _$TitleEntityCopyWithImpl(this._self, this._then);

  final TitleEntity _self;
  final $Res Function(TitleEntity) _then;

/// Create a copy of TitleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? text = null,Object? articles = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// @nodoc


class _TitleEntity implements TitleEntity {
  const _TitleEntity({required this.number, required this.text, required final  Set<int> articles}): _articles = articles;
  

@override final  int number;
@override final  String text;
 final  Set<int> _articles;
@override Set<int> get articles {
  if (_articles is EqualUnmodifiableSetView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_articles);
}


/// Create a copy of TitleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleEntityCopyWith<_TitleEntity> get copyWith => __$TitleEntityCopyWithImpl<_TitleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleEntity&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,number,text,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'TitleEntity(number: $number, text: $text, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$TitleEntityCopyWith<$Res> implements $TitleEntityCopyWith<$Res> {
  factory _$TitleEntityCopyWith(_TitleEntity value, $Res Function(_TitleEntity) _then) = __$TitleEntityCopyWithImpl;
@override @useResult
$Res call({
 int number, String text, Set<int> articles
});




}
/// @nodoc
class __$TitleEntityCopyWithImpl<$Res>
    implements _$TitleEntityCopyWith<$Res> {
  __$TitleEntityCopyWithImpl(this._self, this._then);

  final _TitleEntity _self;
  final $Res Function(_TitleEntity) _then;

/// Create a copy of TitleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? text = null,Object? articles = null,}) {
  return _then(_TitleEntity(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
