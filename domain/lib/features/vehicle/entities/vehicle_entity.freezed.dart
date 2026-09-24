// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VehicleEntity {

 String get remoteId;
/// Create a copy of VehicleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleEntityCopyWith<VehicleEntity> get copyWith => _$VehicleEntityCopyWithImpl<VehicleEntity>(this as VehicleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleEntity&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId));
}


@override
int get hashCode => Object.hash(runtimeType,remoteId);

@override
String toString() {
  return 'VehicleEntity(remoteId: $remoteId)';
}


}

/// @nodoc
abstract mixin class $VehicleEntityCopyWith<$Res>  {
  factory $VehicleEntityCopyWith(VehicleEntity value, $Res Function(VehicleEntity) _then) = _$VehicleEntityCopyWithImpl;
@useResult
$Res call({
 String remoteId
});




}
/// @nodoc
class _$VehicleEntityCopyWithImpl<$Res>
    implements $VehicleEntityCopyWith<$Res> {
  _$VehicleEntityCopyWithImpl(this._self, this._then);

  final VehicleEntity _self;
  final $Res Function(VehicleEntity) _then;

/// Create a copy of VehicleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remoteId = null,}) {
  return _then(_self.copyWith(
remoteId: null == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleEntity].
extension VehicleEntityPatterns on VehicleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleEntity value)  $default,){
final _that = this;
switch (_that) {
case _VehicleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String remoteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleEntity() when $default != null:
return $default(_that.remoteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String remoteId)  $default,) {final _that = this;
switch (_that) {
case _VehicleEntity():
return $default(_that.remoteId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String remoteId)?  $default,) {final _that = this;
switch (_that) {
case _VehicleEntity() when $default != null:
return $default(_that.remoteId);case _:
  return null;

}
}

}

/// @nodoc


class _VehicleEntity implements VehicleEntity {
  const _VehicleEntity({required this.remoteId});
  

@override final  String remoteId;

/// Create a copy of VehicleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleEntityCopyWith<_VehicleEntity> get copyWith => __$VehicleEntityCopyWithImpl<_VehicleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleEntity&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId));
}


@override
int get hashCode => Object.hash(runtimeType,remoteId);

@override
String toString() {
  return 'VehicleEntity(remoteId: $remoteId)';
}


}

/// @nodoc
abstract mixin class _$VehicleEntityCopyWith<$Res> implements $VehicleEntityCopyWith<$Res> {
  factory _$VehicleEntityCopyWith(_VehicleEntity value, $Res Function(_VehicleEntity) _then) = __$VehicleEntityCopyWithImpl;
@override @useResult
$Res call({
 String remoteId
});




}
/// @nodoc
class __$VehicleEntityCopyWithImpl<$Res>
    implements _$VehicleEntityCopyWith<$Res> {
  __$VehicleEntityCopyWithImpl(this._self, this._then);

  final _VehicleEntity _self;
  final $Res Function(_VehicleEntity) _then;

/// Create a copy of VehicleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remoteId = null,}) {
  return _then(_VehicleEntity(
remoteId: null == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
