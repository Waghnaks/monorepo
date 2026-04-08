import 'package:flutter/material.dart';

abstract final class AppColors {
  // Used by: ColorScheme.primary, PhoneEntryScreen app name, and shared button
  // states that follow the app theme when no explicit color is passed.
  static const Color primary = Colors.pink;

  // Used by: scaffold background, app bars, and PhoneAuth document surfaces.
  static const Color surface = Colors.white;

  // Used by: subtle filled surfaces like shared inputs, search bars, and
  // supporting containers that should sit slightly above the main surface.
  static const Color surfaceMuted = Color(0xFFF5F7FA);

  // Used by: ColorScheme.onSurface, default headings, and document titles.
  static const Color onSurface = Color(0xFF1A1A1A);

  // Used by: subtle outlines, input borders, dividers, and low-emphasis strokes.
  static const Color borderSubtle = Color(0xFFE4E7EC);

  // Used by: PhoneEntryScreen tag line and any secondary supporting copy.
  static const Color textSecondary = Color(0xFF6B7280);

  // Used by: PhoneEntryScreen tag line and medium-emphasis supporting copy
  // that should sit visually between strong black text and grey text.
  static const Color textNeutral = Color(0xFF4B5563);

  // Used by: PhoneAuthLegalNotice acknowledgement copy and other subtle text.
  static const Color textMuted = Color(0xFF98A2B3);

  // Used by: PhoneAuthLegalNotice legal links and strong neutral text actions.
  static const Color textStrong = Color(0xFF101828);

  // Used by: validation errors and destructive inline feedback states.
  static const Color error = Color(0xFFD92D20);

  // Used by: PhoneAuthDocumentLoadingView progress indicator.
  static const Color loadingIndicator = Color(0xFF8F96A3);
}
