// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthDto {

 String get id;
/// Create a copy of AuthDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthDtoCopyWith<AuthDto> get copyWith => _$AuthDtoCopyWithImpl<AuthDto>(this as AuthDto, _$identity);

  /// Serializes this AuthDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AuthDto(id: $id)';
}


}

/// @nodoc
abstract mixin class $AuthDtoCopyWith<$Res>  {
  factory $AuthDtoCopyWith(AuthDto value, $Res Function(AuthDto) _then) = _$AuthDtoCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$AuthDtoCopyWithImpl<$Res>
    implements $AuthDtoCopyWith<$Res> {
  _$AuthDtoCopyWithImpl(this._self, this._then);

  final AuthDto _self;
  final $Res Function(AuthDto) _then;

/// Create a copy of AuthDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthDto].
extension AuthDtoPatterns on AuthDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthDto() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _AuthDto():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _AuthDto() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthDto implements AuthDto {
  const _AuthDto({required this.id});
  factory _AuthDto.fromJson(Map<String, dynamic> json) => _$AuthDtoFromJson(json);

@override final  String id;

/// Create a copy of AuthDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthDtoCopyWith<_AuthDto> get copyWith => __$AuthDtoCopyWithImpl<_AuthDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AuthDto(id: $id)';
}


}

/// @nodoc
abstract mixin class _$AuthDtoCopyWith<$Res> implements $AuthDtoCopyWith<$Res> {
  factory _$AuthDtoCopyWith(_AuthDto value, $Res Function(_AuthDto) _then) = __$AuthDtoCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$AuthDtoCopyWithImpl<$Res>
    implements _$AuthDtoCopyWith<$Res> {
  __$AuthDtoCopyWithImpl(this._self, this._then);

  final _AuthDto _self;
  final $Res Function(_AuthDto) _then;

/// Create a copy of AuthDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_AuthDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
