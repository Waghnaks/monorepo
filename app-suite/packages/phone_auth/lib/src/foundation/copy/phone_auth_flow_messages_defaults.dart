import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/application/models/phone_auth_flow_messages.dart';

PhoneAuthFlowMessages buildPhoneAuthFlowMessages() {
  return PhoneAuthFlowMessages(
    phoneNumberIncompleteMessage:
        PhoneAuthCopyDefaults.phoneNumberIncompleteMessage,
    sendOtpFailureMessage: PhoneAuthCopyDefaults.sendOtpFailureMessage,
    resendOtpFailureMessage: PhoneAuthCopyDefaults.resendOtpFailureMessage,
    otpIncompleteMessage: PhoneAuthCopyDefaults.otpIncompleteMessage,
    invalidOtpMessage: PhoneAuthCopyDefaults.invalidOtpMessage,
    verifyOtpFailureMessage: PhoneAuthCopyDefaults.verifyOtpFailureMessage,
    invalidPhoneNumberMessageBuilder:
        PhoneAuthCopyDefaults.invalidPhoneNumberMessage,
    verificationSuccessMessageBuilder: ({
      required String phoneNumber,
      required String sessionId,
    }) {
      return PhoneAuthCopyDefaults.verificationSuccessMessage(
        phoneNumber: phoneNumber,
        sessionId: sessionId,
      );
    },
  );
}
