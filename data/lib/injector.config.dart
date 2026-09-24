// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:data/data_module.dart' as _i1058;
import 'package:data/features/auth/local/auth_local_data_source.dart' as _i201;
import 'package:data/features/auth/local/models/auth_box.dart' as _i691;
import 'package:data/features/auth/remote/auth_remote_data_source.dart'
    as _i211;
import 'package:data/features/auth/repositories/auth_repository_impl.dart'
    as _i726;
import 'package:data/features/vehicle/local/models/vehicle_box.dart' as _i124;
import 'package:data/features/vehicle/local/vehicle_local_data_source.dart'
    as _i807;
import 'package:data/features/vehicle/remote/vehicle_remote_data_source.dart'
    as _i92;
import 'package:data/features/vehicle/repositories/vehicle_repository_impl.dart'
    as _i590;
import 'package:data/objectbox.g.dart' as _i337;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/features/auth/repositories/auth_repository.dart'
    as _i749;
import 'package:domain/features/vehicle/repositories/vehicle_repository.dart'
    as _i1065;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:objectbox/objectbox.dart' as _i1034;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dataModule = _$DataModule();
    await gh.lazySingletonAsync<_i337.Store>(
      () => dataModule.asyncCreateStore(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(
      () => dataModule.mainDio(),
      instanceName: 'main_dio',
    );
    gh.lazySingleton<_i361.Dio>(
      () => dataModule.authDio(),
      instanceName: 'auth_dio',
    );
    gh.lazySingleton<_i337.Box<_i124.VehicleBox>>(
      () => dataModule.vehicleBox(gh<_i337.Store>()),
    );
    gh.lazySingleton<_i337.Box<_i691.AuthBox>>(
      () => dataModule.authBox(gh<_i337.Store>()),
    );
    gh.lazySingleton<_i211.AuthRemoteDataSource>(
      () => _i211.AuthRemoteDataSource(gh<_i361.Dio>(instanceName: 'main_dio')),
    );
    gh.lazySingleton<_i92.VehicleRemoteDataSource>(
      () =>
          _i92.VehicleRemoteDataSource(gh<_i361.Dio>(instanceName: 'main_dio')),
    );
    gh.lazySingleton<_i807.VehicleLocalDataSource>(
      () =>
          _i807.VehicleLocalDataSourceImpl(gh<_i1034.Box<_i124.VehicleBox>>()),
    );
    gh.lazySingleton<_i201.AuthLocalDataSource>(
      () => _i201.AuthLocalDataSourceImpl(gh<_i1034.Box<_i691.AuthBox>>()),
    );
    gh.lazySingleton<_i1065.VehicleRepository>(
      () => _i590.VehicleRepositoryImpl(
        remoteDataSource: gh<_i92.VehicleRemoteDataSource>(),
        localDataSource: gh<_i807.VehicleLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i749.AuthRepository>(
      () => _i726.AuthRepositoryImpl(
        remoteDataSource: gh<_i211.AuthRemoteDataSource>(),
        localDataSource: gh<_i201.AuthLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$DataModule extends _i1058.DataModule {}
