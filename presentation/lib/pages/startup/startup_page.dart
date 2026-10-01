import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../../controllers/main_app_controller.dart';
import '../../widgets/garage_button.dart';
import '../../widgets/garage_widgets.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: GarageBackdrop(
      child: SafeArea(
        child: Center(
          child: LocalizedObx(() {
            final controller = Get.find<MainAppController>();
            return controller.error.value == null
                ? CircularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.error.value!.tr(),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        GarageButton.filled(
                          onPressed:
                              controller.containPendingKey(
                                MainAppController.loadGarageKey,
                              )
                              ? null
                              : controller.getVehicles,
                          child: Text(LocaleKeys.retry.tr()),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    ),
  );
}
