import 'package:flutter/material.dart';
import 'package:sensor_shadows/sensor_shadows.dart';
import '../utils/app_colors.dart';

enum _ButtonAppearance { filled, outlined, text, icon }

/// Consistent touch targets, disabled states and sensor lighting across pages.
class GarageButton extends StatelessWidget {
  const GarageButton.filled({
    required this.onPressed,
    this.child,
    this.label,
    this.icon,
    super.key,
  }) : _appearance = _ButtonAppearance.filled,
       tooltip = null;
  const GarageButton.outlined({
    required this.onPressed,
    this.child,
    this.label,
    this.icon,
    super.key,
  }) : _appearance = _ButtonAppearance.outlined,
       tooltip = null;
  const GarageButton.text({
    required this.onPressed,
    required this.child,
    super.key,
  }) : _appearance = _ButtonAppearance.text,
       label = null,
       icon = null,
       tooltip = null;
  const GarageButton.icon({
    required this.onPressed,
    required this.icon,
    this.tooltip,
    super.key,
  }) : _appearance = _ButtonAppearance.icon,
       child = null,
       label = null;

  final VoidCallback? onPressed;
  final Widget? child, label, icon;
  final String? tooltip;
  final _ButtonAppearance _appearance;

  @override
  Widget build(BuildContext context) {
    final filled = _appearance == _ButtonAppearance.filled;
    final iconOnly = _appearance == _ButtonAppearance.icon;
    final foreground = onPressed == null
        ? Colors.white38
        : filled
        ? Colors.black
        : AppColors.primaryAmberLight;
    Widget content = child ?? label ?? const SizedBox.shrink();
    if (icon != null) {
      content = iconOnly
          ? icon!
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!,
                const SizedBox(width: 8),
                Flexible(child: content),
              ],
            );
    }
    Widget button = SensorShadowButton(
      onPressed: onPressed,
      foregroundColor: foreground,
      padding: iconOnly
          ? const EdgeInsets.all(12)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      style: SensorShadowStyle(
        color: onPressed == null
            ? const Color(0xFF272727)
            : filled
            ? AppColors.primaryAmber
            : const Color(0xFF212224),
        shadowColor: Colors.black.withValues(alpha: .4),
        highlightColor: filled
            ? AppColors.primaryAmberLight
            : AppColors.primaryAmber,
        lightIntensity: filled ? .2 : .065,
        maxOffset: 6,
        blurRadius: 16,
        borderRadius: BorderRadius.circular(iconOnly ? 24 : 16),
      ),
      child: content,
    );
    if (_appearance == _ButtonAppearance.outlined) {
      button = DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryAmber.withValues(alpha: .6),
          ),
        ),
        child: button,
      );
    }
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
