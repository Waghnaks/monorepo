import 'package:flutter/material.dart';
import 'package:auth_phone/auth_phone.dart';

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
          // Used by PhoneEntryScreen for the large app name shown at the
          // top of the branded phone auth entry experience.
          brandTextStyle: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            letterSpacing: -1.15,
            height: 0.98,
          ),
          // Used by PhoneEntryScreen directly under the app name as the
          // supporting brand tag line.
          tagLineTextStyle: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            height: 1.35,
            color: AppColors.textNeutral,
          ),
          // Used by PhoneEntryScreen and OtpVerificationScreen for primary
          // screen titles such as "Enter your mobile number" and "Enter the OTP".
          headingTextStyle: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.45,
            color: colorScheme.onSurface,
          ),
          supportingTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.45,
            color: colorScheme.onSurface.withValues(alpha: 0.70),
          ),
          // Used by OtpVerificationScreen for the resend SMS action and
          // future inline text actions that should feel tappable but subtle.
          actionTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.35,
            letterSpacing: 0.08,
            color: AppColors.textSecondary,
          ),
          // Used by PhoneNumberInputField for the dial code and future leading
          // inline values inside form inputs.
          leadingValueTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.1,
            color: AppColors.textStrong,
          ),
          // Used by PhoneNumberInputField labels for reusable form sections.
          inputLabelTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.08,
            color: AppColors.textSecondary,
          ),
          // Used by PhoneNumberInputField and future shared inputs for entered values.
          inputTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: AppColors.textStrong,
          ),
          // Used by PhoneNumberInputField and search-style controls for placeholder text.
          inputHintTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
          // Used by PhoneAuthLegalNotice for the smaller acknowledgement
          // sentence above the Terms of Use and Privacy Policy links.
          legalTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.40,
            color: AppColors.textMuted,
          ),
          // Used by PhoneAuthLegalNotice for the clickable legal links on
          // the second line below the acknowledgement copy.
          legalLinkTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.45,
            color: AppColors.textStrong,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textStrong,
          ),
          // Used by PhoneAuthDocumentScreen and OtpVerificationScreen app-bar
          // titles when a compact top title is needed.
          documentTitleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.3,
          ),
          // Used by OtpVerificationScreen currently, and reusable anywhere a
          // stronger accent-colored title is needed.
          accentTitleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.35,
          ),
          surfaceMutedColor: AppColors.surfaceMuted,
          outlineColor: AppColors.borderSubtle,
          mutedForegroundColor: AppColors.textSecondary,
          dangerColor: AppColors.error,
          documentViewerBackgroundColor: AppColors.surface,
          documentBackgroundColor: AppColors.surface,
          documentLoaderColor: AppColors.loadingIndicator,
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
