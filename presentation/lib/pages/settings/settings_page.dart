import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import '../../controllers/base/imports/controller_imports.dart';
import '../../page+state/base_state.dart';
import '../../widgets/garage_widgets.dart';
import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsPage, SettingsController> {
  @override
  SettingsController buildController() => SettingsController();

  @override
  Widget build(BuildContext context) => LocalizedObx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _settings(
        context,
        controller.buildViewItem(mainAppController.vehicle.value!),
      ),
    ),
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
  List<Widget> _settings(BuildContext context, SettingsViewItem item) => [
    GarageCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(item.title),
          for (final detail in item.details)
            _detail(detail.label, detail.value),
          Divider(height: 32),
          Text(
            item.storageTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            item.storageDescription,
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
        onChanged: (locale) => controller.changeLanguage(context, locale),
      ),
    ),
  ];
}
