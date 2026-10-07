import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_kit/flutter_liquid_glass_kit.dart';
import '../controllers/base/imports/controller_imports.dart';
import '../localization/localization.dart';
import '../utils/app_colors.dart';
import '../widgets/garage_widgets.dart';
import '../widgets/localized_obx.dart';
import '../widgets/motion_surface.dart';
import 'analytics/analytics_page.dart';
import 'settings/settings_page.dart';
import 'timeline/timeline_page.dart';
import 'vehicle/vehicle_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  StreamSubscription<int>? _tabSubscription;

  List<Widget> get _tabs => const [VehiclePage(), TimelinePage(), AnalyticsPage(), SettingsPage()];

  @override
  void initState() {
    super.initState();
    _tabSubscription = mainAppController.mainTabStreamController.stream.listen(_onTabSelected);
  }

  void _onTabSelected(int index) {
    if (!mounted || index == _currentIndex || index < 0 || index >= _tabs.length) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedObx(
      () => Scaffold(
        body: GarageBackdrop(
          child: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: IndexedStack(
                  index: _currentIndex,
                  children: [for (var index = 0; index < _tabs.length; index++) _buildTab(index, _tabs[index])],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: MotionSurface(
            radius: 28,
            child: LiquidGlassNavBar(
              activeColor: AppColors.primaryAmber,
              inactiveColor: Colors.white54,
              indicatorColor: AppColors.primaryAmber.withValues(alpha: .14),
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
              items: [
                LiquidGlassNavItem(
                  icon: const Icon(Icons.directions_car_outlined),
                  label: LocaleKeys.garage.tr(),
                  iosSystemImage: 'car',
                  iosSelectedSystemImage: 'car.fill',
                ),
                LiquidGlassNavItem(
                  icon: const Icon(Icons.format_list_bulleted),
                  label: LocaleKeys.timeline.tr(),
                  iosSystemImage: 'list.bullet',
                ),
                LiquidGlassNavItem(
                  icon: const Icon(Icons.bar_chart_rounded),
                  label: LocaleKeys.analytics.tr(),
                  iosSystemImage: 'chart.bar',
                ),
                LiquidGlassNavItem(
                  icon: const Icon(Icons.settings_outlined),
                  label: LocaleKeys.settings.tr(),
                  iosSystemImage: 'gearshape',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, Widget page) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      children: [
        if (index != 1)
          Row(
            children: [
              Expanded(
                child: Text(
                  [
                    LocaleKeys.my_garage.tr(),
                    LocaleKeys.service_history.tr(),
                    LocaleKeys.analytics.tr(),
                    LocaleKeys.settings.tr(),
                  ][index],
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              if (mainAppController.saving)
                const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            ],
          ),
        if (index != 1) const SizedBox(height: 22),
        page,
      ],
    );
  }

  @override
  void dispose() {
    _tabSubscription?.cancel();
    super.dispose();
  }
}
