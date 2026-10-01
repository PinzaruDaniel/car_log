import 'localized_obx.dart';
import '../localization/localization.dart';
import 'package:flutter/material.dart';
import 'garage_button.dart';
import 'package:flutter/services.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import '../controllers/service_record_controller.dart';
import 'garage_widgets.dart';

class ServiceRecordEditor extends StatefulWidget {
  const ServiceRecordEditor({required this.controller, super.key});
  final ServiceRecordController controller;
  @override
  State<ServiceRecordEditor> createState() => _ServiceRecordEditorState();
}

class _ServiceRecordEditorState extends State<ServiceRecordEditor> {
  ServiceRecordController get controller => widget.controller;
  SmartFormController get _form => controller.form;
  TextEditingController get _title => controller.title;
  TextEditingController get _km => controller.km;
  TextEditingController get _cost => controller.cost;
  TextEditingController get _notes => controller.notes;
  ServiceKind get _kind => controller.kind.value;
  DateTime get _date => controller.date.value;
  bool get _oil => controller.oil.value;
  @override
  void initState() {
    super.initState();
    controller.onStart();
  }

  @override
  void dispose() {
    controller.onDelete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LocalizedObx(() => buildEditor(context));
  Widget buildEditor(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      24,
      24,
      24,
      MediaQuery.viewInsetsOf(context).bottom + 24,
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            _kind == ServiceKind.fuel
                ? LocaleKeys.add_fuel.tr()
                : LocaleKeys.log_service.tr(),
          ),
          DropdownButtonFormField<ServiceKind>(
            initialValue: _kind,
            decoration: InputDecoration(labelText: LocaleKeys.category.tr()),
            items: ServiceKind.values
                .map(
                  (v) =>
                      DropdownMenuItem(value: v, child: Text(categoryLabel(v))),
                )
                .toList(),
            onChanged: controller.setKind,
          ),
          SizedBox(height: 16),
          SmartForm(
            controller: _form,
            children: [
              SmartTextField(
                name: 'title',
                controller: _title,
                decoration: InputDecoration(
                  labelText: _kind == ServiceKind.fuel
                      ? LocaleKeys.fuel_station.tr()
                      : LocaleKeys.what_done.tr(),
                ),
                validators: controller.titleValidators,
              ),
              SizedBox(height: 16),
              SmartTextField(
                name: 'km',
                controller: _km,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: LocaleKeys.at_km.tr()),
                validators: controller.kmValidators,
              ),
              SizedBox(height: 16),
              SmartTextField(
                name: 'cost',
                controller: _cost,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: LocaleKeys.cost_optional.tr(),
                ),
                validators: controller.costValidators,
              ),
              SizedBox(height: 16),
              SmartTextField(
                name: 'notes',
                controller: _notes,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: LocaleKeys.notes_filters.tr(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          GarageButton.outlined(
            onPressed: () => controller.pickDate(context),
            icon: Icon(Icons.calendar_month),
            label: Text(displayDate(_date)),
          ),
          if (_kind == ServiceKind.maintenance)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _oil,
              title: Text(LocaleKeys.includes_oil.tr()),
              onChanged: controller.setOil,
            ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: GarageButton.filled(
              onPressed: () => controller.save(context),
              child: Text(LocaleKeys.save_record.tr()),
            ),
          ),
        ],
      ),
    ),
  );
}
