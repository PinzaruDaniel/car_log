import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

import 'models/vehicle_dto.dart';

part 'vehicle_remote_data_source.g.dart';

@lazySingleton
@RestApi(baseUrl: '')
abstract class VehicleRemoteDataSource {
  @factoryMethod
  factory VehicleRemoteDataSource(@Named("main_dio") Dio dio) =
      _VehicleRemoteDataSource;

  @GET('/vehicle')
  Future<List<VehicleDto>> getItems();
}
