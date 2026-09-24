import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/vehicle_controller.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  late final VehicleController controller;

  @override
  void initState() {
    super.initState();
    Get.put(VehicleController());
    controller = Get.find<VehicleController>();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(child: Text('Vehicle'));
        }
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return VehicleViewItem(id: controller.items[index]);
          },
        );
      }),
    );
  }
}

class VehicleViewItem extends StatelessWidget {
  const VehicleViewItem({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(id));
  }
}

