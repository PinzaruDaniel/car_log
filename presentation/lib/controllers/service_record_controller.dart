import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

class ServiceRecordController extends BaseController {
  ServiceRecordController(ServiceKind initialKind, this.maxKm)
    : kind = initialKind.obs;
  final int? maxKm;
  final form = SmartFormController();
  final title = TextEditingController(),
      km = TextEditingController(),
      cost = TextEditingController(),
      notes = TextEditingController();
  final Rx<ServiceKind> kind;
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
  void setKind(ServiceKind? value) {
    if (value == null || !active) return;
    kind.value = value;
    if (kind.value != ServiceKind.maintenance) oil.value = false;
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
    Navigator.of(context).pop(
      ServiceRecord(
        title: title.text.trim(),
        date: date.value,
        km: int.parse(km.text),
        kind: kind.value,
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
