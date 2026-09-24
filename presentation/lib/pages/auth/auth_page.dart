import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

import '../../controllers/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthController controller;

  SmartFormController get formController => SmartFormController();

  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
    controller = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Column(
        children: [
          SmartForm(
            controller: formController,
            children: [
              SmartTextField(
                item: SmartTextFieldViewItem(
                  name: 'Vin',
                  validators: <SmartValidator>[SmartValidators.length(17, message: 'Vin must be 17 characters long')],
                ),
              ),
            ],
          ),
        ],
      ) /*Obx(() {
        if (controller.items.isEmpty) {
          return const Center(child: Text('Auth'));
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
