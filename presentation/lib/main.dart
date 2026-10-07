import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/utils/app_colors.dart';
import 'package:smart_form_fields/smart_form_fields.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import 'package:get/get.dart' hide Trans;
import 'bindings/root_binding.dart';
import 'controllers/main_app_controller.dart';
import 'navigation/app_routes.dart';
import 'pages/startup/startup_page.dart';
import 'pages/vehicle/vehicle_onboarding_page.dart';
import 'localization/localization.dart';
import 'localization/localization_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDi(get: GetIt.instance);
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationLoader.supportedLocales,
      fallbackLocale: LocalizationLoader.fallbackLocale,
      path: LocalizationLoader.path,
      assetLoader: const LocalizationLoader(),
      useFallbackTranslations: true,
      child: const CarLogApp(),
    ),
  );
}

class CarLogApp extends StatelessWidget {
  const CarLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = context.locale.toLanguageTag();
    // GetMaterialApp prefers Get.locale over updated widget.locale.
    Get.locale = context.locale;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => SensorShadows(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: LocaleKeys.app_name.tr(),
          theme: carTrackerDarkTheme,
          initialBinding: RootBinding(),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          initialRoute: AppRoutes.startup,
          getPages: [
            GetPage(name: AppRoutes.startup, page: () => const StartupPage()),
            GetPage(name: AppRoutes.main, page: () => const MainPage()),
            GetPage(
              name: AppRoutes.onboarding,
              page: () => VehicleOnboardingPage(
                onSaved: Get.find<MainAppController>().completeOnboarding,
              ),
            ),
          ],
          builder: (context, child) => SmartFormTheme(
            data: SmartFormThemeData(errorAnimation: SmartErrorAnimation.shake),
            child: child!,
          ),
        ),
      ),
    );
  }
}
