import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
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

class _AnalyticsPageState extends BaseState<AnalyticsPage, AnalyticsController> {
  @override
  AnalyticsController buildController() => AnalyticsController();

  @override
  Widget build(BuildContext context) => LocalizedObx(() {
    final item = controller.buildViewItem(mainAppController.vehicle.value!);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _analytics(item));
  });

  List<Widget> _analytics(AnalyticsViewItem item) => [
    SectionTitle(LocaleKeys.analytics_title.tr(), subtitle: LocaleKeys.analytics_description.tr()),
    for (final category in item.categories)
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: GarageCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.label, style: TextStyle(color: AppColors.primaryAmber, letterSpacing: 2)),
              SizedBox(height: 16),
              Text(category.cost, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
              Text(category.recordCount, style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
  ];
}
