import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failures/failure.dart';
import 'package:domain/features/vehicle/entities/vehicle_entity.dart';
import 'package:domain/features/vehicle/repositories/vehicle_repository.dart';
import '../mappers/vehicle_mapper.dart';
import '../local/vehicle_local_data_source.dart';
import '../remote/vehicle_remote_data_source.dart';

@LazySingleton(as: VehicleRepository)
class VehicleRepositoryImpl implements VehicleRepository {
  const VehicleRepositoryImpl({
    required VehicleRemoteDataSource remoteDataSource,
    required VehicleLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final VehicleRemoteDataSource _remoteDataSource;
  final VehicleLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<VehicleEntity>>> getVehicleList() async {
    try {
      final items = await _remoteDataSource.getItems();
      await _localDataSource.cacheItems(items);
      return right(
        items.map((item) => item.toEntity()).toList(growable: false),
      );
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }
}
