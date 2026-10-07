import 'package:flutter/material.dart';
import '../localization/localization.dart';
import 'package:flutter_mesh_gradients/flutter_mesh_gradients.dart';
import 'motion_surface.dart';
import '../utils/app_colors.dart';

String kilometres(int value) => NumberFormat.decimalPattern().format(value);
String displayDate(DateTime value) => DateFormat('d MMM y').format(value);
String displayMonth(DateTime value) => DateFormat('MMMM y').format(value);
String distance(int value) => LocaleKeys.km.tr(namedArgs: {'value': kilometres(value)});
String money(num value, {int decimals = 2}) =>
    LocaleKeys.money.tr(namedArgs: {'value': NumberFormat.decimalPatternDigits(decimalDigits: decimals).format(value)});
String filterLabel(String value) =>
    const [
      LocaleKeys.oil_filter,
      LocaleKeys.air_filter,
      LocaleKeys.cabin_filter,
      LocaleKeys.fuel_filter,
    ].contains(value)
    ? value.tr()
    : value;

class GarageCard extends StatelessWidget {
  const GarageCard({required this.child, this.highlight = false, super.key});
  final Widget child;
  final bool highlight;
  @override
  Widget build(BuildContext context) => MotionSurface(
    highlight: highlight,
    color: highlight ? const Color(0xFF30271B) : const Color(0xFF202124),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: highlight ? AppColors.primaryAmber.withValues(alpha: .5) : Colors.white.withValues(alpha: .13),
        ),
      ),
      child: child,
    ),
  );
}

class GarageBackdrop extends StatelessWidget {
  const GarageBackdrop({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned.fill(
        child: IgnorePointer(
          child: FluidMeshGradient(
            animate: false,
            options: MeshGradientOptions(
              color1: Color(0xFF21180B),
              color2: Color(0xFF0D0E11),
              color3: Color(0xFF10141C),
              color4: Color(0xFF0D0E11),
              amplitude: .1,
              frequency: .3,
              blur: .8,
            ),
          ),
        ),
      ),
      child,
    ],
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {this.subtitle, super.key});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -.6)),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: const TextStyle(color: Colors.white60, height: 1.5)),
        ],
      ],
    ),
  );
}
