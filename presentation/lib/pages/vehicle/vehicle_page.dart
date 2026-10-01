import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_kit/flutter_liquid_glass_kit.dart';
import 'package:get/get.dart' hide Trans;
import '../../controllers/main_app_controller.dart';
import '../../controllers/vehicle_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/garage_widgets.dart';
import 'widgets/vehicle_dashboard.dart';
import '../timeline/timeline_page.dart';
import '../analytics/analytics_page.dart';
import '../settings/settings_page.dart';
import '../../widgets/motion_surface.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({this.controller, super.key});
  final VehicleController? controller;

  @override
  Widget build(BuildContext context) {
    final vehicleController =
        controller ?? Get.find<MainAppController>().vehicleController;
    return LocalizedObx(() => _buildPage(context, vehicleController));
  }

  Widget _buildPage(BuildContext context, VehicleController controller) {
    return Scaffold(
      body: GarageBackdrop(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 650),
              child: ListView(
                padding: EdgeInsets.fromLTRB(22, 24, 22, 24),
                children: [
                  if (controller.tab.value != 1)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            [
                              LocaleKeys.my_garage.tr(),
                              LocaleKeys.service_history.tr(),
                              LocaleKeys.analytics.tr(),
                              LocaleKeys.settings.tr(),
                            ][controller.tab.value],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        if (controller.saving)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  if (controller.tab.value != 1) SizedBox(height: 22),
                  switch (controller.tab.value) {
                    0 => VehicleDashboard(controller: controller),
                    1 => TimelinePage(controller: controller),
                    2 => AnalyticsPage(controller: controller),
                    _ => SettingsPage(controller: controller),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: MotionSurface(
          radius: 28,
          child: LiquidGlassNavBar(
            activeColor: AppColors.primaryAmber,
            inactiveColor: Colors.white54,
            indicatorColor: AppColors.primaryAmber.withValues(alpha: .14),
            currentIndex: controller.tab.value,
            onTap: controller.setTab,
            items: [
              LiquidGlassNavItem(
                icon: Icon(Icons.directions_car_outlined),
                label: LocaleKeys.garage.tr(),
                iosSystemImage: 'car',
                iosSelectedSystemImage: 'car.fill',
              ),
              LiquidGlassNavItem(
                icon: Icon(Icons.format_list_bulleted),
                label: LocaleKeys.timeline.tr(),
                iosSystemImage: 'list.bullet',
              ),
              LiquidGlassNavItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: LocaleKeys.analytics.tr(),
                iosSystemImage: 'chart.bar',
              ),
              LiquidGlassNavItem(
                icon: Icon(Icons.settings_outlined),
                label: LocaleKeys.settings.tr(),
                iosSystemImage: 'gearshape',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
