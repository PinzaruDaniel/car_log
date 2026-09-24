import 'package:get/get.dart';
import 'package:domain/features/vehicle/usecases/get_vehicle_list_use_case.dart';
import 'package:get_it/get_it.dart';

class VehicleController extends GetxController {
  final _getVehicleListUseCase = GetIt.instance.get<GetVehicleListUseCase>();

  final items = <String>[].obs;

  Future<void> load() async {
    final result = await _getVehicleListUseCase();
    result.fold(
      (failure) => items.clear(),
      (entities) => items.assignAll(entities.map((entity) => entity.remoteId)),
    );
  }
}
