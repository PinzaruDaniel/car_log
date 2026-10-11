// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceRecordEntity {

 String get title; DateTime get date; int get km; ServiceKind get kind; double get cost; String get notes; bool get oil;
/// Create a copy of ServiceRecordEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRecordEntityCopyWith<ServiceRecordEntity> get copyWith => _$ServiceRecordEntityCopyWithImpl<ServiceRecordEntity>(this as ServiceRecordEntity, _$identity);

  /// Serializes this ServiceRecordEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRecordEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.km, km) || other.km == km)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.oil, oil) || other.oil == oil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,km,kind,cost,notes,oil);

@override
String toString() {
  return 'ServiceRecordEntity(title: $title, date: $date, km: $km, kind: $kind, cost: $cost, notes: $notes, oil: $oil)';
}


}

/// @nodoc
abstract mixin class $ServiceRecordEntityCopyWith<$Res>  {
  factory $ServiceRecordEntityCopyWith(ServiceRecordEntity value, $Res Function(ServiceRecordEntity) _then) = _$ServiceRecordEntityCopyWithImpl;
@useResult
$Res call({
 String title, DateTime date, int km, ServiceKind kind, double cost, String notes, bool oil
});




}
/// @nodoc
class _$ServiceRecordEntityCopyWithImpl<$Res>
    implements $ServiceRecordEntityCopyWith<$Res> {
  _$ServiceRecordEntityCopyWithImpl(this._self, this._then);

  final ServiceRecordEntity _self;
  final $Res Function(ServiceRecordEntity) _then;

/// Create a copy of ServiceRecordEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? km = null,Object? kind = null,Object? cost = null,Object? notes = null,Object? oil = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,km: null == km ? _self.km : km // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,oil: null == oil ? _self.oil : oil // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceRecordEntity].
extension ServiceRecordEntityPatterns on ServiceRecordEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceRecordEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceRecordEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceRecordEntity value)  $default,){
final _that = this;
switch (_that) {
case _ServiceRecordEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceRecordEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceRecordEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  DateTime date,  int km,  ServiceKind kind,  double cost,  String notes,  bool oil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceRecordEntity() when $default != null:
return $default(_that.title,_that.date,_that.km,_that.kind,_that.cost,_that.notes,_that.oil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  DateTime date,  int km,  ServiceKind kind,  double cost,  String notes,  bool oil)  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordEntity():
return $default(_that.title,_that.date,_that.km,_that.kind,_that.cost,_that.notes,_that.oil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  DateTime date,  int km,  ServiceKind kind,  double cost,  String notes,  bool oil)?  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordEntity() when $default != null:
return $default(_that.title,_that.date,_that.km,_that.kind,_that.cost,_that.notes,_that.oil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceRecordEntity implements ServiceRecordEntity {
  const _ServiceRecordEntity({required this.title, required this.date, required this.km, required this.kind, this.cost = 0, this.notes = '', this.oil = false});
  factory _ServiceRecordEntity.fromJson(Map<String, dynamic> json) => _$ServiceRecordEntityFromJson(json);

@override final  String title;
@override final  DateTime date;
@override final  int km;
@override final  ServiceKind kind;
@override@JsonKey() final  double cost;
@override@JsonKey() final  String notes;
@override@JsonKey() final  bool oil;

/// Create a copy of ServiceRecordEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRecordEntityCopyWith<_ServiceRecordEntity> get copyWith => __$ServiceRecordEntityCopyWithImpl<_ServiceRecordEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRecordEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRecordEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.km, km) || other.km == km)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.oil, oil) || other.oil == oil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,km,kind,cost,notes,oil);

@override
String toString() {
  return 'ServiceRecordEntity(title: $title, date: $date, km: $km, kind: $kind, cost: $cost, notes: $notes, oil: $oil)';
}


}

/// @nodoc
abstract mixin class _$ServiceRecordEntityCopyWith<$Res> implements $ServiceRecordEntityCopyWith<$Res> {
  factory _$ServiceRecordEntityCopyWith(_ServiceRecordEntity value, $Res Function(_ServiceRecordEntity) _then) = __$ServiceRecordEntityCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime date, int km, ServiceKind kind, double cost, String notes, bool oil
});




}
/// @nodoc
class __$ServiceRecordEntityCopyWithImpl<$Res>
    implements _$ServiceRecordEntityCopyWith<$Res> {
  __$ServiceRecordEntityCopyWithImpl(this._self, this._then);

  final _ServiceRecordEntity _self;
  final $Res Function(_ServiceRecordEntity) _then;

/// Create a copy of ServiceRecordEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? km = null,Object? kind = null,Object? cost = null,Object? notes = null,Object? oil = null,}) {
  return _then(_ServiceRecordEntity(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,km: null == km ? _self.km : km // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,oil: null == oil ? _self.oil : oil // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
