import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

class AuthController extends BaseController {
  final RxList<SmartTextFieldViewItem> formFieldViewItems = .new([]);
  final RxBool useVinCode = .new(true);
  final formController = SmartFormController();

  void toggleVinMode() {
    useVinCode.toggle();
    if (!useVinCode.value) initViewItems();
  }

  @override
  void onClose() {
    formController.dispose();
    super.onClose();
  }

  void initViewItems() {
    formFieldViewItems.value = [
      SmartTextFieldViewItem(
        name: 'make',
        decoration: InputDecoration(
          labelText: LocaleKeys.make.tr(),
          hintText: LocaleKeys.make_hint.tr(),
        ),
        validators: [
          SmartValidators.required(
            message: LocaleKeys.required_field.tr(
              namedArgs: {'label': LocaleKeys.make.tr()},
            ),
          ),
        ],
      ),
      SmartTextFieldViewItem(
        name: 'model',
        decoration: InputDecoration(
          labelText: LocaleKeys.model.tr(),
          hintText: LocaleKeys.model_hint.tr(),
        ),
        validators: [
          SmartValidators.required(
            message: LocaleKeys.required_field.tr(
              namedArgs: {'label': LocaleKeys.model.tr()},
            ),
          ),
        ],
      ),
      SmartTextFieldViewItem(
        name: 'year',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: LocaleKeys.year.tr(),
          hintText: LocaleKeys.year_hint.tr(),
        ),
        validators: [
          SmartValidators.required(
            message: LocaleKeys.required_field.tr(
              namedArgs: {'label': LocaleKeys.year.tr()},
            ),
          ),
          SmartValidators.number(message: LocaleKeys.valid_year.tr()),
        ],
      ),
      SmartTextFieldViewItem(
        name: 'body_type',
        decoration: InputDecoration(
          labelText: LocaleKeys.body_type.tr(),
          hintText: LocaleKeys.body_hint.tr(),
        ),
      ),
    ];
  }
}
