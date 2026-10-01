import 'dart:io';
import 'dart:ui' as ui;
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/main.dart';
import 'package:car_log/navigation/app_routes.dart';
import 'package:get/get.dart';
import 'package:car_log/pages/vehicle/vehicle_onboarding_page.dart';
import 'package:car_log/controllers/vehicle_controller.dart';
import 'package:car_log/controllers/main_app_controller.dart';
import 'package:car_log/controllers/vehicle_onboarding_controller.dart';
import 'package:car_log/controllers/service_record_controller.dart';
import 'package:car_log/controllers/odometer_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:car_log/controllers/base/base_controller.dart';
import 'package:car_log/localization/localization.dart';
import 'localization_fixtures.dart';
export 'localization_fixtures.dart';
import 'package:domain/injector.dart' as domain_di;
import 'package:car_log/utils/app_colors.dart';
import 'package:data/features/vehicle/local/garage_local_data_source.dart';
import 'package:data/features/vehicle/local/legacy_garage_local_data_source.dart';
import 'package:data/features/vehicle/local/models/garage_vehicle_box.dart';
import 'package:data/features/vehicle/local/models/service_record_box.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/repositories/garage_repository.dart';
import 'package:domain/features/garage/usecases/get_garage_use_case.dart';
import 'package:domain/features/garage/usecases/save_garage_use_case.dart';
import 'package:domain/features/vehicle/usecases/decode_vin_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:car_log/utils/service_history_pdf.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

class MemoryGarage implements GarageRepository {
  GarageVehicle? vehicle;
  Map<String, String> decoded = {
    'make': 'BMW',
    'model': '530i',
    'year': '2002',
  };
  int requests = 0;
  int loads = 0;
  bool failLookup = false;
  @override
  Future<GarageVehicle?> load() async {
    loads++;
    return vehicle;
  }

  @override
  Future<void> save(GarageVehicle value) async => vehicle = value;
  @override
  Future<Map<String, String>> decodeVin(String vin) async {
    requests++;
    if (failLookup) throw const SocketException('offline');
    return decoded;
  }
}

class StubLegacyGarage extends LegacyGarageLocalDataSource {
  StubLegacyGarage([this.vehicle]);
  final GarageVehicle? vehicle;
  int loads = 0;
  @override
  Future<GarageVehicle?> load() async {
    loads++;
    return vehicle;
  }
}

VehicleController vehicleController(MemoryGarage repository) {
  final controller = VehicleController(
    saveGarageUseCase: SaveGarageUseCase(repository),
  );
  controller.onStart();
  if (repository.vehicle != null) controller.acceptVehicle(repository.vehicle!);
  addTearDown(controller.onDelete.call);
  return controller;
}

VehicleOnboardingController onboardingController(MemoryGarage repository) {
  final controller = VehicleOnboardingController(
    saveGarageUseCase: SaveGarageUseCase(repository),
    decodeVinUseCase: DecodeVinUseCase(repository),
  );
  addTearDown(controller.onDelete.call);
  return controller;
}

Widget app(Widget child) => localized(
  RepaintBoundary(
    key: const ValueKey('preview'),
    child: Builder(
      builder: (context) => MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: carTrackerDarkTheme,
        home: SmartFormTheme(data: const SmartFormThemeData(), child: child),
      ),
    ),
  ),
);

Future<void> capture(WidgetTester tester, String name) async {
  if (!const bool.fromEnvironment('CAPTURE_PREVIEWS')) return;
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const ValueKey('preview')),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final directory = await Directory(
      '/private/tmp/car-log-preview',
    ).create(recursive: true);
    await File(
      '${directory.path}/$name.png',
    ).writeAsBytes(bytes!.buffer.asUint8List());
  });
}

