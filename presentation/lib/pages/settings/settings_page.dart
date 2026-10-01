import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:flutter/material.dart';
import '../../controllers/vehicle_controller.dart';
import '../../widgets/garage_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.controller, super.key});
  final VehicleController controller;
  GarageVehicle? get _vehicle => controller.vehicle.value;
  @override
  Widget build(BuildContext context) => LocalizedObx(() => _buildPage(context));
  Widget _buildPage(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: _settings(context),
  );
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
  List<Widget> _settings(BuildContext context) => [
    GarageCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(_vehicle!.title),
          _detail(LocaleKeys.year.tr(), '${_vehicle!.year}'),
          if (_vehicle!.vin.isNotEmpty)
            _detail(LocaleKeys.vin.tr(), _vehicle!.vin),
          if (_vehicle!.body.isNotEmpty)
            _detail(LocaleKeys.body.tr(), _vehicle!.body),
          if (_vehicle!.fuel.isNotEmpty)
            _detail(LocaleKeys.fuel.tr(), _vehicle!.fuel),
          if (_vehicle!.engine.isNotEmpty)
            _detail(
              LocaleKeys.engine.tr(),
              LocaleKeys.litres.tr(namedArgs: {'value': _vehicle!.engine}),
            ),
          _detail(
            LocaleKeys.oil_interval.tr(),
            distance(_vehicle!.oilInterval),
          ),
          Divider(height: 32),
          Text(
            LocaleKeys.saved_device.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            LocaleKeys.offline_description.tr(),
            style: TextStyle(color: Colors.white54, height: 1.5),
          ),
        ],
      ),
    ),
    const SizedBox(height: 18),
    GarageCard(
      child: DropdownButtonFormField<Locale>(
        initialValue: context.locale,
        decoration: InputDecoration(labelText: LocaleKeys.language.tr()),
        items: [
          DropdownMenuItem(
            value: const Locale('en'),
            child: Text(LocaleKeys.english.tr()),
          ),
          DropdownMenuItem(
            value: const Locale('ro'),
            child: Text(LocaleKeys.romanian.tr()),
          ),
        ],
        onChanged: (locale) {
          if (locale != null) context.setLocale(locale);
        },
      ),
    ),
  ];
}
