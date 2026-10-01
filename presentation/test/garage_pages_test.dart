import 'dart:async';
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/pages/timeline/timeline_page.dart';
import 'package:car_log/widgets/garage_button.dart';
import 'package:car_log/widgets/motion_surface.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import 'package:domain/features/garage/repositories/garage_repository.dart';
import 'package:domain/injector.dart' as domain_di;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import 'garage_flow_test.dart' as fixtures;

fixtures.MemoryGarage savedGarage() =>
    fixtures.MemoryGarage()
      ..vehicle = GarageVehicle(
        make: 'BMW',
        model: 'E39',
        year: 2002,
        odometer: 287450,
        records: [
          ServiceRecord(
            title: 'Alternator replaced',
            date: DateTime(2026, 9, 1),
            km: 287100,
            kind: ServiceKind.repair,
            cost: 2400,
            notes: 'Replaced with new alternator and belt.',
          ),
          ServiceRecord(
            title: 'Oil + filters service',
            date: DateTime(2026, 7, 1),
            km: 281900,
            kind: ServiceKind.maintenance,
            cost: 1450,
            oil: true,
            notes: '5W-40 Synthetic · Oil filter · Air filter',
          ),
          ServiceRecord(
            title: 'Fuel stop',
            date: DateTime(2025, 12, 1),
            km: 270000,
            kind: ServiceKind.fuel,
            cost: 900,
          ),
        ],
      );

void main() {
  setUp(() async {
    await fixtures.initializeTestLocalization();
    GetIt.instance.registerSingleton<GarageRepository>(fixtures.MemoryGarage());
    domain_di.configureDependencies(GetIt.instance);
  });
  tearDown(() => GetIt.instance.reset());

  test('controller groups sorted history by year/month and category', () {
    final controller = fixtures.vehicleController(savedGarage());
    controller.acceptVehicle(savedGarage().vehicle!);
    expect(controller.historyGroups.map((g) => (g.year, g.month)), [
      (2026, 9),
      (2026, 7),
      (2025, 12),
    ]);
    controller.setFilter(ServiceKind.fuel);
    expect(controller.historyGroups.single.records.single.title, 'Fuel stop');
    controller.showGarage();
    expect(controller.tab.value, 0);
  });

  testWidgets('history filters, empty state, back and remaining tabs work', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 1050);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repository = savedGarage();
    final controller = fixtures.vehicleController(repository);
    await tester.pumpWidget(fixtures.app(MainPage(controller: controller)));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Car illustration'), findsNothing);
    expect(find.byType(SensorShadowButton), findsWidgets);
    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();
    expect(find.byType(TimelinePage), findsOneWidget);
    expect(find.text('September 2026'), findsOneWidget);
    expect(find.text('Export PDF'), findsOneWidget);
    await tester.tap(find.text('Fuel'));
    await tester.pumpAndSettle();
    expect(find.text('Fuel stop'), findsOneWidget);
    expect(find.text('Alternator replaced'), findsNothing);
    await tester.tap(find.byTooltip('Back to garage'));
    await tester.pumpAndSettle();
    expect(find.text('My garage'), findsOneWidget);
    await tester.tap(find.text('Analytics'));
    await tester.pumpAndSettle();
    expect(find.text('Every kilometre counts.'), findsOneWidget);
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Saved on this device'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty history can save its first record', (tester) async {
    final repository = savedGarage()
      ..vehicle = savedGarage().vehicle!.copyWith(records: []);
    final controller = fixtures.vehicleController(repository);
    await tester.pumpWidget(fixtures.app(MainPage(controller: controller)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();
    expect(find.text('No records in this category.'), findsOneWidget);
    await tester.tap(find.text('Add record'));
    await tester.pumpAndSettle();
    await fixtures.enterField(tester, 'title', 'Air filter replaced');
    await fixtures.enterField(tester, 'km', '287400');
    await tester.ensureVisible(find.text('Save record'));
    await tester.tap(find.text('Save record'));
    await tester.pumpAndSettle();
    expect(repository.vehicle!.records.single.title, 'Air filter replaced');
    expect(find.text('No records in this category.'), findsNothing);
    expect(find.text('Air filter replaced'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('history remains usable on narrow screens with large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = fixtures.vehicleController(savedGarage())
      ..acceptVehicle(savedGarage().vehicle!);
    await tester.pumpWidget(
      fixtures.app(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 1000),
            textScaler: TextScaler.linear(1.6),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: TimelinePage(controller: controller),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Service History - BMW E39'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sensor surfaces react to tilt and respect reduced motion', (
    tester,
  ) async {
    final sensor = SensorShadowController(
      samples: const Stream<TiltSample>.empty(),
      autoStart: false,
    );
    addTearDown(sensor.dispose);
    Widget surface(bool reduced) => MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduced),
        child: SensorShadowScope(
          controller: sensor,
          child: const Center(
            child: MotionSurface(
              key: ValueKey('surface'),
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      ),
    );
    Offset shadowOffset() =>
        (tester
                    .widget<DecoratedBox>(
                      find
                          .descendant(
                            of: find.byKey(const ValueKey('surface')),
                            matching: find.byType(DecoratedBox),
                          )
                          .first,
                    )
                    .decoration
                as BoxDecoration)
            .boxShadow!
            .single
            .offset;
    await tester.pumpWidget(surface(false));
    final neutral = shadowOffset();
    sensor.value = const Offset(.8, -.5);
    await tester.pump();
    expect(shadowOffset(), isNot(neutral));
    await tester.pumpWidget(surface(true));
    sensor.value = const Offset(-.8, .5);
    await tester.pump();
    expect(shadowOffset(), neutral);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disabled sensor buttons do not invoke actions', (tester) async {
    var presses = 0;
    await tester.pumpWidget(
      fixtures.app(
        GarageButton.filled(
          onPressed: null,
          child: const Text('Disabled action'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Disabled action'));
    expect(presses, 0);
    await tester.pumpWidget(
      fixtures.app(
        GarageButton.filled(
          onPressed: () => presses++,
          child: const Text('Enabled action'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enabled action'));
    expect(presses, 1);
  });
}
