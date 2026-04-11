abstract final class PhoneAuthLogDefaults {
  /// Code usage: debug log emitted before the mock/send datasource flow starts.
  static String sendOtpEndpoint(String endpoint) {
    return 'PhoneAuth send OTP endpoint: $endpoint';
  }

  /// Code usage: debug log emitted when send OTP is called with an empty number.
  static const String sendOtpEmptyPhoneNumber =
      'PhoneAuth send OTP failed: empty phone number';

  /// Code usage: debug log emitted after generating a mock OTP for local flow.
  static String generatedOtp({
    required String phoneNumber,
    required String otpCode,
  }) {
    return 'PhoneAuth generated OTP for $phoneNumber: $otpCode';
  }

  /// Code usage: debug log emitted when send OTP completes successfully.
  static String sendOtpSuccess(String phoneNumber) {
    return 'PhoneAuth send OTP success for $phoneNumber';
  }

  /// Code usage: debug log emitted before OTP verification begins.
  static String verifyOtpEndpoint(String endpoint) {
    return 'PhoneAuth verify OTP endpoint: $endpoint';
  }

  /// Code usage: debug log emitted when OTP verification succeeds.
  static String verifyOtpSuccess(String verificationId) {
    return 'PhoneAuth verify OTP success for $verificationId';
  }

  /// Code usage: debug log emitted when OTP verification fails.
  static String verifyOtpFailure(String verificationId) {
    return 'PhoneAuth verify OTP failed for $verificationId';
  }
}
