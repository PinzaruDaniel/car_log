import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/repositories/garage_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_repository/smart_repository.dart';
import '../local/garage_local_data_source.dart';
import '../mappers/vin_mapper.dart';
import '../remote/vin_remote_data_source.dart';

@LazySingleton(as: GarageRepository)
class GarageRepositoryImpl implements GarageRepository {
  GarageRepositoryImpl(this._local, this._remote);
  final GarageLocalDataSource _local;
  final VinRemoteDataSource _remote;
  final _vinCache = <String, Map<String, String>>{};
  late final _vinRepository =
      SmartRepositoryFamily<String, Map<String, String>>(
        remote: (vin) async =>
            (await _remote.decodeVin(vin)).toVehicleDetails(),
        local: (vin) => _vinCache[vin],
        saveLocal: (vin, details) => _vinCache[vin] = details,
        shouldPersist: (_, details) =>
            details.keys.any((key) => key != '_warning'),
        config: const SmartRepositoryConfig(
          defaultPolicy: RepositoryPolicy.cacheFirst,
        ),
      );

  @override
  Future<GarageVehicleEntity?> load() => _local.load();
  @override
  Future<void> save(GarageVehicleEntity vehicle) => _local.save(vehicle);
  @override
  Future<Map<String, String>> decodeVin(String vin) async =>
      (await _vinRepository.get(vin)).getOrThrow();
}
