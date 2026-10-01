import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import 'vehicle/vehicle_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({this.controller, super.key});
  final VehicleController? controller;
  @override
  Widget build(BuildContext context) => VehiclePage(controller: controller);
}
