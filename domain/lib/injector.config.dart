// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:domain/features/auth/repositories/auth_repository.dart'
    as _i749;
import 'package:domain/features/auth/usecases/get_auth_list_use_case.dart'
    as _i374;
import 'package:domain/features/garage/repositories/garage_repository.dart'
    as _i496;
import 'package:domain/features/garage/usecases/get_garage_use_case.dart'
    as _i543;
import 'package:domain/features/garage/usecases/save_garage_use_case.dart'
    as _i435;
import 'package:domain/features/vehicle/repositories/vehicle_repository.dart'
    as _i1065;
import 'package:domain/features/vehicle/usecases/decode_vin_use_case.dart'
    as _i331;
import 'package:domain/features/vehicle/usecases/get_vehicle_list_use_case.dart'
    as _i483;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i543.GetGarageUseCase>(
      () => _i543.GetGarageUseCase(gh<_i496.GarageRepository>()),
    );
    gh.factory<_i435.SaveGarageUseCase>(
      () => _i435.SaveGarageUseCase(gh<_i496.GarageRepository>()),
    );
    gh.factory<_i331.DecodeVinUseCase>(
      () => _i331.DecodeVinUseCase(gh<_i496.GarageRepository>()),
    );
    gh.lazySingleton<_i374.GetAuthListUseCase>(
      () => _i374.GetAuthListUseCase(gh<_i749.AuthRepository>()),
    );
    gh.lazySingleton<_i483.GetVehicleListUseCase>(
      () => _i483.GetVehicleListUseCase(gh<_i1065.VehicleRepository>()),
    );
    return this;
  }
}
