import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:smart_form_fields/smart_form_fields.dart';

import '../../controllers/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthController get controller => Get.find<AuthController>();

  SmartFormController get formController => controller.formController;

  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Localizations.localeOf(context);
    controller.initViewItems();
  }

  @override
  void dispose() {
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.auth.tr())),
      body: Column(
        children: [
          LocalizedObx(() {
            return SmartForm(
              controller: formController,
              children: [
                SmartFormField(
                  builder: (context, field) {
                    return SwitchListTile(
                      value: controller.useVinCode.value,
                      onChanged: (_) => controller.toggleVinMode(),
                    );
                  },
                ),
                controller.useVinCode.value
                    ? SmartTextField(
                        item: SmartTextFieldViewItem(
                          name: 'vin',
                          validators: <SmartValidator>[SmartValidators.length(17, message: LocaleKeys.vin_length.tr())],
                        ),
                      )
                    : Column(
                        children: controller.formFieldViewItems.map((item) => SmartTextField(item: item)).toList(),
                      ),
              ],
            );
          }),
        ],
      ) /*LocalizedObx(() {
        if (controller.items.isEmpty) {
          return Center(child: Text(LocaleKeys.auth.tr()));
        }
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return AuthViewItem(id: controller.items[index]);
          },
        );
      }),*/,
    );
  }
}

class AuthViewItem extends StatelessWidget {
  const AuthViewItem({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(id));
  }
}
