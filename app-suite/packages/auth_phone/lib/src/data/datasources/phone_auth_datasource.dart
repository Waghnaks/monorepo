import 'dart:math';

import 'package:auth_phone/src/domain/models/phone_auth_api_config.dart';
import 'package:flutter/foundation.dart';

class PhoneAuthDataSource {
  const PhoneAuthDataSource({
    this.apiConfig = const PhoneAuthApiConfig(),
  });

  final PhoneAuthApiConfig apiConfig;

  static final Random _random = Random();
  static final Map<String, String> _otpCodesByVerificationId = <String, String>{};
  static final Map<String, String> _phoneNumbersByVerificationId =
      <String, String>{};

  Future<String> requestOtp(String phoneNumber) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    debugPrint('PhoneAuth send OTP endpoint: ${apiConfig.sendOtpEndpoint}');

    if (phoneNumber.trim().isEmpty) {
      debugPrint('PhoneAuth send OTP failed: empty phone number');
      throw Exception('Unable to send OTP right now.');
    }

    final verificationId =
        '${DateTime.now().millisecondsSinceEpoch}${_random.nextInt(9999)}';
    final otpCode = (_random.nextInt(900000) + 100000).toString();

    _otpCodesByVerificationId[verificationId] = otpCode;
    _phoneNumbersByVerificationId[verificationId] = phoneNumber;

    debugPrint('PhoneAuth generated OTP for $phoneNumber: $otpCode');
    debugPrint('PhoneAuth send OTP success for $phoneNumber');

    return verificationId;
  }

  Future<bool> confirmOtp({
    required String verificationId,
    required String otpCode,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    debugPrint('PhoneAuth verify OTP endpoint: ${apiConfig.verifyOtpEndpoint}');

    final expectedOtp = _otpCodesByVerificationId[verificationId];
    final isValid = expectedOtp != null && expectedOtp == otpCode;

    if (isValid) {
      debugPrint('PhoneAuth verify OTP success for $verificationId');
    } else {
      debugPrint('PhoneAuth verify OTP failed for $verificationId');
    }

    return isValid;
  }

  String? phoneNumberForVerification(String verificationId) {
    return _phoneNumbersByVerificationId[verificationId];
  }
}
