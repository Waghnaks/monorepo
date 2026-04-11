import 'package:phone_auth/src/domain/validation/phone_number_validation_result.dart';

abstract final class PhoneAuthCopyDefaults {
  /// UI usage: welcome header on the new-user phone screen in
  /// `phone_number_input_screen.dart`.
  static const String welcomePrefix = 'Welcome to';

  /// UI usage: fallback phone screen header when no app branding is passed.
  static const String phoneTitle = 'Enter your mobile number';

  /// UI usage: fallback supporting copy below the fallback phone title.
  static const String phoneSubtitle =
      'We will send a one-time password to verify your number.';

  /// UI usage: OTP page title in `otp_verification_screen.dart`.
  static const String otpTitle = 'Enter the OTP';

  /// UI usage: helper copy above the verified phone chip on the OTP screen.
  static const String otpMessage = 'We sent a 6-digit code to';

  /// UI usage: phone field placeholder passed from the package root widget.
  static const String phoneFieldHintText = 'Enter your mobile number';

  /// Code usage: fallback hint for `PhoneNumberInputField` when no hint is
  /// supplied directly by a screen or config.
  static const String phoneFieldFallbackHintText = 'Phone number';

  /// UI usage: centered prompt above the new-user phone input block in
  /// `phone_number_input_screen.dart`.
  static const String newUserPhoneInputPrompt =
      'Log in with your registered mobile number';

  /// UI usage: primary action title on the phone number screen.
  static const String sendOtpButtonTitle = 'Proceed';

  /// UI usage: resend action label on the OTP screen.
  static const String resendLabel = 'Resend SMS';

  /// UI usage: country picker title in `phone_country_picker_bottom_sheet.dart`.
  static const String countryPickerTitle = 'Select country';

  /// UI usage: country search placeholder in the country picker bottom sheet.
  static const String countryPickerSearchHint = 'Country name or dial code';

  /// UI usage: empty state text when the country search has no results.
  static const String countryPickerEmptyState = 'No countries found';

  /// UI usage: inline error below the phone field for incomplete numbers.
  static const String phoneNumberIncompleteMessage =
      'Enter a complete phone number to continue.';

  /// UI usage: inline error shown when OTP send fails.
  static const String sendOtpFailureMessage =
      'We could not send the OTP right now. Please try again.';

  /// UI usage: inline error shown when resend fails on the OTP screen.
  static const String resendOtpFailureMessage =
      'We could not resend the OTP right now.';

  /// UI usage: inline error below the OTP field when code is incomplete.
  static const String otpIncompleteMessage =
      'Enter the complete OTP to continue.';

  /// UI usage: inline error shown when OTP verification fails due to invalid
  /// code entry.
  static const String invalidOtpMessage =
      'The OTP you entered is incorrect. Try again.';

  /// UI usage: inline error shown when OTP verification fails generically.
  static const String verifyOtpFailureMessage =
      'We could not verify the OTP right now.';

  /// Code usage: fallback exception text thrown by the datasource when OTP send
  /// cannot continue.
  static const String sendOtpUnavailableExceptionMessage =
      'Unable to send OTP right now.';

  /// UI usage: inline OTP resend countdown text in `otp_verification_screen.dart`.
  static String resendCountdownLabel(int secondsRemaining) {
    return '$resendLabel in ${secondsRemaining}s';
  }

  /// UI usage: phone validation feedback for country-specific invalid input.
  static String invalidPhoneNumberMessage(String countryName) {
    return 'The number you entered does not seem correct for $countryName.';
  }

  /// Code usage: success message composed by the controller after verification.
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
