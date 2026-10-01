import 'package:injectable/injectable.dart';
import 'package:smart_domain/smart_domain.dart';
import '../entities/garage_vehicle.dart';
import '../repositories/garage_repository.dart';

@injectable
class SaveGarageUseCase extends FutureUseCase<void, GarageVehicle> {
  const SaveGarageUseCase(this._repository);
  final GarageRepository _repository;

  @override
  Future<void> execute(GarageVehicle vehicle) => _repository.save(vehicle);
}
