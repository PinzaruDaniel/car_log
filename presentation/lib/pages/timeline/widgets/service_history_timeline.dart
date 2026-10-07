import 'package:flutter/material.dart';
import '../timeline_controller.dart';
import '../../../utils/app_colors.dart';
import 'service_history_card.dart';

class ServiceHistoryTimeline extends StatelessWidget {
  const ServiceHistoryTimeline({required this.groups, super.key});
  final List<TimelineGroupViewItem> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < groups.length; index++) ...[
          if (index == 0 || groups[index - 1].year != groups[index].year)
            Padding(
              padding: const EdgeInsets.only(bottom: 18, top: 6),
              child: Text(
                '${groups[index].year}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Row(
            children: [
              const SizedBox(
                width: 38,
                height: 44,
                child: _TimelineRail(month: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  groups[index].monthLabel,
                  style: const TextStyle(color: Colors.white60, fontSize: 18),
                ),
              ),
            ],
          ),
          for (final record in groups[index].records)
            Stack(
              children: [
                const Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: 38,
                  child: _TimelineRail(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, bottom: 24),
                  child: ServiceHistoryCard(record: record),
                ),
              ],
            ),
        ],
      ],
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({this.month = false});
  final bool month;
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned(
        top: 0,
        bottom: 0,
        left: 18,
        child: SizedBox(width: 1, child: ColoredBox(color: Colors.white24)),
      ),
      Positioned(
        top: month ? 16 : 24,
        left: month ? 13 : 7,
        child: Container(
          width: month ? 11 : 24,
          height: month ? 11 : 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: month ? const Color(0xFF55565A) : const Color(0xFF3E3B32),
            border: month ? null : Border.all(color: Colors.white12),
          ),
          child: month
              ? null
              : Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryAmber,
                    ),
                  ),
                ),
        ),
      ),
      if (!month)
        const Positioned(
          top: 35,
          right: 0,
          left: 30,
          child: SizedBox(height: 1, child: ColoredBox(color: Colors.white24)),
        ),
    ],
  );
}
