import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

/// Asset-based loader; locale comes from EasyLocalization, not a controller.
class LocalizationLoader extends RootBundleAssetLoader {
  const LocalizationLoader();
  static const path = 'assets/localization';
  static const supportedLocales = [Locale('en'), Locale('ro')];
  static const fallbackLocale = Locale('en');
}
