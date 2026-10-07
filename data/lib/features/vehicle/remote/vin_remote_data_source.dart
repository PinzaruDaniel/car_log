import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'models/vin_decode_response_dto.dart';

part 'vin_remote_data_source.g.dart';

@lazySingleton
@RestApi(baseUrl: '')
abstract class VinRemoteDataSource {
  @factoryMethod
  factory VinRemoteDataSource(@Named('vin_dio') Dio dio) = _VinRemoteDataSource;

  @GET('/vehicles/DecodeVinValues/{vin}')
  Future<VinDecodeResponseDto> decodeVin(
    @Path('vin') String vin, {
    @Query('format') String format = 'json',
  });
}
