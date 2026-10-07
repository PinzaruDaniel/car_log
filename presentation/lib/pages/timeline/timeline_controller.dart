import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:printing/printing.dart';
import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';
import '../../utils/service_history_pdf.dart';
import '../../widgets/garage_widgets.dart' show filterLabel;

class TimelineController extends BaseController {
  static const exportKey = 'exportHistory';
  final filter = Rxn<ServiceKind>();
  bool get exporting => containPendingKey(exportKey);

  void setFilter(ServiceKind? value) {
    if (active) filter.value = value;
  }

  List<ServiceRecord> filteredRecords(GarageVehicle vehicle) =>
      vehicle.records
          .where(
            (record) => filter.value == null || record.kind == filter.value,
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  List<({int year, int month, List<ServiceRecord> records})> historyGroups(
    GarageVehicle vehicle,
  ) {
    final groups = <({int year, int month, List<ServiceRecord> records})>[];
    for (final record in filteredRecords(vehicle)) {
      if (groups.isEmpty ||
          groups.last.year != record.date.year ||
          groups.last.month != record.date.month) {
        groups.add((
          year: record.date.year,
          month: record.date.month,
          records: <ServiceRecord>[],
        ));
      }
      groups.last.records.add(record);
    }
    return groups;
  }

  String categoryLabel(ServiceKind? kind) => switch (kind) {
    null => LocaleKeys.all.tr(),
    ServiceKind.maintenance => LocaleKeys.maintenance.tr(),
    ServiceKind.repair => LocaleKeys.repairs.tr(),
    ServiceKind.fuel => LocaleKeys.fuel.tr(),
  };

  List<String> historyTags(ServiceRecord record) =>
      record.oil && record.notes.contains(' · ')
      ? record.notes
            .split(' · ')
            .map((tag) => filterLabel(tag.trim()))
            .where((tag) => tag.isNotEmpty)
            .toList()
      : [];

  Future<void> exportHistory(
    BuildContext context,
    GarageVehicle vehicle,
  ) async {
    if (exporting || !active) return;
    startLoading([exportKey]);
    try {
      final bytes = await buildServiceHistoryPdf(vehicle);
      if (!active) return;
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'car-log-service-history.pdf',
      );
    } catch (_) {
      if (active && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(LocaleKeys.export_error.tr())));
      }
    } finally {
      stopLoading([exportKey]);
    }
  }
}
