import 'package:dartz/dartz.dart';

import 'package:domain/failures/failure.dart';
import '../entities/vehicle_entity.dart';

abstract interface class VehicleRepository {
  Future<Either<Failure, List<VehicleEntity>>> getVehicleList();
}
