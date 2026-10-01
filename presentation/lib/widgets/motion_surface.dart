import 'package:flutter/material.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import '../utils/app_colors.dart';

/// Shared lighting from the app's SensorShadows scope; respects reduced motion.
class MotionSurface extends StatelessWidget {
  const MotionSurface({
    required this.child,
    this.radius = 24,
    this.highlight = false,
    this.enabled = true,
    this.color = const Color(0xFF202124),
    super.key,
  });
  final Widget child;
  final double radius;
  final bool highlight, enabled;
  final Color color;

  @override
  Widget build(BuildContext context) => SensorShadow(
    enabled: enabled,
    style: SensorShadowStyle(
      color: color,
      shadowColor: Colors.black.withValues(alpha: .45),
      highlightColor: highlight ? AppColors.primaryAmberLight : Colors.white,
      lightIntensity: highlight ? .12 : .045,
      maxOffset: 8,
      blurRadius: 22,
      ambientOffset: const Offset(0, 6),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}
