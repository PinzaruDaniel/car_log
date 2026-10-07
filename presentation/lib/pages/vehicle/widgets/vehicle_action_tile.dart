import 'package:flutter/material.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import '../../../utils/app_colors.dart';

class VehicleActionTile extends StatelessWidget {
  const VehicleActionTile({required this.label, required this.icon, required this.onPressed, super.key});
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SensorShadowButton(
    onPressed: onPressed,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 6),
    style: const SensorShadowStyle(
      color: Color(0xFF242426),
      highlightColor: AppColors.primaryAmberLight,
      lightIntensity: .07,
      maxOffset: 8,
      blurRadius: 20,
      borderRadius: BorderRadius.all(Radius.circular(22)),
    ),
    child: Column(
      children: [
        Icon(icon, color: AppColors.primaryAmber, size: 31),
        const SizedBox(height: 12),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}
