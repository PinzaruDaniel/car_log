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
mixin _$GarageVehicle {

 String get make; String get model; int get year; int get odometer; String get vin; String get body; String get fuel; String get engine; int get oilInterval; DateTime? get insuranceExpiry; List<ServiceRecord> get records;
/// Create a copy of GarageVehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageVehicleCopyWith<GarageVehicle> get copyWith => _$GarageVehicleCopyWithImpl<GarageVehicle>(this as GarageVehicle, _$identity);

  /// Serializes this GarageVehicle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GarageVehicle&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.body, body) || other.body == body)&&(identical(other.fuel, fuel) || other.fuel == fuel)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.oilInterval, oilInterval) || other.oilInterval == oilInterval)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&const DeepCollectionEquality().equals(other.records, records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,make,model,year,odometer,vin,body,fuel,engine,oilInterval,insuranceExpiry,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'GarageVehicle(make: $make, model: $model, year: $year, odometer: $odometer, vin: $vin, body: $body, fuel: $fuel, engine: $engine, oilInterval: $oilInterval, insuranceExpiry: $insuranceExpiry, records: $records)';
}


}

/// @nodoc
abstract mixin class $GarageVehicleCopyWith<$Res>  {
  factory $GarageVehicleCopyWith(GarageVehicle value, $Res Function(GarageVehicle) _then) = _$GarageVehicleCopyWithImpl;
@useResult
$Res call({
 String make, String model, int year, int odometer, String vin, String body, String fuel, String engine, int oilInterval, DateTime? insuranceExpiry, List<ServiceRecord> records
});




}
/// @nodoc
class _$GarageVehicleCopyWithImpl<$Res>
    implements $GarageVehicleCopyWith<$Res> {
  _$GarageVehicleCopyWithImpl(this._self, this._then);

  final GarageVehicle _self;
  final $Res Function(GarageVehicle) _then;

/// Create a copy of GarageVehicle
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
as List<ServiceRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [GarageVehicle].
extension GarageVehiclePatterns on GarageVehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GarageVehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GarageVehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GarageVehicle value)  $default,){
final _that = this;
switch (_that) {
case _GarageVehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GarageVehicle value)?  $default,){
final _that = this;
switch (_that) {
case _GarageVehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecord> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GarageVehicle() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecord> records)  $default,) {final _that = this;
switch (_that) {
case _GarageVehicle():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String make,  String model,  int year,  int odometer,  String vin,  String body,  String fuel,  String engine,  int oilInterval,  DateTime? insuranceExpiry,  List<ServiceRecord> records)?  $default,) {final _that = this;
switch (_that) {
case _GarageVehicle() when $default != null:
return $default(_that.make,_that.model,_that.year,_that.odometer,_that.vin,_that.body,_that.fuel,_that.engine,_that.oilInterval,_that.insuranceExpiry,_that.records);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GarageVehicle extends GarageVehicle {
  const _GarageVehicle({required this.make, required this.model, required this.year, required this.odometer, this.vin = '', this.body = '', this.fuel = '', this.engine = '', this.oilInterval = 10000, this.insuranceExpiry, final  List<ServiceRecord> records = const []}): _records = records,super._();
  factory _GarageVehicle.fromJson(Map<String, dynamic> json) => _$GarageVehicleFromJson(json);

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
 final  List<ServiceRecord> _records;
@override@JsonKey() List<ServiceRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of GarageVehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageVehicleCopyWith<_GarageVehicle> get copyWith => __$GarageVehicleCopyWithImpl<_GarageVehicle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageVehicleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GarageVehicle&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.body, body) || other.body == body)&&(identical(other.fuel, fuel) || other.fuel == fuel)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.oilInterval, oilInterval) || other.oilInterval == oilInterval)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&const DeepCollectionEquality().equals(other._records, _records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,make,model,year,odometer,vin,body,fuel,engine,oilInterval,insuranceExpiry,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'GarageVehicle(make: $make, model: $model, year: $year, odometer: $odometer, vin: $vin, body: $body, fuel: $fuel, engine: $engine, oilInterval: $oilInterval, insuranceExpiry: $insuranceExpiry, records: $records)';
}


}

/// @nodoc
abstract mixin class _$GarageVehicleCopyWith<$Res> implements $GarageVehicleCopyWith<$Res> {
  factory _$GarageVehicleCopyWith(_GarageVehicle value, $Res Function(_GarageVehicle) _then) = __$GarageVehicleCopyWithImpl;
@override @useResult
$Res call({
 String make, String model, int year, int odometer, String vin, String body, String fuel, String engine, int oilInterval, DateTime? insuranceExpiry, List<ServiceRecord> records
});




}
/// @nodoc
class __$GarageVehicleCopyWithImpl<$Res>
    implements _$GarageVehicleCopyWith<$Res> {
  __$GarageVehicleCopyWithImpl(this._self, this._then);

  final _GarageVehicle _self;
  final $Res Function(_GarageVehicle) _then;

/// Create a copy of GarageVehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? make = null,Object? model = null,Object? year = null,Object? odometer = null,Object? vin = null,Object? body = null,Object? fuel = null,Object? engine = null,Object? oilInterval = null,Object? insuranceExpiry = freezed,Object? records = null,}) {
  return _then(_GarageVehicle(
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
as List<ServiceRecord>,
  ));
}


}

// dart format on
