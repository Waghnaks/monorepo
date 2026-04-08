import 'package:auth_phone/src/foundation/theme/phone_auth_theme_defaults.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_theme_extension.dart';
import 'package:flutter/material.dart';

@immutable
class PhoneAuthResolvedTheme {
  const PhoneAuthResolvedTheme({
    required this.accentColor,
    required this.onAccentColor,
    required this.brandTextStyle,
    required this.tagLineTextStyle,
    required this.headingTextStyle,
    required this.supportingTextStyle,
    required this.actionTextStyle,
    required this.leadingValueTextStyle,
    required this.inputLabelTextStyle,
    required this.inputTextStyle,
    required this.inputHintTextStyle,
    required this.legalTextStyle,
    required this.legalLinkTextStyle,
    required this.documentTitleTextStyle,
    required this.accentTitleTextStyle,
    required this.surfaceMutedColor,
    required this.outlineColor,
    required this.mutedForegroundColor,
    required this.dangerColor,
    required this.documentBackgroundColor,
    required this.documentViewerBackgroundColor,
    required this.documentLoaderColor,
  });

  final Color accentColor;
  final Color onAccentColor;
  final TextStyle brandTextStyle;
  final TextStyle tagLineTextStyle;
  final TextStyle headingTextStyle;
  final TextStyle supportingTextStyle;
  final TextStyle actionTextStyle;
  final TextStyle leadingValueTextStyle;
  final TextStyle inputLabelTextStyle;
  final TextStyle inputTextStyle;
  final TextStyle inputHintTextStyle;
  final TextStyle legalTextStyle;
  final TextStyle legalLinkTextStyle;
  final TextStyle documentTitleTextStyle;
  final TextStyle accentTitleTextStyle;
  final Color surfaceMutedColor;
  final Color outlineColor;
  final Color mutedForegroundColor;
  final Color dangerColor;
  final Color documentBackgroundColor;
  final Color documentViewerBackgroundColor;
  final Color documentLoaderColor;

  factory PhoneAuthResolvedTheme.of(
    BuildContext context, {
    Color? accentColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authTheme = theme.extension<PhoneAuthThemeExtension>();
    final resolvedAccentColor = accentColor ?? colorScheme.primary;
    final resolvedOnAccentColor = accentColor == null
        ? colorScheme.onPrimary
        : ThemeData.estimateBrightnessForColor(accentColor) == Brightness.dark
            ? Colors.white
            : Colors.black;
    final defaultMutedForegroundColor =
        colorScheme.onSurface.withValues(alpha: 0.68);
    final resolvedMutedForegroundColor = authTheme?.mutedForegroundColor ??
        PhoneAuthThemeDefaults.mutedForegroundColor;
    final resolvedSurfaceMutedColor = authTheme?.surfaceMutedColor ??
        PhoneAuthThemeDefaults.surfaceMutedColor;
    final resolvedOutlineColor =
        authTheme?.outlineColor ?? PhoneAuthThemeDefaults.outlineColor;
    final resolvedDangerColor = authTheme?.dangerColor ?? colorScheme.error;

    final baseBrandTextStyle = authTheme?.brandTextStyle ??
        PhoneAuthThemeDefaults.brandTextStyle(resolvedAccentColor);

    return PhoneAuthResolvedTheme(
      accentColor: resolvedAccentColor,
      onAccentColor: resolvedOnAccentColor,
      brandTextStyle: baseBrandTextStyle.copyWith(color: resolvedAccentColor),
      tagLineTextStyle: authTheme?.tagLineTextStyle ??
          PhoneAuthThemeDefaults.tagLineTextStyle(
            authTheme?.mutedForegroundColor ?? defaultMutedForegroundColor,
          ),
      headingTextStyle: authTheme?.headingTextStyle ??
          PhoneAuthThemeDefaults.headingTextStyle(colorScheme.onSurface),
      supportingTextStyle: authTheme?.supportingTextStyle ??
          PhoneAuthThemeDefaults.supportingTextStyle(
              defaultMutedForegroundColor),
      actionTextStyle: authTheme?.actionTextStyle ??
          PhoneAuthThemeDefaults.actionTextStyle(
            authTheme?.mutedForegroundColor ??
                colorScheme.onSurface.withValues(alpha: 0.72),
          ),
      leadingValueTextStyle: authTheme?.leadingValueTextStyle ??
          PhoneAuthThemeDefaults.leadingValueTextStyle(colorScheme.onSurface),
      inputLabelTextStyle: authTheme?.inputLabelTextStyle ??
          PhoneAuthThemeDefaults.inputLabelTextStyle(
              resolvedMutedForegroundColor),
      inputTextStyle: authTheme?.inputTextStyle ??
          PhoneAuthThemeDefaults.inputTextStyle(colorScheme.onSurface),
      inputHintTextStyle: authTheme?.inputHintTextStyle ??
          PhoneAuthThemeDefaults.inputHintTextStyle(
              resolvedMutedForegroundColor),
      legalTextStyle: authTheme?.legalTextStyle ??
          PhoneAuthThemeDefaults.legalTextStyle(
            colorScheme.onSurface.withValues(alpha: 0.58),
          ),
      legalLinkTextStyle: authTheme?.legalLinkTextStyle ??
          PhoneAuthThemeDefaults.legalLinkTextStyle(colorScheme.onSurface),
      documentTitleTextStyle: authTheme?.documentTitleTextStyle ??
          PhoneAuthThemeDefaults.documentTitleTextStyle(colorScheme.onSurface),
      accentTitleTextStyle: authTheme?.accentTitleTextStyle ??
          PhoneAuthThemeDefaults.accentTitleTextStyle(resolvedAccentColor),
      surfaceMutedColor: resolvedSurfaceMutedColor,
      outlineColor: resolvedOutlineColor,
      mutedForegroundColor: resolvedMutedForegroundColor,
      dangerColor: resolvedDangerColor,
      documentBackgroundColor:
          authTheme?.documentBackgroundColor ?? theme.scaffoldBackgroundColor,
      documentViewerBackgroundColor:
          authTheme?.documentViewerBackgroundColor ?? colorScheme.surface,
      documentLoaderColor: authTheme?.documentLoaderColor ??
          colorScheme.onSurface.withValues(alpha: 0.42),
    );
  }
}
