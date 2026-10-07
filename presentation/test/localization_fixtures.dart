import 'dart:convert';
import 'package:car_log/localization/localization.dart';
import 'package:car_log/localization/localization_loader.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _translations = <String, Map<String, dynamic>>{};

class TestLocalizationLoader extends AssetLoader {
  const TestLocalizationLoader();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) => Future.value(_translations[locale.languageCode]!);
}

Future<void> initializeTestLocalization() async {
  EasyLocalization.logger.enableLevels = [];
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('en');
  await initializeDateFormatting('ro');
  Intl.defaultLocale = 'en';
  for (final language in ['en', 'ro']) {
    _translations[language] =
        jsonDecode(await rootBundle.loadString('assets/localization/$language.json')) as Map<String, dynamic>;
  }
  Localization.load(const Locale('en'), translations: Translations(_translations['en']));
}

Widget localized(Widget child, {Locale locale = const Locale('en')}) => EasyLocalization(
  supportedLocales: LocalizationLoader.supportedLocales,
  fallbackLocale: LocalizationLoader.fallbackLocale,
  startLocale: locale,
  saveLocale: false,
  path: LocalizationLoader.path,
  assetLoader: const TestLocalizationLoader(),
  child: child,
);
