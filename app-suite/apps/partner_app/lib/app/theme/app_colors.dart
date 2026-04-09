import 'package:flutter/material.dart';

abstract final class AppColors {
  // Main brand color.
  // You see this on the app name, primary buttons, active OTP accents,
  // and any auth UI that follows the app theme.
  static const Color primary = Colors.pink;

  // Main page background color.
  // You see this behind screens, app bars, and document pages.
  static const Color surface = Colors.white;

  // Light helper surface color.
  // You see this inside input boxes, search bars, and soft containers.
  static const Color surfaceSubtle = Color(0xFFF5F7FA);

  // Strong dark text color.
  // You see this on headings, document titles, and other important text.
  static const Color onSurface = Color(0xFF1A1A1A);

  // Soft border color.
  // You see this on input borders, dividers, and subtle outlines.
  static const Color borderSubtle = Color(0xFFE4E7EC);

  // Secondary text color.
  // You see this on helper text and lower-emphasis actions.
  static const Color textSecondary = Color(0xFF6B7280);

  // Middle-strength text color.
  // You see this on the tag line and medium-emphasis supporting text.
  static const Color textNeutral = Color(0xFF4B5563);

  // Muted text color.
  // You see this on small helper copy like the legal line above the links.
  static const Color textMuted = Color(0xFF98A2B3);

  // Primary text color for regular content.
  // You see this on entered values, legal links, and other strong text.
  static const Color textPrimary = Color(0xFF101828);

  // Error color.
  // You see this on validation messages and error states.
  static const Color error = Color(0xFFD92D20);

  // Progress color.
  // You see this on loading indicators when a neutral loader is needed.
  static const Color progress = Color(0xFF8F96A3);
}
