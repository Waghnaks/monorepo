import 'package:auth_phone/src/application/models/phone_auth_flow_state.dart';
import 'package:auth_phone/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:auth_phone/src/presentation/models/otp_verification_screen_data.dart';
import 'package:auth_phone/src/presentation/models/phone_auth_view_config.dart';
import 'package:auth_phone/src/presentation/models/phone_entry_screen_data.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:flutter/material.dart';

abstract final class PhoneAuthFlowViewDataFactory {
  static PhoneEntryScreenData createPhoneEntryScreenData(
    BuildContext context, {
    required PhoneAuthFlowState state,
    required PhoneAuthViewConfig config,
  }) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: config.themeColor,
    );

    return PhoneEntryScreenData(
      appName: config.appName,
      tagLine: config.tagLine,
      title: config.title,
      subtitle: config.subtitle,
      initialCountry: config.initialCountry,
      hintText: config.hintText,
      enabled: !state.isSendingOtp && !state.isResendingOtp,
      showCountryPicker: true,
      themeColor: resolvedTheme.accentColor,
      phoneErrorMessage: state.phoneErrorMessage,
      errorColor: resolvedTheme.dangerColor,
      actionButtonTitle: state.isSendingOtp
          ? PhoneAuthCopyDefaults.sendingOtpButtonTitle
          : config.actionButtonTitle,
      showActionButton: true,
      actionButtonBackgroundColor:
          config.themeColor != null ? resolvedTheme.accentColor : null,
      actionButtonForegroundColor:
          config.themeColor != null ? resolvedTheme.onAccentColor : null,
      actionButtonBorderRadius: config.actionButtonBorderRadius,
      actionButtonSpacing: config.actionButtonSpacing,
      actionButtonMinHeight: config.actionButtonMinHeight,
      isActionButtonLoading: state.isSendingOtp,
      isActionButtonDisabled: !state.isPhoneNumberReady ||
          state.isSendingOtp ||
          state.isResendingOtp,
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
      appBarTitle: config.appName,
      otpTitle: config.otpTitle,
      phoneLabel: state.phoneLabel,
      themeColor: resolvedTheme.accentColor,
      otpInputResetKey: state.otpInputResetKey,
      otpErrorMessage: state.otpErrorMessage,
      successMessage: state.successMessage,
      errorColor: resolvedTheme.dangerColor,
      successColor: resolvedTheme.accentColor,
      resendSecondsRemaining: state.resendSecondsRemaining,
      isResendingOtp: state.isResendingOtp,
      isVerifyingOtp: state.isVerifyingOtp,
      isVerifyButtonDisabled: !state.isOtpComplete || state.isVerifyingOtp,
      showActionButton: true,
      verifyButtonTitle: state.isVerifyingOtp
          ? PhoneAuthCopyDefaults.verifyingOtpButtonTitle
          : config.verifyButtonTitle,
      actionButtonBackgroundColor:
          config.themeColor != null ? resolvedTheme.accentColor : null,
      actionButtonForegroundColor:
          config.themeColor != null ? resolvedTheme.onAccentColor : null,
      actionButtonBorderRadius: config.actionButtonBorderRadius,
      actionButtonSpacing: config.actionButtonSpacing,
      actionButtonMinHeight: config.actionButtonMinHeight,
      isActionButtonLoading: state.isVerifyingOtp,
    );
  }
}
