import '../../../widgets/localized_obx.dart';
import '../../../localization/localization.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import '../../../controllers/vehicle_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/garage_widgets.dart';
import '../../../widgets/garage_button.dart';
import '../../../widgets/garage_badge.dart';
import 'vehicle_action_tile.dart';

class VehicleDashboard extends StatelessWidget {
  const VehicleDashboard({required this.controller, super.key});
  final VehicleController controller;
  GarageVehicle? get _vehicle => controller.vehicle.value;
  bool get _saving => controller.saving;

  @override
  Widget build(BuildContext context) => LocalizedObx(() => _buildPage(context));
  Widget _buildPage(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: _garage(context),
  );
  List<Widget> _garage(BuildContext context) {
    final car = _vehicle!;
    final oil = controller.lastOil;
    final remaining = controller.oilRemainingKm;
    final healthy = controller.oilHealthy;
    final spent = controller.yearlyMaintenanceCost;
    return [
      GarageCard(
        highlight: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    car.title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '${car.year}',
                  style: TextStyle(color: AppColors.primaryAmberLight),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (car.body.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(car.body, style: TextStyle(color: Colors.white54)),
              ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.odometer_label.tr(),
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(text: distance(car.odometer)),
                  ],
                ),
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 18),
      GarageCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.oil_barrel_outlined, color: AppColors.primaryAmber),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    LocaleKeys.engine_oil.tr(),
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                _badge(
                  oil == null
                      ? LocaleKeys.unknown.tr()
                      : healthy
                      ? LocaleKeys.healthy.tr()
                      : LocaleKeys.due.tr(),
                  healthy ? AppColors.statusGreen : AppColors.primaryAmber,
                ),
              ],
            ),
            SizedBox(height: 20),
            if (oil != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: controller.oilProgress,
                  minHeight: 9,
                  backgroundColor: Colors.white12,
                ),
              ),
              SizedBox(height: 16),
              _detail(
                LocaleKeys.changed.tr(),
                LocaleKeys.oil_changed_details.tr(
                  namedArgs: {
                    'km': kilometres(oil.km),
                    'date': displayDate(oil.date),
                  },
                ),
              ),
              _detail(LocaleKeys.next.tr(), distance(oil.km + car.oilInterval)),
              Text(
                remaining! >= 0
                    ? LocaleKeys.km_remaining.tr(
                        namedArgs: {'value': kilometres(remaining)},
                      )
                    : LocaleKeys.km_overdue.tr(
                        namedArgs: {'value': kilometres(-remaining)},
                      ),
                style: TextStyle(
                  color: healthy
                      ? AppColors.primaryAmberLight
                      : AppColors.statusDanger,
                  fontSize: 17,
                ),
              ),
            ] else ...[
              Text(
                LocaleKeys.oil_history_hint.tr(),
                style: TextStyle(color: Colors.white60, height: 1.5),
              ),
              GarageButton.text(
                onPressed: _saving
                    ? null
                    : () => controller.addRecord(
                        context,
                        ServiceKind.maintenance,
                      ),
                child: Text(LocaleKeys.log_oil.tr()),
              ),
            ],
          ],
        ),
      ),
      SizedBox(height: 18),
      GarageCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primaryAmber,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    LocaleKeys.insurance.tr(),
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                if (car.insuranceExpiry != null)
                  _badge(
                    controller.insuranceStatus(car.insuranceExpiry!),
                    AppColors.primaryAmber,
                  ),
              ],
            ),
            SizedBox(height: 12),
            _detail(
              LocaleKeys.expires.tr(),
              car.insuranceExpiry == null
                  ? LocaleKeys.not_added.tr()
                  : displayDate(car.insuranceExpiry!),
            ),
          ],
        ),
      ),
      SizedBox(height: 18),
      GarageCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.handyman_outlined, color: AppColors.primaryAmber),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    LocaleKeys.yearly_maintenance.tr(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            Text(money(spent), style: TextStyle(fontSize: 24)),
            Text(
              LocaleKeys.spent_year.tr(
                namedArgs: {'year': '${DateTime.now().year}'},
              ),
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
      SizedBox(height: 18),
      LayoutBuilder(
        builder: (context, constraints) => Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _action(
              LocaleKeys.log_service.tr(),
              Icons.build_rounded,
              () => controller.addRecord(context, ServiceKind.maintenance),
              (constraints.maxWidth - 20) / 3,
            ),
            _action(
              LocaleKeys.add_fuel.tr(),
              Icons.local_gas_station_rounded,
              () => controller.addRecord(context, ServiceKind.fuel),
              (constraints.maxWidth - 20) / 3,
            ),
            _action(
              LocaleKeys.odometer_action.tr(),
              Icons.speed_rounded,
              () => controller.updateOdometer(context),
              (constraints.maxWidth - 20) / 3,
            ),
          ],
        ),
      ),
    ];
  }

  Widget _badge(String text, Color color) => GarageBadge(text, color: color);
  Widget _detail(String label, String value) => Padding(
    padding: EdgeInsets.only(bottom: 7),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(color: Colors.white54),
          ),
          TextSpan(text: value),
        ],
      ),
      style: TextStyle(fontSize: 16),
    ),
  );
  Widget _action(
    String label,
    IconData icon,
    VoidCallback action,
    double width,
  ) => SizedBox(
    width: width,
    child: VehicleActionTile(
      label: label,
      icon: icon,
      onPressed: _saving ? null : action,
    ),
  );
}
