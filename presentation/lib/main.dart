import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:car_log/pages/main_page.dart';
import 'package:car_log/utils/app_colors.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi(get: GetIt.instance);
  runApp(const CarLogApp());
}

class CarLogApp extends StatelessWidget {
  const CarLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car log',
      theme: carTrackerDarkTheme,
      home: SmartFormTheme(
        data: SmartFormThemeData(errorAnimation: SmartErrorAnimation.shake),
        child: MainPage(),
      ),
    );
  }
}
