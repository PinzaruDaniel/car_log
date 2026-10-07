// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GarageVehicleEntity _$GarageVehicleEntityFromJson(Map<String, dynamic> json) =>
    _GarageVehicleEntity(
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      odometer: (json['odometer'] as num).toInt(),
      vin: json['vin'] as String? ?? '',
      body: json['body'] as String? ?? '',
      fuel: json['fuel'] as String? ?? '',
      engine: json['engine'] as String? ?? '',
      oilInterval: (json['oilInterval'] as num?)?.toInt() ?? 10000,
      insuranceExpiry: json['insuranceExpiry'] == null
          ? null
          : DateTime.parse(json['insuranceExpiry'] as String),
      records:
          (json['records'] as List<dynamic>?)
              ?.map(
                (e) => ServiceRecordEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GarageVehicleEntityToJson(
  _GarageVehicleEntity instance,
) => <String, dynamic>{
  'make': instance.make,
  'model': instance.model,
  'year': instance.year,
  'odometer': instance.odometer,
  'vin': instance.vin,
  'body': instance.body,
  'fuel': instance.fuel,
  'engine': instance.engine,
  'oilInterval': instance.oilInterval,
  'insuranceExpiry': instance.insuranceExpiry?.toIso8601String(),
  'records': instance.records.map((e) => e.toJson()).toList(),
};
