import '../../widgets/localized_obx.dart';
import '../../localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import '../../controllers/vehicle_controller.dart';
import '../../widgets/garage_button.dart';
import '../../widgets/garage_widgets.dart';
import 'widgets/history_filter.dart';
import 'widgets/service_history_timeline.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({required this.controller, super.key});
  final VehicleController controller;

  @override
  Widget build(BuildContext context) => LocalizedObx(() => _buildPage(context));
  Widget _buildPage(BuildContext context) {
    final exporting = controller.exporting;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final title = Row(
              children: [
                GarageButton.icon(
                  onPressed: controller.showGarage,
                  icon: Icon(Icons.chevron_left),
                  tooltip: LocaleKeys.back_garage.tr(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    LocaleKeys.history_title.tr(
                      namedArgs: {'car': controller.vehicle.value!.title},
                    ),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
            final export = GarageButton.outlined(
              onPressed: exporting
                  ? null
                  : () => controller.exportHistory(context),
              icon: Icon(Icons.picture_as_pdf_outlined, size: 20),
              label: Text(
                exporting
                    ? LocaleKeys.exporting.tr()
                    : LocaleKeys.export_pdf.tr(),
              ),
            );
            return constraints.maxWidth < 470
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      title,
                      SizedBox(height: 14),
                      Align(alignment: Alignment.centerRight, child: export),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: title),
                      SizedBox(width: 12),
                      export,
                    ],
                  );
          },
        ),
        SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final kind in [null, ...ServiceKind.values])
              HistoryFilter(
                label: controller.categoryLabel(kind),
                selected: controller.filter.value == kind,
                onPressed: () => controller.setFilter(kind),
              ),
          ],
        ),
        SizedBox(height: 26),
        if (controller.historyGroups.isEmpty)
          GarageCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.empty_category.tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  LocaleKeys.history_hint.tr(),
                  style: TextStyle(color: Colors.white54, height: 1.5),
                ),
                SizedBox(height: 18),
                GarageButton.filled(
                  onPressed: controller.saving
                      ? null
                      : () => controller.addRecord(
                          context,
                          controller.filter.value ?? ServiceKind.maintenance,
                        ),
                  icon: Icon(Icons.add),
                  label: Text(LocaleKeys.add_record.tr()),
                ),
              ],
            ),
          )
        else
          ServiceHistoryTimeline(controller: controller),
      ],
    );
  }
}
