import 'package:auth_phone/auth_phone.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

abstract final class PartnerPhoneAuthConfig {
  static const IsoCode initialCountry = IsoCode.IN;

  static const PhoneAuthApiConfig apiConfig = PhoneAuthApiConfig(
    sendOtpEndpoint: '/partner/auth/send-otp',
    verifyOtpEndpoint: '/partner/auth/verify-otp',
  );

  static const PhoneAuthLegalConfig legalConfig = PhoneAuthLegalConfig(
    termsOfUseUrl:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    privacyPolicyUrl:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
  );
}
