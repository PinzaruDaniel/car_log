import 'dart:async';
import 'dart:convert';
import 'package:car_log/controllers/base/base_controller.dart';
import 'package:car_log/controllers/main_app_controller.dart';
import 'package:car_log/pages/timeline/timeline_controller.dart';
import 'package:car_log/localization/localization.dart';
import 'package:car_log/main.dart';
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/pages/vehicle/vehicle_onboarding_page.dart';
import 'package:car_log/widgets/garage_widgets.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/repositories/garage_repository.dart';
import 'package:domain/injector.dart' as domain_di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_it/get_it.dart';
import 'garage_flow_test.dart' as fixtures;

class TestController extends BaseController {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    Get.testMode = true;
    await fixtures.initializeTestLocalization();
  });
  tearDown(() async {
    if (Get.isRegistered<MainAppController>()) {
      await Get.delete<MainAppController>(force: true);
    }
    Get.reset();
    await GetIt.instance.reset();
  });

  test(
    'pending ids isolate operations and always clear after failure',
    () async {
      final controller = TestController();
      addTearDown(controller.onDelete.call);
      final load = Completer<int>(), save = Completer<int>();
      final loadFuture = controller.runPending('load', () => load.future);
      final saveFuture = controller.runPending('save', () => save.future);
      expect(controller.getPendingKeys, containsAll(['load', 'save']));
      load.complete(1);
      expect(await loadFuture, 1);
      expect(controller.containPendingKey('load'), false);
      expect(controller.containPendingKey('save'), true);
      final failure = expectLater(saveFuture, throwsStateError);
      save.completeError(StateError('Storage unavailable'));
      await failure;
      expect(controller.getPendingKeys, isEmpty);
      controller.startLoading(['load', 'load']);
      expect(controller.getPendingKeys, ['load']);
      controller.onDelete();
      expect(controller.getPendingKeys, isEmpty);
    },
  );

  testWidgets('direct Rx writes rebuild garage without update calls', (
    tester,
  ) async {
    final repository = fixtures.MemoryGarage()
      ..vehicle = const GarageVehicle(
        make: 'BMW',
        model: 'E39',
        year: 2002,
        odometer: 287450,
      );
    final controller = fixtures.mainController(repository);
    await tester.pumpWidget(fixtures.app(const MainPage()));
    await tester.pumpAndSettle();
    final timelineController = Get.find<TimelineController>();
    controller.vehicle.value = controller.vehicle.value!.copyWith(
      odometer: 288000,
    );
    await tester.pumpAndSettle();
    expect(
      find.textContaining('288,000 km', findRichText: true),
      findsOneWidget,
    );
    controller.changeMainTab(1);
    await tester.pumpAndSettle();
    expect(find.text('No records in this category.'), findsOneWidget);
    timelineController.startLoading([TimelineController.exportKey]);
    await tester.pump();
    expect(find.text('Exporting…'), findsOneWidget);
    timelineController.stopLoading([TimelineController.exportKey]);
    await tester.pump();
    expect(find.text('Export PDF'), findsOneWidget);
  });

  testWidgets('language switch retains root controller and cached history', (
    tester,
  ) async {
    final repository = fixtures.MemoryGarage()
      ..vehicle = GarageVehicle(
        make: 'BMW',
        model: 'E39',
        year: 2002,
        odometer: 287450,
        records: [
          ServiceRecord(
            title: LocaleKeys.oil_filters_service,
            date: DateTime(2026, 9, 1),
            km: 281900,
            kind: ServiceKind.maintenance,
            notes: LocaleKeys.oil_filter,
            oil: true,
          ),
          ServiceRecord(
            title: 'My repair note',
            date: DateTime(2026, 9, 2),
            km: 287000,
            kind: ServiceKind.repair,
          ),
        ],
      );
    GetIt.instance.registerSingleton<GarageRepository>(repository);
    domain_di.configureDependencies(GetIt.instance);
    await tester.pumpWidget(fixtures.localized(const CarLogApp()));
    await tester.pumpAndSettle();
    final root = Get.find<MainAppController>();
    await tester.element(find.byType(MainPage)).setLocale(const Locale('ro'));
    await tester.pumpAndSettle();
    expect(tester.element(find.byType(MainPage)).locale, const Locale('ro'));
    expect(LocaleKeys.garage.tr(), 'Garaj');
    expect(find.text('Garaj'), findsOneWidget);
    expect(Get.find<MainAppController>(), same(root));
    expect(repository.loads, 1);
    root.changeMainTab(1);
    await tester.pumpAndSettle();
    expect(find.text('septembrie 2026'), findsOneWidget);
    expect(find.text('Schimb ulei și filtre'), findsOneWidget);
    expect(find.text('My repair note'), findsOneWidget);
    expect(recordNotes(repository.vehicle!.records.first), 'Filtru de ulei');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Romanian onboarding validation and VIN errors are localized', (
    tester,
  ) async {
    GetIt.instance.registerSingleton<GarageRepository>(fixtures.MemoryGarage());
    domain_di.configureDependencies(GetIt.instance);
    await tester.pumpWidget(
      fixtures.localized(
        Builder(
          builder: (context) => MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: VehicleOnboardingPage(onSaved: (_) {}),
          ),
        ),
        locale: const Locale('ro'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Adaugă mașina ta.'), findsOneWidget);
    await tester.tap(find.text('Găsește mașina'));
    await tester.pumpAndSettle();
    expect(
      find.text('Introdu un VIN de 17 caractere, fără I, O sau Q.'),
      findsOneWidget,
    );
    expect(find.text('Se caută mașina…'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  test('translation assets have matching keys and placeholders', () async {
    final en =
        jsonDecode(await rootBundle.loadString('assets/localization/en.json'))
            as Map<String, dynamic>;
    final ro =
        jsonDecode(await rootBundle.loadString('assets/localization/ro.json'))
            as Map<String, dynamic>;
    expect(ro.keys.toSet(), en.keys.toSet());
    for (final key in en.keys) {
      final parameters = RegExp(r'\{\w+\}');
      expect(
        parameters.allMatches(ro[key] as String).map((m) => m[0]).toSet(),
        parameters.allMatches(en[key] as String).map((m) => m[0]).toSet(),
        reason: key,
      );
      expect((ro[key] as String).trim(), isNotEmpty, reason: key);
    }
  });
}
