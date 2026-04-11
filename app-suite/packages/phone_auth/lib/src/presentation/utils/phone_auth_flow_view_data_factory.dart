import 'package:phone_auth/src/application/models/phone_auth_flow_state.dart';
import 'package:phone_auth/src/presentation/models/otp_verification_screen_data.dart';
import 'package:phone_auth/src/presentation/models/phone_auth_view_config.dart';
import 'package:phone_auth/src/presentation/models/phone_number_input_screen_data.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/utils/phone_auth_phone_label_formatter.dart';
import 'package:flutter/material.dart';

abstract final class PhoneAuthFlowViewDataFactory {
  static PhoneNumberInputScreenData buildPhoneNumberInputScreenData(
    BuildContext context, {
    required PhoneAuthFlowState state,
    required PhoneAuthViewConfig config,
    bool isTransitioningToOtp = false,
  }) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: config.themeColor,
    );

    return PhoneNumberInputScreenData(
      appName: config.appName,
      tagLine: config.tagLine,
      userPhoneAuth: config.userPhoneAuth,
      title: config.title,
      subtitle: config.subtitle,
      initialCountry: config.initialCountry,
      hintText: config.hintText,
      enabled:
          !state.isSendingOtp && !state.isResendingOtp && !isTransitioningToOtp,
      showCountryPicker: true,
      themeColor: resolvedTheme.accentColor,
      phoneErrorMessage: state.phoneErrorMessage,
      errorColor: resolvedTheme.dangerColor,
      actionButtonTitle: config.actionButtonTitle,
      actionButtonBackgroundColor:
          config.themeColor != null ? resolvedTheme.accentColor : null,
      actionButtonForegroundColor:
          config.themeColor != null ? resolvedTheme.onAccentColor : null,
      actionButtonBorderRadius: config.actionButtonBorderRadius,
      actionButtonSpacing: config.actionButtonSpacing,
      actionButtonMinHeight: config.actionButtonMinHeight,
      isActionButtonLoading: isTransitioningToOtp || state.isSendingOtp,
      isActionButtonDisabled: !state.isPhoneNumberReady || isTransitioningToOtp,
      isInteractionLocked: isTransitioningToOtp || state.isSendingOtp,
      legalConfig: config.legalConfig,
    );
  }

  static OtpVerificationScreenData createOtpVerificationScreenData(
    BuildContext context, {
    required PhoneAuthFlowState state,
    required PhoneAuthViewConfig config,
  }) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: config.themeColor,
    );

    return OtpVerificationScreenData(
      userPhoneAuth: config.userPhoneAuth,
      appBarTitle: config.userPhoneAuth ? config.appName : null,
      otpTitle: config.otpTitle,
      phoneLabel: formatOtpPhoneLabel(state),
      themeColor: resolvedTheme.accentColor,
      otpInputResetKey: state.otpInputResetKey,
      otpErrorMessage: state.otpErrorMessage,
      successMessage: state.successMessage,
      errorColor: resolvedTheme.dangerColor,
      successColor: resolvedTheme.accentColor,
      resendSecondsRemaining: state.resendSecondsRemaining,
      isResendingOtp: state.isResendingOtp,
      isVerifyingOtp: state.isVerifyingOtp,
    );
  }
}
