import '../remote/models/vin_decode_response_dto.dart';

extension VinDecodeResponseDtoMapper on VinDecodeResponseDto {
  Map<String, String> toVehicleDetails() {
    if (results.isEmpty) {
      throw const FormatException('No vehicle details returned');
    }

    final result = results.first;
    final fields = <String, String?>{
      'make': result.make,
      'model': result.model,
      'year': result.modelYear,
      'body': result.bodyClass,
      'fuel': result.fuelTypePrimary,
      'engine': result.displacementL,
    };

    return {
      if (_hasDecodeWarning(result.errorCode)) '_warning': 'vin_warning',
      for (final entry in fields.entries)
        if (_isUseful(entry.value)) entry.key: entry.value!.trim(),
    };
  }
}

bool _hasDecodeWarning(String? errorCode) =>
    errorCode
        ?.split(',')
        .map((code) => code.trim())
        .any((code) => code.isNotEmpty && code != '0') ??
    false;

bool _isUseful(String? value) {
  final normalized = value?.trim() ?? '';
  return normalized.isNotEmpty && normalized != 'Not Applicable';
}
