import 'package:phone_auth/src/domain/models/phone_auth_legal_config.dart';
import 'package:phone_auth/src/domain/models/phone_auth_session.dart';
import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneAuthViewConfig {
  const PhoneAuthViewConfig({
    this.appName,
    this.tagLine,
    required this.userPhoneAuth,
    required this.title,
    required this.subtitle,
    required this.otpTitle,
    required this.initialCountry,
    required this.hintText,
    required this.themeColor,
    required this.actionButtonTitle,
    required this.legalConfig,
    required this.onVerificationSuccess,
    required this.actionButtonBorderRadius,
    required this.actionButtonSpacing,
    required this.actionButtonMinHeight,
  });

  final String? appName;
  final String? tagLine;
  final bool userPhoneAuth;
  final String title;
  final String subtitle;
  final String otpTitle;
  final IsoCode initialCountry;
  final String hintText;
  final Color? themeColor;
  final String actionButtonTitle;
  final PhoneAuthLegalConfig? legalConfig;
  final ValueChanged<PhoneAuthSession>? onVerificationSuccess;
  final double actionButtonBorderRadius;
  final double actionButtonSpacing;
  final double actionButtonMinHeight;
}
