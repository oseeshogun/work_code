// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [TitleEntity].
extension TitleEntityPatterns on TitleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TitleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TitleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TitleEntity value)  $default,){
final _that = this;
switch (_that) {
case _TitleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TitleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TitleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String text,  Set<int> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TitleEntity() when $default != null:
return $default(_that.number,_that.text,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String text,  Set<int> articles)  $default,) {final _that = this;
switch (_that) {
case _TitleEntity():
return $default(_that.number,_that.text,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String text,  Set<int> articles)?  $default,) {final _that = this;
switch (_that) {
case _TitleEntity() when $default != null:
return $default(_that.number,_that.text,_that.articles);case _:
  return null;

}
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
