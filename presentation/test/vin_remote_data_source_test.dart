import 'package:data/features/vehicle/mappers/vin_mapper.dart';
import 'package:data/features/vehicle/remote/models/vin_decode_response_dto.dart';
import 'package:data/features/vehicle/remote/vin_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Retrofit sends VIN and JSON format to vPIC', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://vpic.nhtsa.dot.gov/api'));
    RequestOptions? request;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          handler.resolve(
            Response<Map<String, dynamic>>(
              requestOptions: options,
              statusCode: 200,
              data: {
                'Results': [
                  {'Make': 'BMW', 'ErrorCode': '0'},
                ],
              },
            ),
          );
        },
      ),
    );

    final response = await VinRemoteDataSource(
      dio,
    ).decodeVin('WBAEV53452KM12345');

    expect(
      request?.uri.path,
      '/api/vehicles/DecodeVinValues/WBAEV53452KM12345',
    );
    expect(request?.queryParameters, {'format': 'json'});
    expect(response.results.single.make, 'BMW');
  });

  test('typed VIN response maps useful values and warning', () {
    final response = VinDecodeResponseDto.fromJson({
      'Results': [
        {
          'Make': ' BMW ',
          'Model': '530i',
          'ModelYear': 2002,
          'BodyClass': 'Not Applicable',
          'FuelTypePrimary': '',
          'DisplacementL': 3.0,
          'ErrorCode': '1, 7',
        },
      ],
    });

    expect(response.toVehicleDetails(), {
      '_warning': 'vin_warning',
      'make': 'BMW',
      'model': '530i',
      'year': '2002',
      'engine': '3.0',
    });
  });

  test('empty VIN response is rejected', () {
    const response = VinDecodeResponseDto(results: []);
    expect(response.toVehicleDetails, throwsFormatException);
  });
}
