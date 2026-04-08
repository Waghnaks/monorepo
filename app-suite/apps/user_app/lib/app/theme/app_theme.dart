import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const Color primaryColor = AppColors.primary;
  static const Color _surfaceColor = AppColors.surface;
  static const Color _onSurfaceColor = AppColors.onSurface;

  static ThemeData get light {
    final onPrimaryColor =
        ThemeData.estimateBrightnessForColor(primaryColor) == Brightness.dark
        ? Colors.white
        : Colors.black;
    final colorScheme = const ColorScheme.light(
      surface: _surfaceColor,
      onSurface: _onSurfaceColor,
    ).copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: primaryColor,
      onSecondary: onPrimaryColor,
      surface: _surfaceColor,
      onSurface: _onSurfaceColor,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: _surfaceColor,
      canvasColor: _surfaceColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _surfaceColor,
        foregroundColor: _onSurfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
