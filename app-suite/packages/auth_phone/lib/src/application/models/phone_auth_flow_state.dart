import 'package:auth_phone/src/domain/models/phone_auth_session.dart';
import 'package:auth_phone/src/domain/models/phone_number_result.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_auth_flow_state.freezed.dart';

enum PhoneAuthFlowStep {
  phoneNumber,
  otpCode,
}

@freezed
class PhoneAuthFlowState with _$PhoneAuthFlowState {
  const factory PhoneAuthFlowState({
    @Default(PhoneAuthFlowStep.phoneNumber) PhoneAuthFlowStep currentStep,
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
    final result = phoneNumberResult;
    if (result == null) {
      return '';
    }

    return '${result.dialCode} ${result.nationalNumber}';
  }
}
