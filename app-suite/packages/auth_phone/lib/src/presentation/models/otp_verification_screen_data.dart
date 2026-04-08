import 'package:flutter/material.dart';

@immutable
class OtpVerificationScreenData {
  const OtpVerificationScreenData({
    required this.appBarTitle,
    required this.otpTitle,
    required this.phoneLabel,
    required this.themeColor,
    required this.otpInputResetKey,
    required this.otpErrorMessage,
    required this.successMessage,
    required this.errorColor,
    required this.successColor,
    required this.resendSecondsRemaining,
    required this.isResendingOtp,
    required this.isVerifyingOtp,
    required this.isVerifyButtonDisabled,
    required this.showActionButton,
    required this.verifyButtonTitle,
    required this.actionButtonBackgroundColor,
    required this.actionButtonForegroundColor,
    required this.actionButtonBorderRadius,
    required this.actionButtonSpacing,
    required this.actionButtonMinHeight,
    required this.isActionButtonLoading,
  });

  final String? appBarTitle;
  final String otpTitle;
  final String phoneLabel;
  final Color themeColor;
  final int otpInputResetKey;
  final String? otpErrorMessage;
  final String? successMessage;
  final Color errorColor;
  final Color successColor;
  final int resendSecondsRemaining;
  final bool isResendingOtp;
  final bool isVerifyingOtp;
  final bool isVerifyButtonDisabled;
  final bool showActionButton;
  final String verifyButtonTitle;
  final Color? actionButtonBackgroundColor;
  final Color? actionButtonForegroundColor;
  final double actionButtonBorderRadius;
  final double actionButtonSpacing;
  final double actionButtonMinHeight;
  final bool isActionButtonLoading;
}
