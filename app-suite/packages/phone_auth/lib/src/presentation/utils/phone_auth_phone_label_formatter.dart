import 'package:phone_auth/src/application/models/phone_auth_flow_state.dart';

String formatOtpPhoneLabel(PhoneAuthFlowState state) {
  final submittedPhoneNumber = state.submittedPhoneNumber;
  final result = state.phoneNumberResult;

  if (submittedPhoneNumber.isNotEmpty) {
    final dialCode = result?.dialCode;
    if (dialCode != null &&
        dialCode.isNotEmpty &&
        submittedPhoneNumber.startsWith(dialCode)) {
      final nationalNumber = submittedPhoneNumber.substring(dialCode.length);
      if (nationalNumber.isNotEmpty) {
        return '$dialCode $nationalNumber';
      }
    }

    return submittedPhoneNumber;
  }

  if (result == null) {
    return '';
  }

  if (result.nationalNumber.isEmpty) {
    return result.dialCode;
  }

  return '${result.dialCode} ${result.nationalNumber}';
}
