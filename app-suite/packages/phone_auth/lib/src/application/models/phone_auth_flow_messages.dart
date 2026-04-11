class PhoneAuthFlowMessages {
  PhoneAuthFlowMessages({
    required this.phoneNumberIncompleteMessage,
    required this.sendOtpFailureMessage,
    required this.resendOtpFailureMessage,
    required this.otpIncompleteMessage,
    required this.invalidOtpMessage,
    required this.verifyOtpFailureMessage,
    required this.invalidPhoneNumberMessageBuilder,
    required this.verificationSuccessMessageBuilder,
  });

  final String phoneNumberIncompleteMessage;
  final String sendOtpFailureMessage;
  final String resendOtpFailureMessage;
  final String otpIncompleteMessage;
  final String invalidOtpMessage;
  final String verifyOtpFailureMessage;
  final String Function(String countryName) invalidPhoneNumberMessageBuilder;
  final String Function({
    required String phoneNumber,
    required String sessionId,
  }) verificationSuccessMessageBuilder;

  factory PhoneAuthFlowMessages.fallback() {
    return PhoneAuthFlowMessages(
      phoneNumberIncompleteMessage:
          'Enter a complete phone number to continue.',
      sendOtpFailureMessage:
          'We could not send the OTP right now. Please try again.',
      resendOtpFailureMessage: 'We could not resend the OTP right now.',
      otpIncompleteMessage: 'Enter the complete OTP to continue.',
      invalidOtpMessage: 'The OTP you entered is incorrect. Try again.',
      verifyOtpFailureMessage:
          'We could not verify the OTP right now. Please try again.',
      invalidPhoneNumberMessageBuilder: (countryName) {
        return 'The number you entered does not seem correct for $countryName.';
      },
      verificationSuccessMessageBuilder: ({
        required String phoneNumber,
        required String sessionId,
      }) {
        return 'Okay, $phoneNumber verified. Session ID: $sessionId';
      },
    );
  }

  String invalidPhoneNumberMessage(String countryName) {
    return invalidPhoneNumberMessageBuilder(countryName);
  }

  String verificationSuccessMessage({
    required String phoneNumber,
    required String sessionId,
  }) {
    return verificationSuccessMessageBuilder(
      phoneNumber: phoneNumber,
      sessionId: sessionId,
    );
  }
}
