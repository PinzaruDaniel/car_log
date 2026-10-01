import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/usecases/get_garage_use_case.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'base/base_controller.dart';
import '../localization/localization.dart';
import '../navigation/app_routes.dart';
import 'vehicle_controller.dart';

/// Owns startup routing and the active garage for the app's lifetime.
class MainAppController extends BaseController {
  final VehicleController vehicleController = VehicleController();
  GetGarageUseCase get _getGarageUseCase => getInstance<GetGarageUseCase>();
  static const loadGarageKey = 'loadGarage';
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    vehicleController.onStart();
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
      final vehicle = await launchUseCaseNoParams(
        _getGarageUseCase,
        loadGarageKey,
      );
      // Localization delegates may delay Navigator's first mounted frame.
      while (active && Get.key.currentState == null) {
        await WidgetsBinding.instance.endOfFrame;
      }
      if (!active) return;
      if (vehicle == null) {
        Get.offAllNamed<void>(AppRoutes.onboarding);
      } else {
        vehicleController.acceptVehicle(vehicle);
        Get.offAllNamed<void>(AppRoutes.main);
      }
    } catch (_) {
      if (!active) return;
      error.value = LocaleKeys.cache_error;
    }
  }

  /// Called only after onboarding has persisted the first vehicle successfully.
  void completeOnboarding(GarageVehicle vehicle) {
    if (!active) return;
    vehicleController.acceptVehicle(vehicle);
    Get.offAllNamed<void>(AppRoutes.main);
  }

  @override
  void onClose() {
    vehicleController.onDelete();
    super.onClose();
  }
}
