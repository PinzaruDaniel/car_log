import 'vehicle/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_kit/flutter_liquid_glass_kit.dart';

import 'auth/auth_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [VehiclePage(), AuthPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[currentIndex],
          LiquidGlassFloatingNavBar(
            child: LiquidGlassNavBar(
              items: getNavItems(),
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              scrollConfiguration: const LiquidGlassNavBarScrollConfiguration(
                collapsedScale: 0.82,
                collapseThreshold: 12,
                expandThreshold: 12,
                animationDuration: Duration(milliseconds: 280),
                idleExpandDuration: Duration(seconds: 5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<LiquidGlassNavItem> getNavItems() {
    return [
      LiquidGlassNavItem(
        icon: Icon(Icons.car_repair_rounded),
        label: 'Vehicles',
        iosSystemImage: 'car',
        iosSelectedSystemImage: 'car.fill',
      ),LiquidGlassNavItem(
        icon: Icon(Icons.car_repair_rounded),
        label: 'Vehicle',
        iosSystemImage: 'car',
        iosSelectedSystemImage: 'car.fill',
      ),

    ];
  }
}
