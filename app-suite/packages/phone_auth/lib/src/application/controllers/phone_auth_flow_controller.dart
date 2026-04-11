import 'dart:async';

import 'package:phone_auth/src/application/models/phone_auth_flow_state.dart';
import 'package:phone_auth/src/application/models/phone_auth_flow_messages.dart';
import 'package:phone_auth/src/domain/models/phone_auth_session.dart';
import 'package:phone_auth/src/domain/models/phone_country.dart';
import 'package:phone_auth/src/domain/models/phone_number_result.dart';
import 'package:phone_auth/src/domain/usecases/send_phone_otp.dart';
import 'package:phone_auth/src/domain/usecases/verify_phone_otp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneAuthFlowController extends StateNotifier<PhoneAuthFlowState> {
  /// Owns the async phone-auth lifecycle: send OTP, resend, verify, and reset
  /// transient state when the flow returns to the phone page.
  PhoneAuthFlowController({
    required SendPhoneOtp sendPhoneOtp,
    required VerifyPhoneOtp verifyPhoneOtp,
    required PhoneAuthFlowMessages messages,
    required int resendIntervalSeconds,
    required int otpLength,
  })  : _sendPhoneOtp = sendPhoneOtp,
        _verifyPhoneOtp = verifyPhoneOtp,
        _messages = messages,
        _resendIntervalSeconds = resendIntervalSeconds,
        _otpLength = otpLength,
        super(const PhoneAuthFlowState());

  final SendPhoneOtp _sendPhoneOtp;
  final VerifyPhoneOtp _verifyPhoneOtp;
  final PhoneAuthFlowMessages _messages;
  final int _resendIntervalSeconds;
  final int _otpLength;

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
        phoneErrorMessage: _messages.phoneNumberIncompleteMessage,
      );
      return false;
    }

    if (!state.isPhoneNumberReady) {
      state = state.copyWith(
        phoneErrorMessage: result.validationMessage ??
            _messages.invalidPhoneNumberMessage(
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
        otpCode: '',
        otpInputResetKey: state.otpInputResetKey + 1,
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        phoneErrorMessage: isResend
            ? state.phoneErrorMessage
            : _messages.sendOtpFailureMessage,
        otpErrorMessage: isResend
            ? _messages.resendOtpFailureMessage
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
    if (session?.verificationId == null || !state.hasCompleteOtp(_otpLength)) {
      state = state.copyWith(
        otpErrorMessage: _messages.otpIncompleteMessage,
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
          successMessage: _messages.verificationSuccessMessage(
            phoneNumber: verifiedSession.phoneNumber,
            sessionId: verifiedSession.verificationId ?? 'N/A',
          ),
        );
        return verifiedSession;
      }

      state = state.copyWith(
        otpErrorMessage: _messages.invalidOtpMessage,
      );
      return null;
    } catch (_) {
      state = state.copyWith(
        otpErrorMessage: _messages.verifyOtpFailureMessage,
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
      otpCode: '',
      otpErrorMessage: null,
      successMessage: null,
      otpInputResetKey: state.otpInputResetKey + 1,
      resendSecondsRemaining: 0,
    );
  }

  void stopResendTimer() {
    _resendTimer?.cancel();
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
