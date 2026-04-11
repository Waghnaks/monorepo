import 'package:flutter/material.dart';
import 'package:phone_auth/phone_auth.dart';

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
      extensions: <ThemeExtension<dynamic>>[
        PhoneAuthThemeExtension(
          // Big brand title at the top of the phone page.
          brandTextStyle: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            letterSpacing: -1.15,
            height: 0.98,
          ),
          // Smaller line under the app name.
          tagLineTextStyle: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            height: 1.35,
            color: AppColors.textNeutral,
          ),
          // Main page titles like "Enter your mobile number" and OTP heading.
          headingTextStyle: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.45,
            color: colorScheme.onSurface,
          ),
          // Normal supporting text under titles and helper copy on auth pages.
          supportingTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.45,
            color: colorScheme.onSurface.withValues(alpha: 0.70),
          ),
          // Medium-emphasis body text.
          // You see this on the prompt above the phone input on the new-user
          // phone auth screen.
          bodyEmphasisTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.45,
            color: AppColors.textPrimary,
          ),
          // Small tappable text like "Resend SMS".
          actionTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.35,
            letterSpacing: 0.08,
            color: AppColors.textSecondary,
          ),
          // Used by both the ISD code and the typed phone number,
          // so the full input feels like one single value.
          valueTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
            color: AppColors.textPrimary,
          ),
          // Small label above inputs when a field label is shown.
          fieldLabelTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.08,
            color: AppColors.textSecondary,
          ),
          // Placeholder text inside fields and search inputs.
          fieldHintTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
          // Small legal/helper line above the links.
          legalTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.40,
            color: AppColors.textMuted,
          ),
          // Clickable legal links like Terms of Use and Privacy Policy.
          legalLinkTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.45,
            color: AppColors.textPrimary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textPrimary,
          ),
          // App bar title on document pages and similar compact headers.
          documentTitleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.3,
          ),
          // Strong colored title, currently used on the OTP page app bar.
          accentTitleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.35,
          ),
          surfaceMutedColor: AppColors.surfaceSubtle,
          outlineColor: AppColors.borderSubtle,
          mutedForegroundColor: AppColors.textSecondary,
          dangerColor: AppColors.error,
          documentViewerBackgroundColor: AppColors.surface,
          documentBackgroundColor: AppColors.surface,
          documentLoaderColor: AppColors.progress,
        ),
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
