import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/garage_button.dart';
import '../../controllers/vehicle_onboarding_controller.dart';
import '../../widgets/garage_widgets.dart';
import '../../utils/app_colors.dart';
import '../../view_models/garage_vehicle_view_model.dart';
import 'widgets/vehicle_setup_steps.dart';

class VehicleOnboardingPage extends StatefulWidget {
  const VehicleOnboardingPage({
    this.controller,
    required this.onSaved,
    super.key,
  });
  final VehicleOnboardingController? controller;
  final ValueChanged<GarageVehicleViewModel> onSaved;
  @override
  State<VehicleOnboardingPage> createState() => _VehicleOnboardingPageState();
}

class _VehicleOnboardingPageState extends State<VehicleOnboardingPage> {
  late final controller = widget.controller ?? VehicleOnboardingController();
  int get _step => controller.step.value;
  bool get _busy => controller.busy;
  bool get _details => controller.details.value;
  String? get _message => controller.message.value?.tr(
    namedArgs: {'count': '${controller.found.length}'},
  );
  @override
  void initState() {
    super.initState();
    controller.onStart();
    controller.onSaved.value = widget.onSaved;
  }

  @override
  void dispose() {
    controller.onSaved.value = null;
    if (widget.controller == null) controller.onDelete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LocalizedObx(() => buildPage(context));
  Widget buildPage(BuildContext context) => Scaffold(
    body: GarageBackdrop(
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    if (_step == 1)
                      GarageButton.icon(
                        onPressed: _busy ? null : controller.goBack,
                        icon: Icon(Icons.arrow_back),
                        tooltip: LocaleKeys.back_car_details.tr(),
                      ),
                    Icon(
                      Icons.directions_car_filled,
                      color: AppColors.primaryAmber,
                    ),
                    SizedBox(width: 10),
                    Text(
                      LocaleKeys.brand.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      ),
                    ),
                    Spacer(),
                    Text(
                      LocaleKeys.step.tr(
                        namedArgs: {'step': '${_step + 1}', 'total': '2'},
                      ),
                      style: TextStyle(
                        color: AppColors.primaryAmber,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                LinearProgressIndicator(
                  value: (_step + 1) / 2,
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(3),
                ),
                SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_message != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          _message!,
                          style: TextStyle(
                            color: AppColors.primaryAmberLight,
                            height: 1.5,
                          ),
                        ),
                      ),
                    if (controller.hasVinWarning.value)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          LocaleKeys.vin_warning.tr(),
                          style: TextStyle(color: AppColors.primaryAmberLight),
                        ),
                      ),
                  ],
                ),
                VehicleSetupSteps(
                  key: ValueKey('vehicle-setup'),
                  controller: controller,
                ),
                if (_details || _step == 1)
                  GarageButton.filled(
                    onPressed: _busy ? null : () => controller.next(context),
                    icon: _busy
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(_step == 0 ? Icons.arrow_forward : Icons.check),
                    label: Text(
                      _step == 0
                          ? LocaleKeys.continue_history.tr()
                          : LocaleKeys.open_garage.tr(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
