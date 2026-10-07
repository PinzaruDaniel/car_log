import 'package:flutter/material.dart';
import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';

class SettingsController extends BaseController {
  Future<void> changeLanguage(BuildContext context, Locale? locale) async {
    if (locale != null) await context.setLocale(locale);
  }
}
