import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'features/vehicle/local/models/vehicle_box.dart';
import 'objectbox.g.dart';
import 'features/auth/local/models/auth_box.dart';
import 'features/vehicle/local/models/garage_vehicle_box.dart';
import 'features/vehicle/local/models/service_record_box.dart';

@module
abstract class DataModule {
  @Named('vin_dio')
  @lazySingleton
  Dio vinDio() => Dio(
    BaseOptions(
      baseUrl: 'https://vpic.nhtsa.dot.gov/api',
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  @lazySingleton
  Box<GarageVehicleBox> garageVehicleBox(Store store) =>
      Box<GarageVehicleBox>(store);

  @lazySingleton
  Box<ServiceRecordBox> serviceRecordBox(Store store) =>
      Box<ServiceRecordBox>(store);
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
    final directory = Platform.isMacOS
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    return openStore(directory: p.join(directory.path, 'objectbox'));
  }

  @lazySingleton
  Box<VehicleBox> vehicleBox(Store store) => Box<VehicleBox>(store);

  @lazySingleton
  Box<AuthBox> authBox(Store store) => Box<AuthBox>(store);
}
