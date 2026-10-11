import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

import 'models/auth_dto.dart';

part 'auth_remote_data_source.g.dart';

@lazySingleton
@RestApi(baseUrl: '')
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(@Named("main_dio") Dio dio) =
      _AuthRemoteDataSource;

  @GET('/auth')
  Future<List<AuthDto>> getItems();
}
