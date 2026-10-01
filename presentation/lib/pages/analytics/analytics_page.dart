import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import '../../controllers/vehicle_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/garage_widgets.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({required this.controller, super.key});
  final VehicleController controller;
  @override
  Widget build(BuildContext context) => LocalizedObx(() => _buildPage(context));
  Widget _buildPage(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: _analytics(),
  );
  List<Widget> _analytics() => [
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
                money(controller.totalCost(kind)),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              Text(
                LocaleKeys.records_count.tr(
                  namedArgs: {'count': '${controller.recordCount(kind)}'},
                ),
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
  ];
}
