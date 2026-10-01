// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:domain/features/auth/repositories/auth_repository.dart'
    as _i749;
import 'package:domain/features/garage/repositories/garage_repository.dart'
    as _i496;
import 'package:domain/features/vehicle/repositories/vehicle_repository.dart'
    as _i1065;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:objectbox/objectbox.dart' as _i1034;

import 'data_module.dart' as _i444;
import 'features/auth/local/auth_local_data_source.dart' as _i1011;
import 'features/auth/local/models/auth_box.dart' as _i72;
import 'features/auth/remote/auth_remote_data_source.dart' as _i484;
import 'features/auth/repositories/auth_repository_impl.dart' as _i1;
import 'features/vehicle/local/garage_local_data_source.dart' as _i886;
import 'features/vehicle/local/legacy_garage_local_data_source.dart' as _i927;
import 'features/vehicle/local/models/garage_vehicle_box.dart' as _i601;
import 'features/vehicle/local/models/service_record_box.dart' as _i208;
import 'features/vehicle/local/models/vehicle_box.dart' as _i957;
import 'features/vehicle/local/vehicle_local_data_source.dart' as _i95;
import 'features/vehicle/remote/vehicle_remote_data_source.dart' as _i45;
import 'features/vehicle/remote/vin_remote_data_source.dart' as _i874;
import 'features/vehicle/repositories/garage_repository_impl.dart' as _i458;
import 'features/vehicle/repositories/vehicle_repository_impl.dart' as _i60;
import 'objectbox.g.dart' as _i467;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dataModule = _$DataModule();
    await gh.lazySingletonAsync<_i467.Store>(
      () => dataModule.asyncCreateStore(),
      preResolve: true,
    );
    gh.lazySingleton<_i927.LegacyGarageLocalDataSource>(
      () => _i927.LegacyGarageLocalDataSource(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dataModule.mainDio(),
      instanceName: 'main_dio',
    );
    gh.lazySingleton<_i361.Dio>(
      () => dataModule.authDio(),
      instanceName: 'auth_dio',
    );
    gh.lazySingleton<_i361.Dio>(
      () => dataModule.vinDio(),
      instanceName: 'vin_dio',
    );
    gh.lazySingleton<_i467.Box<_i601.GarageVehicleBox>>(
      () => dataModule.garageVehicleBox(gh<_i467.Store>()),
    );
    gh.lazySingleton<_i467.Box<_i208.ServiceRecordBox>>(
      () => dataModule.serviceRecordBox(gh<_i467.Store>()),
    );
    gh.lazySingleton<_i467.Box<_i957.VehicleBox>>(
      () => dataModule.vehicleBox(gh<_i467.Store>()),
    );
    gh.lazySingleton<_i467.Box<_i72.AuthBox>>(
      () => dataModule.authBox(gh<_i467.Store>()),
    );
    gh.lazySingleton<_i484.AuthRemoteDataSource>(
      () => _i484.AuthRemoteDataSource(gh<_i361.Dio>(instanceName: 'main_dio')),
    );
    gh.lazySingleton<_i45.VehicleRemoteDataSource>(
      () =>
          _i45.VehicleRemoteDataSource(gh<_i361.Dio>(instanceName: 'main_dio')),
    );
    gh.lazySingleton<_i95.VehicleLocalDataSource>(
      () => _i95.VehicleLocalDataSourceImpl(gh<_i1034.Box<_i957.VehicleBox>>()),
    );
    gh.lazySingleton<_i886.GarageLocalDataSource>(
      () => _i886.GarageLocalDataSource(
        gh<_i1034.Store>(),
        gh<_i1034.Box<_i601.GarageVehicleBox>>(),
        gh<_i1034.Box<_i208.ServiceRecordBox>>(),
        gh<_i927.LegacyGarageLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i874.VinRemoteDataSource>(
      () => _i874.VinRemoteDataSource(gh<_i361.Dio>(instanceName: 'vin_dio')),
    );
    gh.lazySingleton<_i1011.AuthLocalDataSource>(
      () => _i1011.AuthLocalDataSourceImpl(gh<_i1034.Box<_i72.AuthBox>>()),
    );
    gh.lazySingleton<_i496.GarageRepository>(
      () => _i458.GarageRepositoryImpl(
        gh<_i886.GarageLocalDataSource>(),
        gh<_i874.VinRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1065.VehicleRepository>(
      () => _i60.VehicleRepositoryImpl(
        remoteDataSource: gh<_i45.VehicleRemoteDataSource>(),
        localDataSource: gh<_i95.VehicleLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i749.AuthRepository>(
      () => _i1.AuthRepositoryImpl(
        remoteDataSource: gh<_i484.AuthRemoteDataSource>(),
        localDataSource: gh<_i1011.AuthLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$DataModule extends _i444.DataModule {}
