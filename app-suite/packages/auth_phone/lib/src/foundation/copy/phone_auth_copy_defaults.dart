import 'package:auth_phone/src/domain/validation/phone_number_validation_result.dart';

abstract final class PhoneAuthCopyDefaults {
  static const String phoneTitle = 'Enter your mobile number';
  static const String phoneSubtitle =
      'We will send a one-time password to verify your number.';
  static const String otpTitle = 'Enter the OTP';
  static const String otpMessage = 'We sent a 6-digit code to';
  static const String phoneFieldHintText = 'Enter your mobile number';
  static const String sendOtpButtonTitle = 'Proceed';
  static const String resendLabel = 'Resend SMS';
  static const String countryPickerTitle = 'Select country';
  static const String countryPickerSearchHint = 'Country name or dial code';
  static const String countryPickerEmptyState = 'No countries found';
  static const String phoneNumberIncompleteMessage =
      'Enter a complete phone number to continue.';
  static const String sendOtpFailureMessage =
      'We could not send the OTP right now. Please try again.';
  static const String resendOtpFailureMessage =
      'We could not resend the OTP right now.';
  static const String otpIncompleteMessage =
      'Enter the complete OTP to continue.';
  static const String invalidOtpMessage =
      'The OTP you entered is incorrect. Try again.';
  static const String verifyOtpFailureMessage =
      'We could not verify the OTP right now.';

  static String invalidPhoneNumberMessage(String countryName) {
    return 'The number you entered does not seem correct for $countryName.';
  }

  static String verificationSuccessMessage({
    required String phoneNumber,
    required String sessionId,
  }) {
    return 'Okay, $phoneNumber verified. Session ID: $sessionId';
  }

  static String phoneNumberValidationMessage({
    required String countryName,
    required PhoneNumberValidationFailure failure,
  }) {
    switch (failure) {
      case PhoneNumberValidationFailure.unsupportedPattern:
      case PhoneNumberValidationFailure.repeatedDigits:
      case PhoneNumberValidationFailure.sequentialDigits:
        return invalidPhoneNumberMessage(countryName);
    }
  }
}
