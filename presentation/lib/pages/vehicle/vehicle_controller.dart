import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';

class VehicleController extends BaseController {
  ServiceRecord? lastOil(GarageVehicle vehicle) => vehicle.lastOil;

  int? oilRemainingKm(GarageVehicle vehicle) => lastOil(vehicle) == null
      ? null
      : lastOil(vehicle)!.km + vehicle.oilInterval - vehicle.odometer;

  bool oilHealthy(GarageVehicle vehicle) =>
      oilRemainingKm(vehicle) != null && oilRemainingKm(vehicle)! > 0;

  double oilProgress(GarageVehicle vehicle) => lastOil(vehicle) == null
      ? 0
      : ((vehicle.odometer - lastOil(vehicle)!.km) / vehicle.oilInterval).clamp(
          0.0,
          1.0,
        );

  double yearlyMaintenanceCost(GarageVehicle vehicle) => vehicle.records
      .where(
        (record) =>
            record.date.year == DateTime.now().year &&
            record.kind != ServiceKind.fuel,
      )
      .fold(0.0, (sum, record) => sum + record.cost);

  String insuranceStatus(DateTime expiry) {
    final now = DateTime.now();
    final days = DateTime(
      expiry.year,
      expiry.month,
      expiry.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
    return days < 0
        ? LocaleKeys.expired.tr()
        : days == 0
        ? LocaleKeys.today.tr()
        : LocaleKeys.days.tr(namedArgs: {'count': '$days'});
  }
}
