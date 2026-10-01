import '../../../widgets/localized_obx.dart';
import '../../../localization/localization.dart';
import 'package:flutter/material.dart';
import '../../../widgets/garage_button.dart';
import 'package:flutter/services.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import '../../../controllers/vehicle_onboarding_controller.dart';
import '../../../widgets/garage_widgets.dart';
import '../../../utils/app_colors.dart';

class VehicleSetupSteps extends StatelessWidget {
  const VehicleSetupSteps({required this.controller, super.key});
  final VehicleOnboardingController controller;
  SmartFormController get _carForm => controller.carForm;
  SmartFormController get _serviceForm => controller.serviceForm;
  TextEditingController get _vin => controller.vin;
  Map<String, TextEditingController> get _fields => controller.fields;
  List<ServiceRecord> get _records => controller.records;
  Map<String, String> get _found => controller.found;
  bool get _details => controller.details.value;
  bool get _busy => controller.busy;
  bool get _oilKnown => controller.oilKnown.value;
  int get _step => controller.step.value;
  DateTime? get _oilDate => controller.oilDate.value;
  DateTime? get _insurance => controller.insurance.value;
  List<String> get _filters => controller.filters;

  @override
  Widget build(BuildContext context) => LocalizedObx(() => _buildPage(context));
  Widget _buildPage(BuildContext context) => AnimatedSize(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    alignment: Alignment.topCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Each controller keeps exactly one form, even during rapid step changes.
        Visibility(visible: _step == 0, maintainState: true, child: _carStep()),
        Visibility(
          visible: _step == 1,
          maintainState: true,
          child: _serviceStep(context),
        ),
      ],
    ),
  );
  Widget _field(
    String name,
    String label, {
    bool required = false,
    bool number = false,
    int? min,
    int? max,
  }) => Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: SmartTextField(
      name: name,
      controller: _fields[name],
      keyboardType: number ? TextInputType.number : TextInputType.text,
      inputFormatters: number ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: _found.containsKey(name)
            ? Tooltip(
                message: LocaleKeys.decoded_field.tr(),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.statusGreen,
                ),
              )
            : null,
      ),
      validators: controller.validators(
        label: label,
        required: required,
        number: number,
        min: min,
        max: max,
      ),
    ),
  );

  Widget _carStep() => SmartForm.withChild(
    key: ValueKey('car'),
    controller: _carForm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          LocaleKeys.meet_car.tr(),
          subtitle: LocaleKeys.meet_car_description.tr(),
        ),
        TextField(
          controller: _vin,
          enabled: !_busy,
          textCapitalization: TextCapitalization.characters,
          maxLength: 17,
          decoration: InputDecoration(
            labelText: LocaleKeys.vin_code.tr(),
            hintText: LocaleKeys.vin_hint.tr(),
            prefixIcon: Icon(Icons.pin_outlined),
          ),
        ),
        GarageButton.filled(
          onPressed: _busy ? null : controller.decode,
          icon: Icon(Icons.search),
          label: Text(
            _busy ? LocaleKeys.finding_car.tr() : LocaleKeys.find_car.tr(),
          ),
        ),
        SizedBox(height: 8),
        GarageButton.text(
          onPressed: _busy ? null : controller.useManualEntry,
          child: Text(LocaleKeys.manual_entry.tr()),
        ),
        Text(
          LocaleKeys.vin_coverage.tr(),
          style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.5),
        ),
        SizedBox(height: 20),
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          alignment: Alignment.topCenter,
          child: Visibility(
            visible: _details,
            maintainState: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionTitle(
                  LocaleKeys.car_details.tr(),
                  subtitle: LocaleKeys.decoded_fields_description.tr(),
                ),
                _field('make', LocaleKeys.make.tr(), required: true),
                _field('model', LocaleKeys.model.tr(), required: true),
                _field(
                  'year',
                  LocaleKeys.year.tr(),
                  required: true,
                  number: true,
                  min: 1886,
                  max: DateTime.now().year + 1,
                ),
                _field('body', LocaleKeys.body_optional.tr()),
                _field('fuel', LocaleKeys.fuel_optional.tr()),
                _field('engine', LocaleKeys.engine_optional.tr()),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _serviceStep(BuildContext context) => Column(
    key: ValueKey('service'),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionTitle(
        LocaleKeys.service_setup.tr(),
        subtitle: LocaleKeys.service_setup_description.tr(
          namedArgs: {
            'car': '${_fields['make']!.text} ${_fields['model']!.text}',
          },
        ),
      ),
      SmartForm(
        controller: _serviceForm,
        children: [
          _field(
            'odometer',
            LocaleKeys.current_odometer.tr(),
            required: true,
            number: true,
            min: 0,
          ),
          _field(
            'interval',
            LocaleKeys.oil_change_interval.tr(),
            required: true,
            number: true,
            min: 1,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              LocaleKeys.oil_interval_hint.tr(),
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(LocaleKeys.know_oil_change.tr()),
            value: _oilKnown,
            onChanged: controller.setOilKnown,
          ),
          if (_oilKnown) ...[
            _field(
              'oilKm',
              LocaleKeys.oil_changed_at.tr(),
              required: true,
              number: true,
              min: 0,
            ),
            _field(
              'oilCost',
              LocaleKeys.oil_cost_optional.tr(),
              number: true,
              min: 0,
            ),
            GarageButton.outlined(
              onPressed: () => controller.pickOilDate(context),
              icon: Icon(Icons.calendar_month),
              label: Text(
                _oilDate == null
                    ? LocaleKeys.choose_oil_date.tr()
                    : displayDate(_oilDate!),
              ),
            ),
            GarageButton.outlined(
              onPressed: () => controller.pickFilters(context),
              icon: Icon(Icons.filter_alt_outlined),
              label: Text(
                _filters.isEmpty
                    ? LocaleKeys.select_filters.tr()
                    : _filters.map(filterLabel).join(', '),
              ),
            ),
          ],
        ],
      ),
      SizedBox(height: 24),
      SectionTitle(
        LocaleKeys.repairs_service.tr(),
        subtitle: LocaleKeys.repairs_optional.tr(),
      ),
      for (final record in _records)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(recordTitle(record)),
          subtitle: Text(
            LocaleKeys.service_date_km.tr(
              namedArgs: {
                'date': displayDate(record.date),
                'km': kilometres(record.km),
              },
            ),
          ),
          trailing: GarageButton.icon(
            onPressed: () => controller.removeRecord(record),
            icon: Icon(Icons.close),
            tooltip: LocaleKeys.remove_record.tr(),
          ),
        ),
      GarageButton.outlined(
        onPressed: () => controller.addRecord(context),
        icon: Icon(Icons.add),
        label: Text(LocaleKeys.add_repair.tr()),
      ),
      SizedBox(height: 24),
      GarageButton.outlined(
        onPressed: () => controller.pickInsuranceDate(context),
        icon: Icon(Icons.verified_user_outlined),
        label: Text(
          _insurance == null
              ? LocaleKeys.insurance_optional.tr()
              : LocaleKeys.insurance_date.tr(
                  namedArgs: {'date': displayDate(_insurance!)},
                ),
        ),
      ),
      SizedBox(height: 24),
    ],
  );
}
