import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/garage/repositories/garage_repository.dart';
import 'features/vehicle/repositories/vehicle_repository.dart';

import 'injector.config.dart';

// Data registers these interfaces before domain use cases are initialized.
@InjectableInit(
  ignoreUnregisteredTypes: [
    AuthRepository,
    GarageRepository,
    VehicleRepository,
  ],
)
void configureDependencies(GetIt get) => get.init();
