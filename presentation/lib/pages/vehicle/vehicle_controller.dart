import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';
import '../../view_models/garage_vehicle_view_model.dart';
import '../../widgets/garage_widgets.dart';

class VehicleController extends BaseController {
  VehicleViewItem buildViewItem(GarageVehicleViewModel vehicle) {
    final lastOil = _lastOil(vehicle);
    final remainingKm = lastOil == null ? null : lastOil.km + vehicle.oilInterval - vehicle.odometer;
    final oilHealthy = remainingKm != null && remainingKm > 0;
    final progress = lastOil == null ? 0.0 : ((vehicle.odometer - lastOil.km) / vehicle.oilInterval).clamp(0.0, 1.0);
    final yearlyMaintenanceCost = vehicle.records
        .where((record) => record.date.year == DateTime.now().year && record.kind != ServiceKindViewModel.fuel)
        .fold(0.0, (sum, record) => sum + record.cost);

    return VehicleViewItem(
      title: vehicle.title,
      year: '${vehicle.year}',
      body: vehicle.body,
      odometer: distance(vehicle.odometer),
      oil: VehicleOilViewItem(
        known: lastOil != null,
        healthy: oilHealthy,
        status: lastOil == null
            ? LocaleKeys.unknown.tr()
            : oilHealthy
            ? LocaleKeys.healthy.tr()
            : LocaleKeys.due.tr(),
        progress: progress,
        changedDetails: lastOil == null
            ? null
            : LocaleKeys.oil_changed_details.tr(
                namedArgs: {'km': kilometres(lastOil.km), 'date': displayDate(lastOil.date)},
              ),
        nextChange: lastOil == null ? null : distance(lastOil.km + vehicle.oilInterval),
        remaining: remainingKm == null
            ? null
            : remainingKm >= 0
            ? LocaleKeys.km_remaining.tr(namedArgs: {'value': kilometres(remainingKm)})
            : LocaleKeys.km_overdue.tr(namedArgs: {'value': kilometres(-remainingKm)}),
      ),
      insuranceStatus: vehicle.insuranceExpiry == null ? null : _insuranceStatus(vehicle.insuranceExpiry!),
      insuranceExpiry: vehicle.insuranceExpiry == null
          ? LocaleKeys.not_added.tr()
          : displayDate(vehicle.insuranceExpiry!),
      yearlyMaintenanceCost: money(yearlyMaintenanceCost),
      maintenanceYear: '${DateTime.now().year}',
    );
  }

  ServiceRecordViewModel? _lastOil(GarageVehicleViewModel vehicle) {
    final oils = vehicle.records.where((record) => record.oil).toList()
      ..sort((a, b) {
        final kmOrder = b.km.compareTo(a.km);
        return kmOrder == 0 ? b.date.compareTo(a.date) : kmOrder;
      });
    return oils.firstOrNull;
  }

  String _insuranceStatus(DateTime expiry) {
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

class VehicleViewItem {
  const VehicleViewItem({
    required this.title,
    required this.year,
    required this.body,
    required this.odometer,
    required this.oil,
    required this.insuranceStatus,
    required this.insuranceExpiry,
    required this.yearlyMaintenanceCost,
    required this.maintenanceYear,
  });

  final String title;
  final String year;
  final String body;
  final String odometer;
  final VehicleOilViewItem oil;
  final String? insuranceStatus;
  final String insuranceExpiry;
  final String yearlyMaintenanceCost;
  final String maintenanceYear;
}

class VehicleOilViewItem {
  const VehicleOilViewItem({
    required this.known,
    required this.healthy,
    required this.status,
    required this.progress,
    required this.changedDetails,
    required this.nextChange,
    required this.remaining,
  });

  final bool known;
  final bool healthy;
  final String status;
  final double progress;
  final String? changedDetails;
  final String? nextChange;
  final String? remaining;
}
