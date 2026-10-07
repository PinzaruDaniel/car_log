import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:printing/printing.dart';
import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';
import '../../utils/service_history_pdf.dart';
import '../../view_models/garage_vehicle_view_model.dart';
import '../../widgets/garage_widgets.dart';

class TimelineController extends BaseController {
  static const exportKey = 'exportHistory';
  final filter = Rxn<ServiceKindViewModel>();
  bool get exporting => containPendingKey(exportKey);

  void setFilter(ServiceKindViewModel? value) {
    if (active) filter.value = value;
  }

  TimelineViewItem buildViewItem(GarageVehicleViewModel vehicle) =>
      TimelineViewItem(
        title: LocaleKeys.history_title.tr(namedArgs: {'car': vehicle.title}),
        filters: [null, ...ServiceKindViewModel.values]
            .map(
              (kind) => TimelineFilterViewItem(
                kind: kind,
                label: _categoryLabel(kind),
                selected: filter.value == kind,
              ),
            )
            .toList(growable: false),
        groups: historyGroups(vehicle),
        addRecordKind: filter.value ?? ServiceKindViewModel.maintenance,
      );

  List<ServiceRecordViewModel> _filteredRecords(
    GarageVehicleViewModel vehicle,
  ) =>
      vehicle.records
          .where(
            (record) => filter.value == null || record.kind == filter.value,
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  List<TimelineGroupViewItem> historyGroups(GarageVehicleViewModel vehicle) {
    final groups = <TimelineGroupViewItem>[];
    for (final record in _filteredRecords(vehicle)) {
      if (groups.isEmpty ||
          groups.last.year != record.date.year ||
          groups.last.month != record.date.month) {
        groups.add(
          TimelineGroupViewItem(
            year: record.date.year,
            month: record.date.month,
            monthLabel: displayMonth(record.date),
            records: [],
          ),
        );
      }
      groups.last.records.add(_recordViewItem(record));
    }
    return groups;
  }

  String _categoryLabel(ServiceKindViewModel? kind) => switch (kind) {
    null => LocaleKeys.all.tr(),
    ServiceKindViewModel.maintenance => LocaleKeys.maintenance.tr(),
    ServiceKindViewModel.repair => LocaleKeys.repairs.tr(),
    ServiceKindViewModel.fuel => LocaleKeys.fuel.tr(),
  };

  List<String> _historyTags(ServiceRecordViewModel record) =>
      record.oil && record.notes.contains(' · ')
      ? record.notes
            .split(' · ')
            .map((tag) => filterLabel(tag.trim()))
            .where((tag) => tag.isNotEmpty)
            .toList()
      : [];

  TimelineRecordViewItem _recordViewItem(ServiceRecordViewModel record) {
    final tags = _historyTags(record);
    return TimelineRecordViewItem(
      title: _recordTitle(record),
      distance: distance(record.km),
      date: displayDate(record.date),
      cost: money(record.cost, decimals: 0),
      notes: tags.isEmpty && record.notes.isNotEmpty
          ? _recordNotes(record)
          : null,
      tags: tags,
      showOilBadge: record.oil && tags.isEmpty,
    );
  }

  String _recordTitle(ServiceRecordViewModel record) =>
      record.title == LocaleKeys.oil_filters_service
      ? LocaleKeys.oil_filters_service.tr()
      : record.title;

  String _recordNotes(ServiceRecordViewModel record) => record.oil
      ? record.notes.split(' · ').map(filterLabel).join(' · ')
      : record.notes;

  Future<void> exportHistory(
    BuildContext context,
    GarageVehicleViewModel vehicle,
  ) async {
    if (exporting || !active) return;
    startLoading([exportKey]);
    try {
      final bytes = await buildServiceHistoryPdf(buildPdfViewModel(vehicle));
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

  ServiceHistoryPdfViewModel buildPdfViewModel(GarageVehicleViewModel vehicle) {
    final records = [...vehicle.records]
      ..sort((a, b) => b.date.compareTo(a.date));
    return ServiceHistoryPdfViewModel(
      title: LocaleKeys.pdf_title.tr(namedArgs: {'car': vehicle.title}),
      vehicleSummary: LocaleKeys.pdf_vehicle.tr(
        namedArgs: {
          'year': '${vehicle.year}',
          'km': kilometres(vehicle.odometer),
        },
      ),
      vin: vehicle.vin.isEmpty
          ? null
          : LocaleKeys.pdf_vin.tr(namedArgs: {'vin': vehicle.vin}),
      emptyMessage: LocaleKeys.pdf_empty.tr(),
      records: records
          .map(
            (record) => ServiceHistoryPdfRecordViewItem(
              title: _recordTitle(record),
              summary: LocaleKeys.pdf_record.tr(
                namedArgs: {
                  'date': displayDate(record.date),
                  'km': kilometres(record.km),
                  'cost': NumberFormat.decimalPatternDigits(
                    decimalDigits: 2,
                  ).format(record.cost),
                  'category': _categoryLabel(record.kind),
                },
              ),
              notes: record.notes.isEmpty ? null : _recordNotes(record),
            ),
          )
          .toList(growable: false),
    );
  }
}

class TimelineViewItem {
  const TimelineViewItem({
    required this.title,
    required this.filters,
    required this.groups,
    required this.addRecordKind,
  });

  final String title;
  final List<TimelineFilterViewItem> filters;
  final List<TimelineGroupViewItem> groups;
  final ServiceKindViewModel addRecordKind;
}

class TimelineFilterViewItem {
  const TimelineFilterViewItem({
    required this.kind,
    required this.label,
    required this.selected,
  });

  final ServiceKindViewModel? kind;
  final String label;
  final bool selected;
}

class TimelineGroupViewItem {
  const TimelineGroupViewItem({
    required this.year,
    required this.month,
    required this.monthLabel,
    required this.records,
  });

  final int year;
  final int month;
  final String monthLabel;
  final List<TimelineRecordViewItem> records;
}

class TimelineRecordViewItem {
  const TimelineRecordViewItem({
    required this.title,
    required this.distance,
    required this.date,
    required this.cost,
    required this.notes,
    required this.tags,
    required this.showOilBadge,
  });

  final String title;
  final String distance;
  final String date;
  final String cost;
  final String? notes;
  final List<String> tags;
  final bool showOilBadge;
}
