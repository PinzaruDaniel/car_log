import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primaryAmber = Color(0xFFF59E0B);
  static const Color primaryAmberDark = Color(0xFFD97706);
  static const Color primaryAmberLight = Color(0xFFFCD34D);

  // Background & Surfaces
  static const Color scaffoldDark = Color(0xFF0D0E11);
  static const Color cardSurface = Color(0xFF181A20);
  static const Color inputSurface = Color(0xFF22252D);
  static const Color borderStroke = Color(0xFF2D3139);

  // Semantics
  static const Color statusGreen = Color(0xFF10B981);
  static const Color statusWarning = Color(0xFFF97316);
  static const Color statusDanger = Color(0xFFEF4444);
}

final ThemeData carTrackerDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'NotoSans',
  scaffoldBackgroundColor: AppColors.scaffoldDark,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(
        fontFamily: 'NotoSans',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryAmber,
    secondary: AppColors.primaryAmberLight,
    surface: AppColors.cardSurface,
    error: AppColors.statusDanger,
    onPrimary: Colors.black,
    onSurface: Colors.white,
  ),
  cardTheme: CardThemeData(
    color: AppColors.cardSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderStroke, width: 1),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.inputSurface,

    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderStroke, width: 1),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryAmber, width: 2),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.statusDanger, width: 1),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.statusDanger, width: 2),
    ),

    /* contentPadding: const EdgeInsets.symmetric(
       horizontal: 16,
       vertical: 14,
     ),*/
  ),
);
