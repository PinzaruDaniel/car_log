import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VinRemoteDataSource {
  const VinRemoteDataSource(@Named('vin_dio') this._dio);
  final Dio _dio;

  Future<Map<String, String>> decodeVin(String vin) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/vehicles/DecodeVinValues/${Uri.encodeComponent(vin)}',
      queryParameters: {'format': 'json'},
    );
    final results = response.data?['Results'] as List?;
    if (results == null || results.isEmpty) {
      throw const FormatException('No vehicle details returned');
    }
    final row = Map<String, dynamic>.from(results.first as Map);
    const fields = {
      'make': 'Make',
      'model': 'Model',
      'year': 'ModelYear',
      'body': 'BodyClass',
      'fuel': 'FuelTypePrimary',
      'engine': 'DisplacementL',
    };
    return {
      if (row['ErrorCode']
              ?.toString()
              .split(',')
              .any((code) => code.trim() != '0' && code.trim().isNotEmpty) ??
          false)
        '_warning': 'vin_warning',
      for (final entry in fields.entries)
        if ((row[entry.value]?.toString().trim() ?? '').isNotEmpty &&
            row[entry.value] != 'Not Applicable')
          entry.key: row[entry.value].toString().trim(),
    };
  }
}
