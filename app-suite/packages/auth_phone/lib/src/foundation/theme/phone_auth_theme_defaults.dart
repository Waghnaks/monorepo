import 'package:flutter/material.dart';

abstract final class PhoneAuthThemeDefaults {
  static const Color surfaceMutedColor = Color(0xFFF5F7FA);
  static const Color outlineColor = Color(0xFFE4E7EC);
  static const Color mutedForegroundColor = Color(0xFF667085);
  static const Color dangerColor = Color(0xFFD92D20);

  static TextStyle brandTextStyle(Color color) => TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: -1.15,
        height: 0.98,
      );

  static TextStyle tagLineTextStyle(Color color) => TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.35,
      );

  static TextStyle headingTextStyle(Color color) => TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle supportingTextStyle(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.45,
      );

  static TextStyle actionTextStyle(Color color) => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.35,
        letterSpacing: 0.08,
      );

  static TextStyle fieldLabelTextStyle(Color color) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.08,
      );

  static TextStyle valueTextStyle(Color color) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.3,
      );

  static TextStyle fieldHintTextStyle(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle legalTextStyle(Color color) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.35,
      );

  static TextStyle legalLinkTextStyle(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.30,
        decoration: TextDecoration.underline,
        decorationColor: color,
        decorationThickness: 1.15,
      );

  static TextStyle documentTitleTextStyle(Color color) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.25,
      );

  static TextStyle accentTitleTextStyle(Color color) => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: -0.35,
      );
}
