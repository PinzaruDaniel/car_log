// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage_vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GarageVehicleEntity {

 String get make; String get model; int get year; int get odometer; String get vin; String get body; String get fuel; String get engine; int get oilInterval; DateTime? get insuranceExpiry; List<ServiceRecordEntity> get records;
/// Create a copy of GarageVehicleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageVehicleEntityCopyWith<GarageVehicleEntity> get copyWith => _$GarageVehicleEntityCopyWithImpl<GarageVehicleEntity>(this as GarageVehicleEntity, _$identity);

  /// Serializes this GarageVehicleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GarageVehicleEntity&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.body, body) || other.body == body)&&(identical(other.fuel, fuel) || other.fuel == fuel)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.oilInterval, oilInterval) || other.oilInterval == oilInterval)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&const DeepCollectionEquality().equals(other.records, records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,make,model,year,odometer,vin,body,fuel,engine,oilInterval,insuranceExpiry,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'GarageVehicleEntity(make: $make, model: $model, year: $year, odometer: $odometer, vin: $vin, body: $body, fuel: $fuel, engine: $engine, oilInterval: $oilInterval, insuranceExpiry: $insuranceExpiry, records: $records)';
}


}

/// @nodoc
abstract mixin class $GarageVehicleEntityCopyWith<$Res>  {
  factory $GarageVehicleEntityCopyWith(GarageVehicleEntity value, $Res Function(GarageVehicleEntity) _then) = _$GarageVehicleEntityCopyWithImpl;
@useResult
$Res call({
 String make, String model, int year, int odometer, String vin, String body, String fuel, String engine, int oilInterval, DateTime? insuranceExpiry, List<ServiceRecordEntity> records
});




}
/// @nodoc
class _$GarageVehicleEntityCopyWithImpl<$Res>
    implements $GarageVehicleEntityCopyWith<$Res> {
  _$GarageVehicleEntityCopyWithImpl(this._self, this._then);

  final GarageVehicleEntity _self;
  final $Res Function(GarageVehicleEntity) _then;

/// Create a copy of GarageVehicleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? make = null,Object? model = null,Object? year = null,Object? odometer = null,Object? vin = null,Object? body = null,Object? fuel = null,Object? engine = null,Object? oilInterval = null,Object? insuranceExpiry = freezed,Object? records = null,}) {
  return _then(_self.copyWith(
make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,odometer: null == odometer ? _self.odometer : odometer // ignore: cast_nullable_to_non_nullable
as int,vin: null == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,fuel: null == fuel ? _self.fuel : fuel // ignore: cast_nullable_to_non_nullable
as String,engine: null == engine ? _self.engine : engine // ignore: cast_nullable_to_non_nullable
as String,oilInterval: null == oilInterval ? _self.oilInterval : oilInterval // ignore: cast_nullable_to_non_nullable
as int,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<ServiceRecordEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [GarageVehicleEntity].
extension GarageVehicleEntityPatterns on GarageVehicleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GarageVehicleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GarageVehicleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GarageVehicleEntity value)  $default,){
final _that = this;
switch (_that) {
case _GarageVehicleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GarageVehicleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GarageVehicleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecordEntity> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GarageVehicleEntity() when $default != null:
return $default(_that.make,_that.model,_that.year,_that.odometer,_that.vin,_that.body,_that.fuel,_that.engine,_that.oilInterval,_that.insuranceExpiry,_that.records);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecordEntity> records)  $default,) {final _that = this;
switch (_that) {
case _GarageVehicleEntity():
return $default(_that.make,_that.model,_that.year,_that.odometer,_that.vin,_that.body,_that.fuel,_that.engine,_that.oilInterval,_that.insuranceExpiry,_that.records);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecordEntity> records)?  $default,) {final _that = this;
switch (_that) {
case _GarageVehicleEntity() when $default != null:
return $default(_that.make,_that.model,_that.year,_that.odometer,_that.vin,_that.body,_that.fuel,_that.engine,_that.oilInterval,_that.insuranceExpiry,_that.records);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GarageVehicleEntity extends GarageVehicleEntity {
  const _GarageVehicleEntity({required this.make, required this.model, required this.year, required this.odometer, this.vin = '', this.body = '', this.fuel = '', this.engine = '', this.oilInterval = 10000, this.insuranceExpiry, final  List<ServiceRecordEntity> records = const []}): _records = records,super._();
  factory _GarageVehicleEntity.fromJson(Map<String, dynamic> json) => _$GarageVehicleEntityFromJson(json);

@override final  String make;
@override final  String model;
@override final  int year;
@override final  int odometer;
@override@JsonKey() final  String vin;
@override@JsonKey() final  String body;
@override@JsonKey() final  String fuel;
@override@JsonKey() final  String engine;
@override@JsonKey() final  int oilInterval;
@override final  DateTime? insuranceExpiry;
 final  List<ServiceRecordEntity> _records;
@override@JsonKey() List<ServiceRecordEntity> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of GarageVehicleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageVehicleEntityCopyWith<_GarageVehicleEntity> get copyWith => __$GarageVehicleEntityCopyWithImpl<_GarageVehicleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageVehicleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GarageVehicleEntity&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.body, body) || other.body == body)&&(identical(other.fuel, fuel) || other.fuel == fuel)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.oilInterval, oilInterval) || other.oilInterval == oilInterval)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&const DeepCollectionEquality().equals(other._records, _records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,make,model,year,odometer,vin,body,fuel,engine,oilInterval,insuranceExpiry,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'GarageVehicleEntity(make: $make, model: $model, year: $year, odometer: $odometer, vin: $vin, body: $body, fuel: $fuel, engine: $engine, oilInterval: $oilInterval, insuranceExpiry: $insuranceExpiry, records: $records)';
}


}

/// @nodoc
abstract mixin class _$GarageVehicleEntityCopyWith<$Res> implements $GarageVehicleEntityCopyWith<$Res> {
  factory _$GarageVehicleEntityCopyWith(_GarageVehicleEntity value, $Res Function(_GarageVehicleEntity) _then) = __$GarageVehicleEntityCopyWithImpl;
@override @useResult
$Res call({
 String make, String model, int year, int odometer, String vin, String body, String fuel, String engine, int oilInterval, DateTime? insuranceExpiry, List<ServiceRecordEntity> records
});




}
/// @nodoc
class __$GarageVehicleEntityCopyWithImpl<$Res>
    implements _$GarageVehicleEntityCopyWith<$Res> {
  __$GarageVehicleEntityCopyWithImpl(this._self, this._then);

  final _GarageVehicleEntity _self;
  final $Res Function(_GarageVehicleEntity) _then;

/// Create a copy of GarageVehicleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? make = null,Object? model = null,Object? year = null,Object? odometer = null,Object? vin = null,Object? body = null,Object? fuel = null,Object? engine = null,Object? oilInterval = null,Object? insuranceExpiry = freezed,Object? records = null,}) {
  return _then(_GarageVehicleEntity(
make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,odometer: null == odometer ? _self.odometer : odometer // ignore: cast_nullable_to_non_nullable
as int,vin: null == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,fuel: null == fuel ? _self.fuel : fuel // ignore: cast_nullable_to_non_nullable
as String,engine: null == engine ? _self.engine : engine // ignore: cast_nullable_to_non_nullable
as String,oilInterval: null == oilInterval ? _self.oilInterval : oilInterval // ignore: cast_nullable_to_non_nullable
as int,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<ServiceRecordEntity>,
  ));
}


}

// dart format on
