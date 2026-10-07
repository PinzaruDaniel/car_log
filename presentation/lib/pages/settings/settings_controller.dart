import 'package:flutter/material.dart';
import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';
import '../../view_models/garage_vehicle_view_model.dart';
import '../../widgets/garage_widgets.dart';

class SettingsController extends BaseController {
  SettingsViewItem buildViewItem(GarageVehicleViewModel vehicle) =>
      SettingsViewItem(
        title: vehicle.title,
        details: [
          SettingsDetailViewItem(
            label: LocaleKeys.year.tr(),
            value: '${vehicle.year}',
          ),
          if (vehicle.vin.isNotEmpty)
            SettingsDetailViewItem(
              label: LocaleKeys.vin.tr(),
              value: vehicle.vin,
            ),
          if (vehicle.body.isNotEmpty)
            SettingsDetailViewItem(
              label: LocaleKeys.body.tr(),
              value: vehicle.body,
            ),
          if (vehicle.fuel.isNotEmpty)
            SettingsDetailViewItem(
              label: LocaleKeys.fuel.tr(),
              value: vehicle.fuel,
            ),
          if (vehicle.engine.isNotEmpty)
            SettingsDetailViewItem(
              label: LocaleKeys.engine.tr(),
              value: LocaleKeys.litres.tr(namedArgs: {'value': vehicle.engine}),
            ),
          SettingsDetailViewItem(
            label: LocaleKeys.oil_interval.tr(),
            value: distance(vehicle.oilInterval),
          ),
        ],
        storageTitle: LocaleKeys.saved_device.tr(),
        storageDescription: LocaleKeys.offline_description.tr(),
      );

  Future<void> changeLanguage(BuildContext context, Locale? locale) async {
    if (locale != null) await context.setLocale(locale);
  }
}

class SettingsViewItem {
  const SettingsViewItem({
    required this.title,
    required this.details,
    required this.storageTitle,
    required this.storageDescription,
  });

  final String title;
  final List<SettingsDetailViewItem> details;
  final String storageTitle;
  final String storageDescription;
}

class SettingsDetailViewItem {
  const SettingsDetailViewItem({required this.label, required this.value});

  final String label;
  final String value;
}
