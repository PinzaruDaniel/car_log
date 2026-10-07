import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/base/imports/controller_imports.dart';
import '../../localization/localization.dart';
import '../../page+state/base_state.dart';
import '../../widgets/garage_button.dart';
import '../../widgets/garage_widgets.dart';
import '../../widgets/localized_obx.dart';
import 'timeline_controller.dart';
import 'widgets/history_filter.dart';
import 'widgets/service_history_timeline.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends BaseState<TimelinePage, TimelineController> {
  @override
  TimelineController buildController() => TimelineController();

  @override
  Widget build(BuildContext context) => LocalizedObx(() {
    final vehicle = mainAppController.vehicle.value!;
    final exporting = controller.exporting;
    final historyGroups = controller.historyGroups(vehicle);
    final title = Row(
      children: [
        GarageButton.icon(
          onPressed: () => mainAppController.changeMainTab(0),
          icon: Icon(Icons.chevron_left),
          tooltip: LocaleKeys.back_garage.tr(),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            LocaleKeys.history_title.tr(namedArgs: {'car': vehicle.title}),
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
    final export = GarageButton.outlined(
      onPressed: exporting
          ? null
          : () => controller.exportHistory(context, vehicle),
      icon: Icon(Icons.picture_as_pdf_outlined, size: 20.sp),
      label: Text(
        exporting ? LocaleKeys.exporting.tr() : LocaleKeys.export_pdf.tr(),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (1.sw < 514)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              title,
              SizedBox(height: 14.h),
              Align(alignment: Alignment.centerRight, child: export),
            ],
          )
        else
          Row(
            children: [
              Expanded(child: title),
              SizedBox(width: 12.w),
              export,
            ],
          ),
        SizedBox(height: 24.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            for (final kind in [null, ...ServiceKind.values])
              HistoryFilter(
                label: controller.categoryLabel(kind),
                selected: controller.filter.value == kind,
                onPressed: () => controller.setFilter(kind),
              ),
          ],
        ),
        SizedBox(height: 26.h),
        if (historyGroups.isEmpty)
          GarageCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.empty_category.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  LocaleKeys.history_hint.tr(),
                  style: TextStyle(color: Colors.white54, height: 1.5),
                ),
                SizedBox(height: 18.h),
                GarageButton.filled(
                  onPressed: mainAppController.saving
                      ? null
                      : () => mainAppController.addRecord(
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
          ServiceHistoryTimeline(controller: controller, vehicle: vehicle),
      ],
    );
  });
}
