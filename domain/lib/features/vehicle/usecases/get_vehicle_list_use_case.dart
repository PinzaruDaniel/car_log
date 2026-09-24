import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/failures/failure.dart';
import '../entities/vehicle_entity.dart';
import '../repositories/vehicle_repository.dart';

@lazySingleton
class GetVehicleListUseCase {
  const GetVehicleListUseCase(this._repository);

  final VehicleRepository _repository;

  Future<Either<Failure, List<VehicleEntity>>> call() {
    return _repository.getVehicleList();
  }
}
