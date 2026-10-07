import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import '../../controllers/base/base_controller.dart';

class AnalyticsController extends BaseController {
  double totalCost(GarageVehicle vehicle, ServiceKind kind) => vehicle.records
      .where((record) => record.kind == kind)
      .fold(0.0, (sum, record) => sum + record.cost);

  int recordCount(GarageVehicle vehicle, ServiceKind kind) =>
      vehicle.records.where((record) => record.kind == kind).length;
}
