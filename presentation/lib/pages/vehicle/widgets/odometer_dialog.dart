import '../../../localization/localization.dart';
import 'package:flutter/material.dart';
import '../../../widgets/garage_button.dart';
import 'package:flutter/services.dart';
import '../../../controllers/odometer_controller.dart';

class OdometerDialog extends StatefulWidget {
  const OdometerDialog({required this.controller, super.key});
  final OdometerController controller;
  @override
  State<OdometerDialog> createState() => _OdometerDialogState();
}

class _OdometerDialogState extends State<OdometerDialog> {
  OdometerController get controller => widget.controller;
  TextEditingController get _controller => controller.text;
  GlobalKey<FormState> get _key => controller.formKey;
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
  Widget build(BuildContext context) => AlertDialog(
    title: Text(LocaleKeys.update_odometer.tr()),
    content: Form(
      key: _key,
      child: TextFormField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(labelText: LocaleKeys.current_km.tr()),
        validator: controller.validate,
      ),
    ),
    actions: [
      GarageButton.text(onPressed: () => controller.cancel(context), child: Text(LocaleKeys.cancel.tr())),
      GarageButton.filled(onPressed: () => controller.save(context), child: Text(LocaleKeys.update.tr())),
    ],
  );
}