Future<void> enterField(WidgetTester tester, String name, String value) async {
  final field = find.byWidgetPredicate(
    (w) => w is SmartTextField && w.name == name,
  );
  await tester.ensureVisible(field);
  await tester.pumpAndSettle();
  await tester.enterText(
    find.descendant(of: field, matching: find.byType(EditableText)),
    value,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await initializeTestLocalization();
    Get.testMode = true;
    GetIt.instance.registerSingleton<GarageRepository>(MemoryGarage());
    domain_di.configureDependencies(GetIt.instance);
  });
  tearDown(() async {
    if (Get.isRegistered<MainAppController>()) {
      await Get.delete<MainAppController>(force: true);
    }
    Get.reset();
    await GetIt.instance.reset();
  });
  setUpAll(() async {
    final font = FontLoader('NotoSans')
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
    await font.load();
    final fallback = FontLoader('Roboto')
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
    await fallback.load();
    if (const bool.fromEnvironment('CAPTURE_PREVIEWS')) {
      final defaultFont = FontLoader('Ahem')
        ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
      await defaultFont.load();
    }
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });

  test('controllers use BaseController without Injectable registrations', () {
    expect(GetIt.instance.isRegistered<MainAppController>(), false);
    expect(GetIt.instance.isRegistered<VehicleController>(), false);
    final controller = VehicleController();
    addTearDown(controller.onDelete.call);
    expect(controller, isA<BaseController>());
    final editor = ServiceRecordController(ServiceKind.fuel, 287450);
    addTearDown(editor.onDelete.call);
    expect(editor, isA<BaseController>());
    expect(editor.kind.value, ServiceKind.fuel);
    expect(editor.maxKm, 287450);
    final odometer = OdometerController(287450);
    addTearDown(odometer.onDelete.call);
    expect(odometer, isA<BaseController>());
    expect(odometer.current, 287450);
  });

  test('generated garage use cases read and save through repository', () async {
    final repository = GetIt.instance.get<GarageRepository>() as MemoryGarage;
    final load = GetIt.instance.get<GetGarageUseCase>();
    final save = GetIt.instance.get<SaveGarageUseCase>();
    expect(await load(), isNull);
    const vehicle = GarageVehicle(
      make: 'BMW',
      model: 'E39',
      year: 2002,
      odometer: 287450,
    );
    await save(vehicle);
    expect(await load(), vehicle);
    expect(repository.vehicle, vehicle);
    expect(repository.loads, 2);
  });

  test('PDF exports complete Unicode service history offline', () async {
    final bytes = await buildServiceHistoryPdf(
      GarageVehicle(
        make: 'Škoda',
        model: 'Octavia',
        year: 2018,
        odometer: 120000,
        records: [
          ServiceRecord(
            title: 'Schimb ulei — înlocuire filtru',
            date: DateTime(2026, 9, 1),
            km: 115000,
            kind: ServiceKind.maintenance,
            notes: 'Заміна фільтра',
            oil: true,
          ),
        ],
      ),
    );
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(bytes.length, greaterThan(1000));
  });
  test(
    'VIN validation avoids requests; network failure returns manual fallback',
    () async {
      final repository = MemoryGarage();
      final decode = DecodeVinUseCase(repository);
      expect((await decode('bad')).isFailure, true);
      expect(repository.requests, 0);
      expect((await decode('wbaev53452km12345')).isSuccess, true);
      repository.failLookup = true;
      expect((await decode('WBAEV53452KM12345')).isFailure, true);
    },
  );

  test('garage and complete history survive repository recreation', () async {
    final directory = await Directory.systemTemp.createTemp('car-log-test-');
    addTearDown(() => directory.delete(recursive: true));
    var store = await openStore(directory: directory.path);
    addTearDown(() => store.close());
    GarageLocalDataSource source() => GarageLocalDataSource(
      store,
      store.box<GarageVehicleBox>(),
      store.box<ServiceRecordBox>(),
      StubLegacyGarage(),
    );
    var repository = source();
    expect(await repository.load(), isNull);
    final vehicle = GarageVehicle(
      make: 'BMW',
      model: 'E39',
      year: 2002,
      odometer: 287450,
      records: [
        ServiceRecord(
          title: 'Oil + filters',
          date: DateTime(2026, 7, 1),
          km: 281900,
          kind: ServiceKind.maintenance,
          cost: 1450,
          notes: 'Oil filter',
          oil: true,
        ),
      ],
    );
    await repository.save(vehicle);
    store.close();
    store = await openStore(directory: directory.path);
    repository = source();
    final restored = (await repository.load())!;
    expect(restored.toJson(), vehicle.toJson());
    expect(
      restored.lastOil!.km + restored.oilInterval - restored.odometer,
      4450,
    );
    await repository.save(vehicle.copyWith(odometer: 288000));
    expect((await repository.load())!.odometer, 288000);
    expect(store.box<GarageVehicleBox>().count(), 1);
    expect(store.box<ServiceRecordBox>().count(), 1);
    await repository.save(vehicle.copyWith(records: []));
    expect((await repository.load())!.records, isEmpty);
    expect(store.box<ServiceRecordBox>().count(), 0);
  });

  test('legacy garage imports once; ObjectBox remains authoritative', () async {
    final directory = await Directory.systemTemp.createTemp('car-log-import-');
    addTearDown(() => directory.delete(recursive: true));
    final store = await openStore(directory: directory.path);
    addTearDown(store.close);
    final legacy = StubLegacyGarage(
      const GarageVehicle(
        make: 'BMW',
        model: 'E39',
        year: 2002,
        odometer: 287450,
      ),
    );
    final local = GarageLocalDataSource(
      store,
      store.box<GarageVehicleBox>(),
      store.box<ServiceRecordBox>(),
      legacy,
    );
    expect(await local.load(), legacy.vehicle);
    expect(legacy.loads, 1);
    await local.save(legacy.vehicle!.copyWith(odometer: 288000));
    expect((await local.load())!.odometer, 288000);
    expect(legacy.loads, 1);
  });

  testWidgets('manual setup saves car and opens real dashboard', (
    tester,
  ) async {
    tester.view.resetPhysicalSize();
    tester.view.physicalSize = const Size(430, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repository = GetIt.instance.get<GarageRepository>() as MemoryGarage;
    await tester.pumpWidget(
      RepaintBoundary(
        key: const ValueKey('preview'),
        child: localized(const CarLogApp()),
      ),
    );
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.onboarding);
    expect(repository.loads, 1);
    expect(find.text('Timeline'), findsNothing);
    await capture(tester, 'onboarding');
    await tester.tap(find.text('Enter details manually'));
    await tester.pumpAndSettle();
    await enterField(tester, 'make', 'BMW');
    await enterField(tester, 'model', 'E39');
    await enterField(tester, 'year', '2002');
    await tester.ensureVisible(find.text('Continue to service history'));
    await tester.tap(find.text('Continue to service history'));
    await tester.pumpAndSettle();
    expect(find.text('Know where you stand.'), findsOneWidget);
    await enterField(tester, 'odometer', '287450');
    await tester.ensureVisible(find.text('Open my garage'));
    await tester.tap(find.text('Open my garage'));
    await tester.pumpAndSettle();
    expect(repository.vehicle!.title, 'BMW E39');
    expect(Get.currentRoute, AppRoutes.main);
    expect(repository.loads, 1);
    expect(find.text('My garage'), findsOneWidget);
    expect(find.text('Unknown'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'VIN returns partial editable details; absent fields remain available',
    (tester) async {
      tester.view.physicalSize = const Size(430, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        app(
          VehicleOnboardingPage(
            controller: onboardingController(MemoryGarage()),
            onSaved: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'WBAEV53452KM12345');
      await tester.tap(find.text('Find my car'));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'Found 3 details. Review them and complete missing fields below.',
        ),
        findsOneWidget,
      );
      final make = tester.widget<SmartTextField>(
        find.byWidgetPredicate((w) => w is SmartTextField && w.name == 'make'),
      );
      expect(make.controller!.text, 'BMW');
      await enterField(tester, 'model', 'E39');
      expect(
        find.byWidgetPredicate((w) => w is SmartTextField && w.name == 'fuel'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'saved garage shows accurate oil status; odometer rejects backwards updates',
    (tester) async {
      tester.view.physicalSize = const Size(430, 1050);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = MemoryGarage()
        ..vehicle = GarageVehicle(
          make: 'BMW',
          model: 'E39',
          year: 2002,
          odometer: 287450,
          insuranceExpiry: DateTime(2026, 12, 12),
          records: [
            ServiceRecord(
              title: 'Oil + filters service',
              date: DateTime(2026, 7, 1),
              km: 281900,
              kind: ServiceKind.maintenance,
              cost: 1450,
              notes: '5W-40 Synthetic · Oil filter · Air filter',
              oil: true,
            ),
            ServiceRecord(
              title: 'Alternator replaced',
              date: DateTime(2026, 9, 1),
              km: 287100,
              kind: ServiceKind.repair,
              cost: 2400,
              notes: 'Replaced with new alternator and belt.',
            ),
          ],
        );
      await tester.pumpWidget(
        app(MainPage(controller: vehicleController(repository))),
      );
      await tester.pumpAndSettle();
      expect(find.text('4,450 km remaining'), findsOneWidget);
      await capture(tester, 'garage');
      await tester.scrollUntilVisible(
        find.text('Odometer\nupdate'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Odometer\nupdate'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '280000');
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();
      expect(find.text('Cannot be lower than 287,450 km'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField), '288000');
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();
      expect(repository.vehicle!.odometer, 288000);
      await tester.tap(find.text('Timeline'));
      await tester.pumpAndSettle();
      expect(find.text('Alternator replaced'), findsOneWidget);
      await capture(tester, 'timeline');
      await tester.tap(find.text('Repairs'));
      await tester.pumpAndSettle();
      expect(find.text('Oil + filters service'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
