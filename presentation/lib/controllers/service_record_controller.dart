import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import '../view_models/garage_vehicle_view_model.dart';

class ServiceRecordController extends BaseController {
  ServiceRecordController(ServiceKindViewModel initialKind, this.maxKm)
    : kind = initialKind.obs;
  final int? maxKm;
  final form = SmartFormController();
  final title = TextEditingController(),
      km = TextEditingController(),
      cost = TextEditingController(),
      notes = TextEditingController();
  final Rx<ServiceKindViewModel> kind;
  final date = DateTime.now().obs;
  final oil = false.obs;
  List<SmartValidator> get titleValidators => [
    SmartValidators.required(
      message: LocaleKeys.required_field.tr(
        namedArgs: {'label': LocaleKeys.what_done.tr()},
      ),
    ),
  ];
  List<SmartValidator> get kmValidators => [
    SmartValidators.required(
      message: LocaleKeys.required_field.tr(
        namedArgs: {'label': LocaleKeys.at_km.tr()},
      ),
    ),
    SmartValidators.number(message: LocaleKeys.invalid_number.tr()),
    SmartValidators.min(
      0,
      message: LocaleKeys.minimum_value.tr(namedArgs: {'value': '0'}),
    ),
    if (maxKm != null)
      SmartValidators.max(
        maxKm!,
        message: LocaleKeys.maximum_value.tr(namedArgs: {'value': '$maxKm'}),
      ),
  ];
  List<SmartValidator> get costValidators => [
    SmartValidators.number(message: LocaleKeys.invalid_number.tr()),
    SmartValidators.min(
      0,
      message: LocaleKeys.minimum_value.tr(namedArgs: {'value': '0'}),
    ),
  ];
  List<ServiceKindOptionViewItem> get kindItems => ServiceKindViewModel.values
      .map(
        (kind) => ServiceKindOptionViewItem(
          kind: kind,
          label: switch (kind) {
            ServiceKindViewModel.maintenance => LocaleKeys.maintenance.tr(),
            ServiceKindViewModel.repair => LocaleKeys.repairs.tr(),
            ServiceKindViewModel.fuel => LocaleKeys.fuel.tr(),
          },
        ),
      )
      .toList(growable: false);

  void setKind(ServiceKindViewModel? value) {
    if (value == null || !active) return;
    kind.value = value;
    if (kind.value != ServiceKindViewModel.maintenance) oil.value = false;
  }

  void setOil(bool value) {
    oil.value = value;
  }

  Future<void> pickDate(BuildContext context) async {
    final value = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (active && value != null) {
      date.value = value;
    }
  }

  Future<void> save(BuildContext context) async {
    if (!(await form.validate()).isValid || !active || !context.mounted) {
      return;
    }
    Navigator.of(context).pop<ServiceRecordEntity>(
      ServiceRecordEntity(
        title: title.text.trim(),
        date: date.value,
        km: int.parse(km.text),
        kind: switch (kind.value) {
          ServiceKindViewModel.maintenance => ServiceKind.maintenance,
          ServiceKindViewModel.repair => ServiceKind.repair,
          ServiceKindViewModel.fuel => ServiceKind.fuel,
        },
        cost: double.tryParse(cost.text) ?? 0,
        notes: notes.text.trim(),
        oil: oil.value,
      ),
    );
  }

  @override
  void onClose() {
    form.dispose();
    title.dispose();
    km.dispose();
    cost.dispose();
    notes.dispose();
    super.onClose();
  }
}

class ServiceKindOptionViewItem {
  const ServiceKindOptionViewItem({required this.kind, required this.label});

  final ServiceKindViewModel kind;
  final String label;
}
