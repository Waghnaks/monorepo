import 'dart:math';

import 'package:phone_auth/src/domain/models/phone_auth_api_config.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/foundation/debug/phone_auth_log_defaults.dart';
import 'package:flutter/foundation.dart';

class PhoneAuthDataSource {
  const PhoneAuthDataSource({
    this.apiConfig = const PhoneAuthApiConfig(),
    this.otpLength = 6,
  });

  final PhoneAuthApiConfig apiConfig;
  final int otpLength;

  static final Random _random = Random();
  static final Map<String, String> _otpCodesByVerificationId =
      <String, String>{};
  static final Map<String, String> _phoneNumbersByVerificationId =
      <String, String>{};

  Future<String> requestOtp(String phoneNumber) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    debugPrint(PhoneAuthLogDefaults.sendOtpEndpoint(apiConfig.sendOtpEndpoint));

    if (phoneNumber.trim().isEmpty) {
      debugPrint(PhoneAuthLogDefaults.sendOtpEmptyPhoneNumber);
      throw Exception(PhoneAuthCopyDefaults.sendOtpUnavailableExceptionMessage);
    }

    final verificationId =
        '${DateTime.now().millisecondsSinceEpoch}${_random.nextInt(9999)}';
    final minimum = _powerOfTen(otpLength - 1);
    final otpCode = (_random.nextInt(9 * minimum) + minimum).toString().padLeft(
          otpLength,
          '0',
        );

    _otpCodesByVerificationId[verificationId] = otpCode;
    _phoneNumbersByVerificationId[verificationId] = phoneNumber;

    debugPrint(
      PhoneAuthLogDefaults.generatedOtp(
        phoneNumber: phoneNumber,
        otpCode: otpCode,
      ),
    );
    debugPrint(PhoneAuthLogDefaults.sendOtpSuccess(phoneNumber));

    return verificationId;
  }

  Future<bool> confirmOtp({
    required String verificationId,
    required String otpCode,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    debugPrint(
      PhoneAuthLogDefaults.verifyOtpEndpoint(apiConfig.verifyOtpEndpoint),
    );

    final expectedOtp = _otpCodesByVerificationId[verificationId];
    final isValid = expectedOtp != null && expectedOtp == otpCode;

    if (isValid) {
      debugPrint(PhoneAuthLogDefaults.verifyOtpSuccess(verificationId));
    } else {
      debugPrint(PhoneAuthLogDefaults.verifyOtpFailure(verificationId));
    }

    return isValid;
  }

  String? phoneNumberForVerification(String verificationId) {
    return _phoneNumbersByVerificationId[verificationId];
  }

  static int _powerOfTen(int exponent) {
    var result = 1;
    for (var index = 0; index < exponent; index++) {
      result *= 10;
    }
    return result;
  }
}
