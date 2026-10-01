import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GarageBadge extends StatelessWidget {
  const GarageBadge(
    this.text, {
    this.color = AppColors.primaryAmber,
    this.filled = false,
    super.key,
  });
  final String text;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: color),
      color: filled ? color : color.withValues(alpha: .08),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: filled ? Colors.black : color,
        fontSize: 13,
        fontWeight: filled ? FontWeight.w600 : FontWeight.w400,
      ),
    ),
  );
}
