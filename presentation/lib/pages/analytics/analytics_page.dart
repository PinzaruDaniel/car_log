import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import '../../controllers/base/imports/controller_imports.dart';
import '../../page+state/base_state.dart';
import '../../utils/app_colors.dart';
import '../../widgets/garage_widgets.dart';
import 'analytics_controller.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState
    extends BaseState<AnalyticsPage, AnalyticsController> {
  @override
  AnalyticsController buildController() => AnalyticsController();

  @override
  Widget build(BuildContext context) => LocalizedObx(() {
    final vehicle = mainAppController.vehicle.value!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _analytics(controller, vehicle),
    );
  });

  List<Widget> _analytics(
    AnalyticsController controller,
    GarageVehicle vehicle,
  ) => [
    SectionTitle(
      LocaleKeys.analytics_title.tr(),
      subtitle: LocaleKeys.analytics_description.tr(),
    ),
    for (final kind in ServiceKind.values)
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: GarageCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryLabel(kind).toUpperCase(),
                style: TextStyle(
                  color: AppColors.primaryAmber,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 16),
              Text(
                money(controller.totalCost(vehicle, kind)),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              Text(
                LocaleKeys.records_count.tr(
                  namedArgs: {
                    'count': '${controller.recordCount(vehicle, kind)}',
                  },
                ),
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
  ];
}
