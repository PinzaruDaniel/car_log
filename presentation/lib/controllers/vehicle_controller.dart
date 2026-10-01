import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/usecases/save_garage_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import 'service_record_controller.dart';
import 'odometer_controller.dart';
import 'package:printing/printing.dart';
import '../pages/vehicle/widgets/odometer_dialog.dart';
import '../widgets/service_record_editor.dart';
import '../utils/service_history_pdf.dart';
import '../widgets/garage_widgets.dart' show filterLabel;

class VehicleController extends BaseController {
  VehicleController({SaveGarageUseCase? saveGarageUseCase})
    : _saveOverride = saveGarageUseCase;
  final SaveGarageUseCase? _saveOverride;
  SaveGarageUseCase get _saveGarageUseCase =>
      _saveOverride ?? getInstance<SaveGarageUseCase>();
  final vehicle = Rxn<GarageVehicle>();
  final tab = 0.obs;
  final filter = Rxn<ServiceKind>();
  static const saveKey = 'saveGarage', exportKey = 'exportHistory';
  bool get saving => containPendingKey(saveKey);
  bool get exporting => containPendingKey(exportKey);
  void mutate(VoidCallback change) {
    if (active) change();
  }

  void setTab(int value) => mutate(() => tab.value = value);
  void setFilter(ServiceKind? value) => mutate(() => filter.value = value);
  void acceptVehicle(GarageVehicle value) =>
      mutate(() => vehicle.value = value);
  ServiceRecord? get lastOil => vehicle.value?.lastOil;
  int? get oilRemainingKm => lastOil == null
      ? null
      : lastOil!.km + vehicle.value!.oilInterval - vehicle.value!.odometer;
  bool get oilHealthy => oilRemainingKm != null && oilRemainingKm! > 0;
  double get oilProgress => lastOil == null
      ? 0
      : ((vehicle.value!.odometer - lastOil!.km) / vehicle.value!.oilInterval)
            .clamp(0.0, 1.0);
  double get yearlyMaintenanceCost => vehicle.value!.records
      .where(
        (record) =>
            record.date.year == DateTime.now().year &&
            record.kind != ServiceKind.fuel,
      )
      .fold(0.0, (sum, record) => sum + record.cost);
  List<ServiceRecord> get filteredRecords =>
      vehicle.value!.records
          .where(
            (record) => filter.value == null || record.kind == filter.value,
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
  List<({int year, int month, List<ServiceRecord> records})> get historyGroups {
    final groups = <({int year, int month, List<ServiceRecord> records})>[];
    for (final record in filteredRecords) {
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
  void showGarage() => setTab(0);
  List<String> historyTags(ServiceRecord record) =>
      record.oil && record.notes.contains(' · ')
      ? record.notes
            .split(' · ')
            .map((tag) => filterLabel(tag.trim()))
            .where((tag) => tag.isNotEmpty)
            .toList()
      : [];
  double totalCost(ServiceKind kind) => vehicle.value!.records
      .where((record) => record.kind == kind)
      .fold(0.0, (sum, record) => sum + record.cost);
  int recordCount(ServiceKind kind) =>
      vehicle.value!.records.where((record) => record.kind == kind).length;
  Future<void> exportHistory(BuildContext context) async {
    if (exporting || !active) return;
    startLoading([exportKey]);
    try {
      final bytes = await buildServiceHistoryPdf(vehicle.value!);
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

  Future<void> save(BuildContext context, GarageVehicle value) async {
    if (saving || !active) return;
    startLoading([saveKey]);
    try {
      await _saveGarageUseCase(value);
      if (active) mutate(() => vehicle.value = value);
    } catch (_) {
      if (active && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(LocaleKeys.save_error.tr())));
      }
    } finally {
      stopLoading([saveKey]);
    }
  }

  Future<void> addRecord(BuildContext context, ServiceKind kind) async {
    if (saving) return;
    final editor = ServiceRecordController(kind, vehicle.value!.odometer);
    final record = await showModalBottomSheet<ServiceRecord>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ServiceRecordEditor(controller: editor),
    );
    if (record != null && active && context.mounted) {
      await save(
        context,
        vehicle.value!.copyWith(records: [...vehicle.value!.records, record]),
      );
    }
  }

  Future<void> updateOdometer(BuildContext context) async {
    if (saving) return;
    final editor = OdometerController(vehicle.value!.odometer);
    final value = await showDialog<int>(
      context: context,
      builder: (_) => OdometerDialog(controller: editor),
    );
    if (value != null && active && context.mounted) {
      await save(context, vehicle.value!.copyWith(odometer: value));
    }
  }

  String insuranceStatus(DateTime expiry) {
    final now = DateTime.now();
    final days = DateTime(
      expiry.year,
      expiry.month,
      expiry.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
    return days < 0
        ? LocaleKeys.expired.tr()
        : days == 0
        ? LocaleKeys.today.tr()
        : LocaleKeys.days.tr(namedArgs: {'count': '$days'});
  }
}
