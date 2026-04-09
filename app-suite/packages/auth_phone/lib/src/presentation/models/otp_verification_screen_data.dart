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
}
