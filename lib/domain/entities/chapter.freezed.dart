// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [ChapterEntity].
extension ChapterEntityPatterns on ChapterEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChapterEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String text,  int titleNumber,  Set<int> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterEntity() when $default != null:
return $default(_that.number,_that.text,_that.titleNumber,_that.articles);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String text,  int titleNumber,  Set<int> articles)  $default,) {final _that = this;
switch (_that) {
case _ChapterEntity():
return $default(_that.number,_that.text,_that.titleNumber,_that.articles);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String text,  int titleNumber,  Set<int> articles)?  $default,) {final _that = this;
switch (_that) {
case _ChapterEntity() when $default != null:
return $default(_that.number,_that.text,_that.titleNumber,_that.articles);case _:
  return null;

}
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
