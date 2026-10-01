import 'package:injectable/injectable.dart';
import 'package:smart_domain/smart_domain.dart';
import '../entities/garage_vehicle.dart';
import '../repositories/garage_repository.dart';

/// Reads the saved garage from the local cache (including legacy import).
@injectable
class GetGarageUseCase extends NoParamsFutureUseCase<GarageVehicle?> {
  const GetGarageUseCase(this._repository);
  final GarageRepository _repository;

  @override
  Future<GarageVehicle?> execute() => _repository.load();
}
