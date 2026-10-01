import 'package:flutter/material.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import '../../../utils/app_colors.dart';

class HistoryFilter extends StatelessWidget {
  const HistoryFilter({
    required this.label,
    required this.selected,
    required this.onPressed,
    super.key,
  });
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: SensorShadowButton(
      onPressed: onPressed,
      foregroundColor: selected ? Colors.black : Colors.white70,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      style: SensorShadowStyle(
        color: selected ? AppColors.primaryAmber : const Color(0xFF2A2A2C),
        highlightColor: selected ? AppColors.primaryAmberLight : Colors.white,
        lightIntensity: selected ? .2 : .05,
        maxOffset: 5,
        blurRadius: 16,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(label, style: const TextStyle(fontSize: 15)),
    ),
  );
}
