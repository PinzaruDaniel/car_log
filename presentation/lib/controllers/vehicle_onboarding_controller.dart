import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/usecases/save_garage_use_case.dart';
import 'package:domain/features/vehicle/usecases/decode_vin_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import 'package:selection_sheet/selection_sheet.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import '../view_models/garage_vehicle_view_model.dart';
import '../widgets/garage_widgets.dart';
import '../widgets/service_record_editor.dart';
import 'mappers/garage_vehicle_view_model_mapper.dart';
import 'service_record_controller.dart';

class VehicleOnboardingController extends BaseController {
  VehicleOnboardingController({
    SaveGarageUseCase? saveGarageUseCase,
    DecodeVinUseCase? decodeVinUseCase,
  }) : _saveOverride = saveGarageUseCase,
       _decodeOverride = decodeVinUseCase {
    fields['interval']!.text = '10000';
  }
  final SaveGarageUseCase? _saveOverride;
  final DecodeVinUseCase? _decodeOverride;
  SaveGarageUseCase get _saveGarageUseCase =>
      _saveOverride ?? getInstance<SaveGarageUseCase>();
  DecodeVinUseCase get decodeVinUseCase =>
      _decodeOverride ?? getInstance<DecodeVinUseCase>();
  final onSaved = Rxn<ValueChanged<GarageVehicleViewModel>>();
  static const decodeKey = 'decodeVin', saveKey = 'saveGarage';
  bool get busy => containPendingKey(decodeKey) || containPendingKey(saveKey);
  final carForm = SmartFormController();
  final serviceForm = SmartFormController();
  final vin = TextEditingController();
  final fields = {
    for (final name in [
      'make',
      'model',
      'year',
      'body',
      'fuel',
      'engine',
      'odometer',
      'interval',
      'oilKm',
      'oilCost',
    ])
      name: TextEditingController(),
  };
  final records = <OnboardingServiceRecordViewItem>[].obs;
  final List<ServiceRecordEntity> _recordEntities = [];
  final found = <String, String>{}.obs;
  final details = false.obs, oilKnown = false.obs;
  final step = 0.obs;
  final message = RxnString();
  final hasVinWarning = false.obs;
  final oilDate = Rxn<DateTime>(), insurance = Rxn<DateTime>();
  final filters = <String>[].obs;

  List<SmartValidator> validators({
    required String label,
    bool required = false,
    bool number = false,
    int? min,
    int? max,
  }) => [
    if (required)
      SmartValidators.required(
        message: LocaleKeys.required_field.tr(namedArgs: {'label': label}),
      ),
    if (number) SmartValidators.number(message: LocaleKeys.invalid_number.tr()),
    if (min != null)
      SmartValidators.min(
        min,
        message: LocaleKeys.minimum_value.tr(namedArgs: {'value': '$min'}),
      ),
    if (max != null)
      SmartValidators.max(
        max,
        message: LocaleKeys.maximum_value.tr(namedArgs: {'value': '$max'}),
      ),
  ];

  void mutate(VoidCallback change) {
    if (!active) return;
    change();
  }

  void goBack() {
    if (!active || busy) return;
    FocusManager.instance.primaryFocus?.unfocus();
    step.value = 0;
  }

  void useManualEntry() => mutate(() {
    details.value = true;
    hasVinWarning.value = false;
    message.value = LocaleKeys.manual_message;
  });
  void setOilKnown(bool value) => mutate(() => oilKnown.value = value);
  void removeRecord(OnboardingServiceRecordViewItem value) => mutate(() {
    final index = records.indexOf(value);
    if (index < 0) return;
    records.removeAt(index);
    _recordEntities.removeAt(index);
  });
  Future<void> pickOilDate(BuildContext context) async {
    final value = await showDatePicker(
      context: context,
      initialDate: oilDate.value ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (active && value != null) mutate(() => oilDate.value = value);
  }

  Future<void> pickFilters(BuildContext context) async {
    final values = await SelectionSheet.showMulti<String>(
      context: context,
      title: LocaleKeys.filters_title.tr(),
      items: [
        LocaleKeys.oil_filter,
        LocaleKeys.air_filter,
        LocaleKeys.cabin_filter,
        LocaleKeys.fuel_filter,
      ],
      initialSelection: filters,
      itemLabelBuilder: (item) => item.tr(),
    );
    if (active && values != null) mutate(() => filters.assignAll(values));
  }

  Future<void> addRecord(BuildContext context) async {
    final editor = ServiceRecordController(
      ServiceKindViewModel.repair,
      int.tryParse(fields['odometer']!.text),
    );
    final value = await showModalBottomSheet<ServiceRecordEntity>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ServiceRecordEditor(controller: editor),
    );
    if (active && value != null) {
      mutate(() {
        _recordEntities.add(value);
        records.add(_recordViewItem(value));
      });
    }
  }

