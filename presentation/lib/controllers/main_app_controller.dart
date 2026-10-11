import 'dart:async';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/usecases/get_garage_use_case.dart';
import 'package:domain/features/garage/usecases/save_garage_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'base/base_controller.dart';
import '../localization/localization.dart';
import '../navigation/app_routes.dart';
import '../pages/vehicle/widgets/odometer_dialog.dart';
import '../view_models/garage_vehicle_view_model.dart';
import '../widgets/service_record_editor.dart';
import 'odometer_controller.dart';
import 'mappers/garage_vehicle_view_model_mapper.dart';
import 'service_record_controller.dart';

/// Owns app-wide navigation and the active garage for the app's lifetime.
class MainAppController extends BaseController {
  GetGarageUseCase get _getGarageUseCase => getInstance<GetGarageUseCase>();

  SaveGarageUseCase get _saveGarageUseCase => getInstance<SaveGarageUseCase>();
  static const loadGarageKey = 'loadGarage', saveGarageKey = 'saveGarage';
  final error = RxnString();
  final vehicle = Rxn<GarageVehicleViewModel>();
  GarageVehicleEntity? _vehicleEntity;
  final StreamController<int> mainTabStreamController = StreamController<int>.broadcast();

  bool get saving => containPendingKey(saveGarageKey);

  void changeMainTab(int index) {
    if (active) mainTabStreamController.add(index);
  }

  void acceptVehicle(GarageVehicleEntity value) {
    if (!active) return;
    _vehicleEntity = value;
    vehicle.value = value.toViewModel();
  }

  @override
  void onReady() {
    super.onReady();
    getVehicles();
  }

  Future<void> getVehicles() async {
    if (containPendingKey(loadGarageKey) || !active) return;
    error.value = null;
    try {
      // Repository.load reads ObjectBox, including the one-time legacy import.
      final vehicle = await launchUseCaseNoParams(_getGarageUseCase, loadGarageKey);
      // Localization delegates may delay Navigator's first mounted frame.
      while (active && Get.key.currentState == null) {
        await WidgetsBinding.instance.endOfFrame;
      }
      if (!active) return;
      if (vehicle == null) {
        Get.offAllNamed<void>(AppRoutes.onboarding);
      } else {
        acceptVehicle(vehicle);
        Get.offAllNamed<void>(AppRoutes.main);
      }
    } catch (_) {
      if (!active) return;
      error.value = LocaleKeys.cache_error;
    }
  }

  /// Called only after onboarding has persisted the first vehicle successfully.
  void completeOnboarding(GarageVehicleViewModel value) {
    if (!active) return;
    _vehicleEntity = value.toEntity();
    vehicle.value = value;
    Get.offAllNamed<void>(AppRoutes.main);
  }

  Future<void> _save(BuildContext context, GarageVehicleEntity value) async {
    if (saving || !active) return;
    startLoading([saveGarageKey]);
    try {
      await _saveGarageUseCase(value);
      acceptVehicle(value);
    } catch (_) {
      if (active && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.save_error.tr())));
      }
    } finally {
      stopLoading([saveGarageKey]);
    }
  }

  Future<void> addRecord(BuildContext context, ServiceKindViewModel kind) async {
    final currentVehicle = _vehicleEntity;
    if (saving || currentVehicle == null) return;
    final editor = ServiceRecordController(kind, currentVehicle.odometer);
    final record = await showModalBottomSheet<ServiceRecordEntity>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ServiceRecordEditor(controller: editor),
    );
    if (record != null && active && context.mounted) {
      final latestVehicle = _vehicleEntity;
      if (latestVehicle != null) {
        await _save(context, latestVehicle.copyWith(records: [...latestVehicle.records, record]));
      }
    }
  }

  Future<void> updateOdometer(BuildContext context) async {
    final currentVehicle = _vehicleEntity;
    if (saving || currentVehicle == null) return;
    final editor = OdometerController(currentVehicle.odometer);
    final value = await showDialog<int>(
      context: context,
      builder: (_) => OdometerDialog(controller: editor),
    );
    if (value != null && active && context.mounted) {
      final latestVehicle = _vehicleEntity;
      if (latestVehicle != null) {
        await _save(context, latestVehicle.copyWith(odometer: value));
      }
    }
  }

  @override
  void onClose() {
    mainTabStreamController.close();
    super.onClose();
  }
}
