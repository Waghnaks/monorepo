import 'package:flutter/material.dart';
import 'package:phone_auth/src/domain/models/phone_auth_api_config.dart';
import 'package:phone_auth/src/domain/models/phone_auth_legal_config.dart';
import 'package:phone_auth/src/domain/models/phone_auth_session.dart';
import 'package:phone_auth/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

@immutable
class PhoneAuthConfig {
  const PhoneAuthConfig({
    this.appName,
    this.tagLine,
    this.userPhoneAuth = false,
    this.themeColor,
    this.initialCountry = IsoCode.IN,
    this.apiConfig = const PhoneAuthApiConfig(),
    this.legalConfig,
    this.onVerificationSuccess,
    this.resendIntervalSeconds = PhoneAuthLayoutDefaults.resendIntervalSeconds,
  });

  final String? appName;
  final String? tagLine;
  final bool userPhoneAuth;
  final Color? themeColor;
  final IsoCode initialCountry;
  final PhoneAuthApiConfig apiConfig;
  final PhoneAuthLegalConfig? legalConfig;
  final ValueChanged<PhoneAuthSession>? onVerificationSuccess;
  final int resendIntervalSeconds;

  PhoneAuthConfig copyWith({
    String? appName,
    String? tagLine,
    bool? userPhoneAuth,
    Color? themeColor,
    IsoCode? initialCountry,
    PhoneAuthApiConfig? apiConfig,
    PhoneAuthLegalConfig? legalConfig,
    ValueChanged<PhoneAuthSession>? onVerificationSuccess,
    int? resendIntervalSeconds,
  }) {
    return PhoneAuthConfig(
      appName: appName ?? this.appName,
      tagLine: tagLine ?? this.tagLine,
      userPhoneAuth: userPhoneAuth ?? this.userPhoneAuth,
      themeColor: themeColor ?? this.themeColor,
      initialCountry: initialCountry ?? this.initialCountry,
      apiConfig: apiConfig ?? this.apiConfig,
      legalConfig: legalConfig ?? this.legalConfig,
      onVerificationSuccess:
          onVerificationSuccess ?? this.onVerificationSuccess,
      resendIntervalSeconds:
          resendIntervalSeconds ?? this.resendIntervalSeconds,
    );
  }
}
