import 'package:auth_phone/src/domain/models/phone_auth_session.dart';
import 'package:auth_phone/src/domain/models/phone_number_result.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_auth_flow_state.freezed.dart';

@freezed
class PhoneAuthFlowState with _$PhoneAuthFlowState {
  /// Holds the live phone input, OTP request state, and verification result
  /// for the current auth session.
  const factory PhoneAuthFlowState({
    PhoneNumberResult? phoneNumberResult,
    PhoneAuthSession? phoneAuthSession,
    @Default(false) bool isSendingOtp,
    @Default(false) bool isResendingOtp,
    @Default(false) bool isVerifyingOtp,
    @Default('') String otpCode,
    String? phoneErrorMessage,
    String? otpErrorMessage,
    String? successMessage,
    @Default(0) int otpInputResetKey,
    @Default(0) int resendSecondsRemaining,
  }) = _PhoneAuthFlowState;

  const PhoneAuthFlowState._();

  bool get isOtpComplete => otpCode.length == PhoneAuthLayoutDefaults.otpLength;

  bool get hasCompletePhoneNumber {
    final result = phoneNumberResult;
    if (result == null) {
      return false;
    }

    return result.isComplete;
  }

  bool get isPhoneNumberReady {
    final result = phoneNumberResult;
    if (result == null) {
      return false;
    }

    return result.isValid;
  }

  String get phoneLabel {
    final sessionPhoneNumber = phoneAuthSession?.phoneNumber;
    final result = phoneNumberResult;

    if (sessionPhoneNumber != null && sessionPhoneNumber.isNotEmpty) {
      final dialCode = result?.dialCode;
      if (dialCode != null &&
          dialCode.isNotEmpty &&
          sessionPhoneNumber.startsWith(dialCode)) {
        final nationalNumber = sessionPhoneNumber.substring(dialCode.length);
        if (nationalNumber.isNotEmpty) {
          return '$dialCode $nationalNumber';
        }
      }

      return sessionPhoneNumber;
    }

    if (result == null) {
      return '';
    }

    return '${result.dialCode} ${result.nationalNumber}';
  }
}
