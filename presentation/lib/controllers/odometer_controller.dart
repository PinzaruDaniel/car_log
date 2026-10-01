import 'package:flutter/material.dart';
import 'base/base_controller.dart';
import '../localization/localization.dart';
import '../widgets/garage_widgets.dart';

class OdometerController extends BaseController {
  OdometerController(this.current)
    : text = TextEditingController(text: current.toString());
  final int current;
  final TextEditingController text;
  final formKey = GlobalKey<FormState>();
  String? validate(String? value) => (int.tryParse(value ?? '') ?? -1) < current
      ? LocaleKeys.odometer_minimum.tr(
          namedArgs: {'value': kilometres(current)},
        )
      : null;
  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context, int.parse(text.text));
    }
  }

  void cancel(BuildContext context) => Navigator.pop(context);
  @override
  void onClose() {
    text.dispose();
    super.onClose();
  }
}
