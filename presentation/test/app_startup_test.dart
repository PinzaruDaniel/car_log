import 'dart:async';
import 'package:car_log/controllers/main_app_controller.dart';
import 'package:car_log/bindings/root_binding.dart';
import 'package:car_log/main.dart';
import 'package:car_log/navigation/app_routes.dart';
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/pages/vehicle/vehicle_onboarding_page.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/repositories/garage_repository.dart';
import 'package:domain/injector.dart' as domain_di;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'garage_flow_test.dart' as fixtures;

class StartupGarage extends fixtures.MemoryGarage {
  bool failLoad = false;
  Completer<GarageVehicleEntity?>? pending;
  @override
  Future<GarageVehicleEntity?> load() async {
    loads++;
    if (failLoad) throw StateError('Cache unavailable');
    return pending == null ? vehicle : pending!.future;
  }
}

const car = GarageVehicleEntity(
  make: 'BMW',
  model: 'E39',
  year: 2002,
  odometer: 287450,
);

void main() {
  late StartupGarage repository;
  setUp(() async {
    await fixtures.initializeTestLocalization();
    Get.testMode = true;
    repository = StartupGarage();
    GetIt.instance.registerSingleton<GarageRepository>(repository);
    domain_di.configureDependencies(GetIt.instance);
  });
  tearDown(() async {
    if (Get.isRegistered<MainAppController>()) {
      await Get.delete<MainAppController>(force: true);
    }
    Get.reset();
    await GetIt.instance.reset();
  });

  testWidgets(
    'cached vehicle routes directly to main and keeps root controller',
    (tester) async {
      repository.vehicle = car;
      await tester.pumpWidget(fixtures.localized(const CarLogApp()));
      await tester.pumpAndSettle();
      expect(Get.currentRoute, AppRoutes.main);
      expect(find.byType(MainPage), findsOneWidget);
      expect(find.byType(VehicleOnboardingPage), findsNothing);
      expect(find.text('Timeline'), findsOneWidget);
      expect(repository.loads, 1);
      expect(repository.requests, 0);
      final root = Get.find<MainAppController>();
      expect(GetIt.instance.isRegistered<MainAppController>(), false);
      final fresh = MainAppController();
      expect(fresh, isNot(same(root)));
      fresh.onDelete();
      RootBinding().dependencies();
      expect(Get.find<MainAppController>(), same(root));
      expect(repository.loads, 1);
      expect(Get.find<MainAppController>().vehicle.value?.title, car.title);
      expect(Get.key.currentState!.canPop(), false);
    },
  );

  testWidgets(
    'empty cache routes to standalone onboarding without navigation bar',
    (tester) async {
      await tester.pumpWidget(fixtures.localized(const CarLogApp()));
      await tester.pumpAndSettle();
      expect(Get.currentRoute, AppRoutes.onboarding);
      expect(find.byType(VehicleOnboardingPage), findsOneWidget);
      expect(find.byType(MainPage), findsNothing);
      expect(find.text('Meet your car.'), findsOneWidget);
      expect(find.text('Timeline'), findsNothing);
      expect(repository.loads, 1);
      expect(Get.key.currentState!.canPop(), false);
    },
  );

  testWidgets(
    'cache failure stays at startup; retry uses cache without resetting onboarding',
    (tester) async {
      repository.failLoad = true;
      await tester.pumpWidget(fixtures.localized(const CarLogApp()));
      await tester.pumpAndSettle();
      expect(Get.currentRoute, AppRoutes.startup);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(VehicleOnboardingPage), findsNothing);
      expect(repository.loads, 1);
      repository.failLoad = false;
      repository.vehicle = car;
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(Get.currentRoute, AppRoutes.main);
      expect(repository.loads, 2);
      expect(Get.find<MainAppController>().vehicle.value?.title, car.title);
    },
  );

  testWidgets('pending cache read shows loading and rejects duplicate reads', (
    tester,
  ) async {
    repository.pending = Completer<GarageVehicleEntity?>();
    await tester.pumpWidget(fixtures.localized(const CarLogApp()));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final controller = Get.find<MainAppController>();
    expect(controller.containPendingKey(MainAppController.loadGarageKey), true);
    await controller.getVehicles();
    expect(repository.loads, 1);
    repository.pending!.complete(car);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.main);
    expect(repository.loads, 1);
  });

  testWidgets('root shutdown ignores pending cache result', (tester) async {
    repository.pending = Completer<GarageVehicleEntity?>();
    await tester.pumpWidget(fixtures.localized(const CarLogApp()));
    await tester.pump();
    final controller = Get.find<MainAppController>();
    await tester.pumpWidget(const SizedBox.shrink());
    await Get.delete<MainAppController>(force: true);
    expect(controller.isClosed, true);
    repository.pending!.complete(car);
    await tester.pumpAndSettle();
    expect(controller.vehicle.value, isNull);
    expect(tester.takeException(), isNull);
  });
}
