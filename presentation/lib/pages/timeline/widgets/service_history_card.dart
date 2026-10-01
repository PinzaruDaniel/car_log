import '../../../localization/localization.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
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
        LayoutBuilder(
          builder: (context, constraints) {
            final title = Text(
              recordTitle(record),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            );
            final cost = GarageBadge(
              money(record.cost, decimals: 0),
              filled: true,
            );
            return constraints.maxWidth < 260 ||
                    MediaQuery.textScalerOf(context).scale(1) > 1.3
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, SizedBox(height: 12), cost],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: title),
                      SizedBox(width: 12),
                      cost,
                    ],
                  );
          },
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
}
