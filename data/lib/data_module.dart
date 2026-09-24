import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'features/vehicle/local/models/vehicle_box.dart';
import 'objectbox.g.dart';
import 'features/auth/local/models/auth_box.dart';

@module
abstract class DataModule {
  @Named('auth_dio')
  @lazySingleton
  Dio authDio() {
    return Dio(BaseOptions(baseUrl: ''));
  }

  @Named('main_dio')
  @lazySingleton
  Dio mainDio() {
    return Dio(BaseOptions(baseUrl: ''));
  }

  @lazySingleton
  @factoryMethod
  @preResolve
  Future<Store> asyncCreateStore() async {
    final directory = await getApplicationDocumentsDirectory();
    return openStore(directory: p.join(directory.path, 'objectbox'));
  }

  @lazySingleton
  Box<VehicleBox> vehicleBox(Store store) => Box<VehicleBox>(store);

  @lazySingleton
  Box<AuthBox> authBox(Store store) => Box<AuthBox>(store);
}
