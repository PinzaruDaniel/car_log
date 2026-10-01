import 'package:car_log/controllers/vehicle_onboarding_controller.dart';
import 'package:car_log/localization/localization.dart';
import 'package:car_log/pages/vehicle/vehicle_onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import 'garage_flow_test.dart' as fixtures;

Finder formFor(SmartFormController controller) => find.byWidgetPredicate(
  (widget) => widget is SmartForm && identical(widget.controller, controller),
  skipOffstage: false,
);

SmartFormState formState(WidgetTester tester, SmartFormController controller) =>
    tester.state<SmartFormState>(formFor(controller));

Future<VehicleOnboardingController> mountSetup(
  WidgetTester tester, {
  fixtures.MemoryGarage? repository,
  bool details = true,
}) async {
  tester.view.physicalSize = const Size(430, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final controller = fixtures.onboardingController(
    repository ?? fixtures.MemoryGarage(),
  );
  controller.details.value = details;
  controller.fields['make']!.text = 'BMW';
  controller.fields['model']!.text = 'E39';
  controller.fields['year']!.text = '2002';
  await tester.pumpWidget(
    fixtures.app(
      VehicleOnboardingPage(controller: controller, onSaved: (_) {}),
    ),
  );
  await tester.pumpAndSettle();
  return controller;
}

void expectStableForms(
  WidgetTester tester,
  VehicleOnboardingController controller,
  SmartFormState car,
  SmartFormState service,
) {
  expect(formFor(controller.carForm), findsOneWidget);
  expect(formFor(controller.serviceForm), findsOneWidget);
  expect(formState(tester, controller.carForm), same(car));
  expect(formState(tester, controller.serviceForm), same(service));
  expect(controller.carForm.isAttached, true);
  expect(controller.serviceForm.isAttached, true);
  expect(tester.takeException(), isNull);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(fixtures.initializeTestLocalization);

  testWidgets('rapid forward/back retains one mounted form per controller', (
    tester,
  ) async {
    final controller = await mountSetup(tester);
    final car = formState(tester, controller.carForm);
    final service = formState(tester, controller.serviceForm);
    final context = tester.element(find.byType(VehicleOnboardingPage));
    for (var i = 0; i < 5; i++) {
      await controller.next(context);
      await tester.pump(const Duration(milliseconds: 16));
      expect(controller.step.value, 1);
      expectStableForms(tester, controller, car, service);
      controller.goBack();
      await tester.pump(const Duration(milliseconds: 16));
      expect(controller.step.value, 0);
      expectStableForms(tester, controller, car, service);
    }
    await tester.pumpAndSettle();
    expect(controller.fields['make']!.text, 'BMW');
    expect(controller.fields['model']!.text, 'E39');
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('status/warning insertion and removal never remount forms', (
    tester,
  ) async {
    final controller = await mountSetup(tester);
    final car = formState(tester, controller.carForm);
    final service = formState(tester, controller.serviceForm);
    for (final message in [
      LocaleKeys.manual_message,
      LocaleKeys.vin_found_details,
      LocaleKeys.vin_unavailable,
      null,
    ]) {
      controller.message.value = message;
      controller.hasVinWarning.value = !controller.hasVinWarning.value;
      await tester.pumpAndSettle();
      expectStableForms(tester, controller, car, service);
    }
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('VIN retries and manual fallback keep existing forms attached', (
    tester,
  ) async {
    final repository = fixtures.MemoryGarage()
      ..decoded = {'make': 'BMW', 'model': '530i', '_warning': 'vin_warning'};
    final controller = await mountSetup(tester, repository: repository);
    final car = formState(tester, controller.carForm);
    final service = formState(tester, controller.serviceForm);
    controller.vin.text = 'WBAEV53452KM12345';
    var lookup = controller.decode();
    await tester.pump();
    await lookup;
    await tester.pumpAndSettle();
    expect(controller.hasVinWarning.value, true);
    expect(controller.fields['model']!.text, '530i');
    expectStableForms(tester, controller, car, service);
    repository.failLookup = true;
    lookup = controller.decode();
    await tester.pump();
    await lookup;
    await tester.pumpAndSettle();
    expect(controller.message.value, LocaleKeys.vin_unavailable);
    expectStableForms(tester, controller, car, service);
    controller.useManualEntry();
    await tester.pumpAndSettle();
    expect(repository.requests, 2);
    expect(controller.fields['model']!.text, '530i');
    expectStableForms(tester, controller, car, service);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('validation stays scoped; back clears hidden field focus', (
    tester,
  ) async {
    final controller = await mountSetup(tester);
    expect(
      (await controller.carForm.validate(
        scrollToError: false,
        focusFirstError: false,
      )).isValid,
      true,
    );
    expect(
      (await controller.serviceForm.validate(
        scrollToError: false,
        focusFirstError: false,
      )).isValid,
      false,
    );
    await controller.next(tester.element(find.byType(VehicleOnboardingPage)));
    await tester.pumpAndSettle();
    expect(find.text('Meet your car.'), findsNothing);
    expect(find.text('Know where you stand.'), findsOneWidget);
    await fixtures.enterField(tester, 'odometer', '287450');
    final odometer = find.byWidgetPredicate(
      (widget) => widget is SmartTextField && widget.name == 'odometer',
    );
    final focus = tester
        .widget<EditableText>(
          find.descendant(of: odometer, matching: find.byType(EditableText)),
        )
        .focusNode;
    expect(focus.hasFocus, true);
    controller.goBack();
    await tester.pumpAndSettle();
    expect(focus.hasFocus, false);
    expect(find.text('Know where you stand.'), findsNothing);
    expect(controller.fields['odometer']!.text, '287450');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('details reveal/hide preserves form; disposal permits reattach', (
    tester,
  ) async {
    final controller = await mountSetup(tester, details: false);
    final car = formState(tester, controller.carForm);
    final service = formState(tester, controller.serviceForm);
    for (final visible in [true, false, true]) {
      controller.details.value = visible;
      await tester.pumpAndSettle();
      expectStableForms(tester, controller, car, service);
    }
    await tester.pumpWidget(const SizedBox());
    expect(controller.carForm.isAttached, false);
    expect(controller.serviceForm.isAttached, false);
    await tester.pumpWidget(
      fixtures.app(
        VehicleOnboardingPage(controller: controller, onSaved: (_) {}),
      ),
    );
    await tester.pumpAndSettle();
    expect(formFor(controller.carForm), findsOneWidget);
    expect(formFor(controller.serviceForm), findsOneWidget);
    expect(controller.fields['make']!.text, 'BMW');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('locale change retains active and hidden form state', (
    tester,
  ) async {
    final controller = await mountSetup(tester);
    final car = formState(tester, controller.carForm);
    final service = formState(tester, controller.serviceForm);
    await tester
        .element(find.byType(VehicleOnboardingPage))
        .setLocale(const Locale('ro'));
    await tester.pumpAndSettle();
    expectStableForms(tester, controller, car, service);
    expect(controller.fields['model']!.text, 'E39');
    expect(find.text('Adaugă mașina ta.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
}
