import 'package:phone_auth/phone_auth.dart';

import 'app_info.dart';

abstract final class PartnerPhoneAuthConfig {
  static const PhoneAuthConfig config = PhoneAuthConfig(
    appName: AppInfo.brandName,
    // tagLine: AppInfo.tagLine,
    apiConfig: PhoneAuthApiConfig(
      sendOtpEndpoint: '/partner/auth/send-otp',
      verifyOtpEndpoint: '/partner/auth/verify-otp',
    ),
    legalConfig: PhoneAuthLegalConfig(
      termsOfUseUrl:
          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      privacyPolicyUrl:
          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    ),
  );
}
