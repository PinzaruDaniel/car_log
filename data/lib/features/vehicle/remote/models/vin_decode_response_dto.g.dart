// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vin_decode_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VinDecodeResponseDto _$VinDecodeResponseDtoFromJson(
  Map<String, dynamic> json,
) => VinDecodeResponseDto(
  results:
      (json['Results'] as List<dynamic>?)
          ?.map((e) => VinResultDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

VinResultDto _$VinResultDtoFromJson(Map<String, dynamic> json) => VinResultDto(
  make: _asString(json['Make']),
  model: _asString(json['Model']),
  modelYear: _asString(json['ModelYear']),
  bodyClass: _asString(json['BodyClass']),
  fuelTypePrimary: _asString(json['FuelTypePrimary']),
  displacementL: _asString(json['DisplacementL']),
  errorCode: _asString(json['ErrorCode']),
);
