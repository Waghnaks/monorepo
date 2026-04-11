import 'package:phone_auth/src/domain/models/phone_auth_session.dart';
import 'package:phone_auth/src/domain/models/phone_number_result.dart';
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

  bool hasCompleteOtp(int otpLength) => otpCode.length == otpLength;

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

  String get submittedPhoneNumber {
    final sessionPhoneNumber = phoneAuthSession?.phoneNumber;
    if (sessionPhoneNumber != null && sessionPhoneNumber.isNotEmpty) {
      return sessionPhoneNumber;
    }

    final result = phoneNumberResult;
    if (result == null) {
      return '';
    }

    return result.completeNumber;
  }
}
