import 'package:json_annotation/json_annotation.dart';

part 'vin_decode_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class VinDecodeResponseDto {
  const VinDecodeResponseDto({required this.results});

  factory VinDecodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VinDecodeResponseDtoFromJson(json);

  @JsonKey(name: 'Results', defaultValue: <VinResultDto>[])
  final List<VinResultDto> results;
}

@JsonSerializable(createToJson: false)
class VinResultDto {
  const VinResultDto({
    this.make,
    this.model,
    this.modelYear,
    this.bodyClass,
    this.fuelTypePrimary,
    this.displacementL,
    this.errorCode,
  });

  factory VinResultDto.fromJson(Map<String, dynamic> json) =>
      _$VinResultDtoFromJson(json);

  @JsonKey(name: 'Make', fromJson: _asString)
  final String? make;

  @JsonKey(name: 'Model', fromJson: _asString)
  final String? model;

  @JsonKey(name: 'ModelYear', fromJson: _asString)
  final String? modelYear;

  @JsonKey(name: 'BodyClass', fromJson: _asString)
  final String? bodyClass;

  @JsonKey(name: 'FuelTypePrimary', fromJson: _asString)
  final String? fuelTypePrimary;

  @JsonKey(name: 'DisplacementL', fromJson: _asString)
  final String? displacementL;

  @JsonKey(name: 'ErrorCode', fromJson: _asString)
  final String? errorCode;
}

String? _asString(Object? value) => value?.toString();
