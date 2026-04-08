import 'dart:async';

import 'package:auth_phone/src/application/models/phone_auth_flow_state.dart';
import 'package:auth_phone/src/domain/models/phone_auth_session.dart';
import 'package:auth_phone/src/domain/models/phone_country.dart';
import 'package:auth_phone/src/domain/models/phone_number_result.dart';
import 'package:auth_phone/src/domain/usecases/send_phone_otp.dart';
import 'package:auth_phone/src/domain/usecases/verify_phone_otp.dart';
import 'package:auth_phone/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneAuthFlowController extends StateNotifier<PhoneAuthFlowState> {
  PhoneAuthFlowController({
    required SendPhoneOtp sendPhoneOtp,
    required VerifyPhoneOtp verifyPhoneOtp,
    required int resendIntervalSeconds,
  })  : _sendPhoneOtp = sendPhoneOtp,
        _verifyPhoneOtp = verifyPhoneOtp,
        _resendIntervalSeconds = resendIntervalSeconds,
        super(const PhoneAuthFlowState());

  final SendPhoneOtp _sendPhoneOtp;
  final VerifyPhoneOtp _verifyPhoneOtp;
  final int _resendIntervalSeconds;

  Timer? _resendTimer;

  void handlePhoneNumberChanged(PhoneNumberResult result) {
    state = state.copyWith(
      phoneNumberResult: result,
      phoneErrorMessage: null,
    );
  }

  void handlePhoneNumberSubmitted(PhoneNumberResult result) {
    state = state.copyWith(phoneNumberResult: result);
  }

  Future<bool> sendOtp({bool isResend = false}) async {
    final result = state.phoneNumberResult;
    if (result == null || !state.hasCompletePhoneNumber) {
      state = state.copyWith(
        phoneErrorMessage: PhoneAuthCopyDefaults.phoneNumberIncompleteMessage,
      );
      return false;
    }

    if (!state.isPhoneNumberReady) {
      state = state.copyWith(
        phoneErrorMessage: result.validationMessage ??
            PhoneAuthCopyDefaults.invalidPhoneNumberMessage(
              phoneCountryByIso(result.isoCode).name,
            ),
      );
      return false;
    }

    state = state.copyWith(
      phoneErrorMessage: null,
      otpErrorMessage: null,
      successMessage: null,
      isSendingOtp: !isResend,
      isResendingOtp: isResend,
    );

    try {
      final session = await _sendPhoneOtp(result.completeNumber);
      _startResendTimer();

      state = state.copyWith(
        phoneAuthSession: session,
        currentStep: PhoneAuthFlowStep.otpCode,
        otpCode: '',
        otpInputResetKey: state.otpInputResetKey + 1,
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        phoneErrorMessage:
            isResend || state.currentStep == PhoneAuthFlowStep.otpCode
                ? state.phoneErrorMessage
                : PhoneAuthCopyDefaults.sendOtpFailureMessage,
        otpErrorMessage:
            isResend || state.currentStep == PhoneAuthFlowStep.otpCode
                ? PhoneAuthCopyDefaults.resendOtpFailureMessage
                : state.otpErrorMessage,
      );
      return false;
    } finally {
      state = state.copyWith(
        isSendingOtp: false,
        isResendingOtp: false,
      );
    }
  }

  Future<PhoneAuthSession?> verifyOtp() async {
    final session = state.phoneAuthSession;
    if (session?.verificationId == null || !state.isOtpComplete) {
      state = state.copyWith(
        otpErrorMessage: PhoneAuthCopyDefaults.otpIncompleteMessage,
      );
      return null;
    }

    state = state.copyWith(
      otpErrorMessage: null,
      successMessage: null,
      isVerifyingOtp: true,
    );

    try {
      final verifiedSession = await _verifyPhoneOtp(
        verificationId: session!.verificationId!,
        otpCode: state.otpCode,
      );

      if (verifiedSession.isVerified) {
        state = state.copyWith(
          successMessage: PhoneAuthCopyDefaults.verificationSuccessMessage(
            phoneNumber: verifiedSession.phoneNumber,
            sessionId: verifiedSession.verificationId ?? 'N/A',
          ),
        );
        return verifiedSession;
      }

      state = state.copyWith(
        otpErrorMessage: PhoneAuthCopyDefaults.invalidOtpMessage,
      );
      return null;
    } catch (_) {
      state = state.copyWith(
        otpErrorMessage: PhoneAuthCopyDefaults.verifyOtpFailureMessage,
      );
      return null;
    } finally {
      state = state.copyWith(isVerifyingOtp: false);
    }
  }

  void handleOtpChanged(String code) {
    state = state.copyWith(
      otpCode: code,
      otpErrorMessage: null,
      successMessage: null,
    );
  }

  void goBackToPhoneStep() {
    _resendTimer?.cancel();
    state = state.copyWith(
      currentStep: PhoneAuthFlowStep.phoneNumber,
      otpCode: '',
      otpErrorMessage: null,
      successMessage: null,
      otpInputResetKey: state.otpInputResetKey + 1,
      resendSecondsRemaining: 0,
    );
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    state = state.copyWith(resendSecondsRemaining: _resendIntervalSeconds);

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsRemaining = state.resendSecondsRemaining;

      if (secondsRemaining <= 1) {
        timer.cancel();
        state = state.copyWith(resendSecondsRemaining: 0);
        return;
      }

      state = state.copyWith(
        resendSecondsRemaining: secondsRemaining - 1,
      );
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
}
