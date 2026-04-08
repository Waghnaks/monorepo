class PhoneAuthLegalConfig {
  const PhoneAuthLegalConfig({
    required this.termsOfUseUrl,
    required this.privacyPolicyUrl,
    this.termsOfUseTitle = 'Terms of Use',
    this.privacyPolicyTitle = 'Privacy Policy',
  });

  final String termsOfUseUrl;
  final String privacyPolicyUrl;
  final String termsOfUseTitle;
  final String privacyPolicyTitle;

  bool get hasTermsOfUse => termsOfUseUrl.trim().isNotEmpty;
  bool get hasPrivacyPolicy => privacyPolicyUrl.trim().isNotEmpty;
  bool get hasAnyLink => hasTermsOfUse || hasPrivacyPolicy;
}
