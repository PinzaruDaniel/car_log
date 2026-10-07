import '../../../localization/localization.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/garage_badge.dart';
import '../../../widgets/garage_widgets.dart';
import '../../../utils/app_colors.dart';

class ServiceHistoryCard extends StatelessWidget {
  const ServiceHistoryCard({
    required this.record,
    this.tags = const [],
    super.key,
  });
  final ServiceRecord record;
  final List<String> tags;

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
        GarageBadge(distance(record.km), color: Colors.white60),
        SizedBox(height: 10),
        Text(
          displayDate(record.date),
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        if (tags.isNotEmpty) ...[
          Divider(height: 28, color: Colors.white12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in tags)
                GarageBadge(tag, color: AppColors.primaryAmberLight),
            ],
          ),
        ] else if (record.notes.isNotEmpty) ...[
          Divider(height: 28, color: Colors.white12),
          Text(
            recordNotes(record),
            style: TextStyle(color: Colors.white60, height: 1.5, fontSize: 15),
          ),
        ],
        if (record.oil && tags.isEmpty) ...[
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
    recordTitle(record),
    style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600, height: 1.3),
  );

  Widget _cost() => GarageBadge(money(record.cost, decimals: 0), filled: true);
}