  Future<void> pickInsuranceDate(BuildContext context) async {
    final value = await showDatePicker(
      context: context,
      initialDate: insurance.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (active && value != null) mutate(() => insurance.value = value);
  }

  Future<void> decode() async {
    if (busy || !active) return;
    message.value = null;
    hasVinWarning.value = false;
    final result = await runPending(
      decodeKey,
      () => decodeVinUseCase(vin.text),
    );
    if (!active) return;
    result.fold(
      onSuccess: (data) {
        for (final old in found.entries) {
          if (fields[old.key]?.text == old.value) {
            fields[old.key]!.clear();
          }
        }
        found.assignAll({...data}..remove('_warning'));
        for (final entry in found.entries) {
          fields[entry.key]?.text = entry.value;
        }
        details.value = true;
        message.value = found.isEmpty
            ? LocaleKeys.vin_no_details
            : LocaleKeys.vin_found_details;
        hasVinWarning.value = data['_warning'] != null;
      },
      onFailure: (error) => message.value = error,
    );
  }

  Future<void> next(BuildContext context) async {
    if (busy) return;
    if (step.value == 0) {
      if (vin.text.trim().isNotEmpty &&
          !RegExp(
            r'^[A-HJ-NPR-Z0-9]{17}$',
          ).hasMatch(vin.text.trim().toUpperCase())) {
        showError(context, LocaleKeys.vin_invalid_manual);
        return;
      }
      if (!(await carForm.validate()).isValid || !active || !context.mounted) {
        return;
      }
      FocusScope.of(context).unfocus();
      mutate(() {
        step.value = 1;
        message.value = null;
      });
      return;
    }
    if (!(await serviceForm.validate()).isValid ||
        !active ||
        !context.mounted) {
      return;
    }
    final odometer = int.parse(fields['odometer']!.text);
    if (oilKnown.value && oilDate.value == null) {
      showError(context, LocaleKeys.choose_oil_date_error);
      return;
    }
    final oilKm = int.tryParse(fields['oilKm']!.text);
    if (oilKnown.value && oilKm != null && oilKm > odometer ||
        _recordEntities.any((record) => record.km > odometer)) {
      showError(context, LocaleKeys.service_km_error);
      return;
    }
    final vehicle = GarageVehicleEntity(
      make: fields['make']!.text.trim(),
      model: fields['model']!.text.trim(),
      year: int.parse(fields['year']!.text),
      vin: vin.text.trim().toUpperCase(),
      body: fields['body']!.text.trim(),
      fuel: fields['fuel']!.text.trim(),
      engine: fields['engine']!.text.trim(),
      odometer: odometer,
      oilInterval: int.parse(fields['interval']!.text),
      insuranceExpiry: insurance.value,
      records: [
        ..._recordEntities,
        if (oilKnown.value)
          ServiceRecordEntity(
            title: LocaleKeys.oil_filters_service,
            date: oilDate.value!,
            km: oilKm!,
            kind: ServiceKind.maintenance,
            cost: double.tryParse(fields['oilCost']!.text) ?? 0,
            notes: filters.join(' · '),
            oil: true,
          ),
      ],
    );
    startLoading([saveKey]);
    try {
      await _saveGarageUseCase(vehicle);
      if (active && context.mounted) onSaved.value?.call(vehicle.toViewModel());
    } catch (_) {
      if (active && context.mounted) {
        showError(context, LocaleKeys.garage_save_error);
      }
    } finally {
      stopLoading([saveKey]);
    }
  }

  void showError(BuildContext context, String value) {
    mutate(() => message.value = value);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(value.tr())));
  }

  OnboardingServiceRecordViewItem _recordViewItem(ServiceRecordEntity entity) =>
      OnboardingServiceRecordViewItem(
        title: entity.title == LocaleKeys.oil_filters_service
            ? LocaleKeys.oil_filters_service.tr()
            : entity.title,
        subtitle: LocaleKeys.service_date_km.tr(
          namedArgs: {
            'date': displayDate(entity.date),
            'km': kilometres(entity.km),
          },
        ),
      );

  @override
  void onClose() {
    onSaved.value = null;
    carForm.dispose();
    serviceForm.dispose();
    vin.dispose();
    for (final field in fields.values) {
      field.dispose();
    }
    super.onClose();
  }
}

class OnboardingServiceRecordViewItem {
  const OnboardingServiceRecordViewItem({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}
