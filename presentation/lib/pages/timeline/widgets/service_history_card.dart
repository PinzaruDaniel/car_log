import '../../../localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../timeline_controller.dart';
import '../../../widgets/garage_badge.dart';
import '../../../widgets/garage_widgets.dart';
import '../../../utils/app_colors.dart';

class ServiceHistoryCard extends StatelessWidget {
  const ServiceHistoryCard({required this.record, super.key});
  final TimelineRecordViewItem record;

  @override
  Widget build(BuildContext context) => GarageCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (1.sw < 360 || MediaQuery.textScalerOf(context).scale(1) > 1.3)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              SizedBox(height: 12.h),
              _cost(),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _title()),
              SizedBox(width: 12.w),
              _cost(),
            ],
          ),
        SizedBox(height: 14),
        GarageBadge(record.distance, color: Colors.white60),
        SizedBox(height: 10),
        Text(
          record.date,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        if (record.tags.isNotEmpty) ...[
          Divider(height: 28, color: Colors.white12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in record.tags)
                GarageBadge(tag, color: AppColors.primaryAmberLight),
            ],
          ),
        ] else if (record.notes != null) ...[
          Divider(height: 28, color: Colors.white12),
          Text(
            record.notes!,
            style: TextStyle(color: Colors.white60, height: 1.5, fontSize: 15),
          ),
        ],
        if (record.showOilBadge) ...[
          SizedBox(height: 14),
          GarageBadge(
            LocaleKeys.engine_oil_changed.tr(),
            color: AppColors.primaryAmberLight,
          ),
        ],
      ],
    ),
  );

  Widget _title() => Text(
    record.title,
    style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600, height: 1.3),
  );

  Widget _cost() => GarageBadge(record.cost, filled: true);
}
