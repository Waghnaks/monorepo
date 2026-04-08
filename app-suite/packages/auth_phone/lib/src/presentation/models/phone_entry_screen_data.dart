import 'package:auth_phone/src/domain/models/phone_auth_legal_config.dart';
import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

@immutable
class PhoneEntryScreenData {
  const PhoneEntryScreenData({
    this.appName,
    this.tagLine,
    required this.title,
    required this.subtitle,
    required this.initialCountry,
    required this.hintText,
    required this.enabled,
    required this.showCountryPicker,
    required this.themeColor,
    required this.phoneErrorMessage,
    required this.errorColor,
    required this.actionButtonTitle,
    required this.showActionButton,
    required this.actionButtonBackgroundColor,
    required this.actionButtonForegroundColor,
    required this.actionButtonBorderRadius,
    required this.actionButtonSpacing,
    required this.actionButtonMinHeight,
    required this.isActionButtonLoading,
    required this.isActionButtonDisabled,
    this.legalConfig,
  });

  final String? appName;
  final String? tagLine;
  final String title;
  final String subtitle;
  final IsoCode initialCountry;
  final String hintText;
  final bool enabled;
  final bool showCountryPicker;
  final Color themeColor;
  final String? phoneErrorMessage;
  final Color errorColor;
  final String actionButtonTitle;
  final bool showActionButton;
  final Color? actionButtonBackgroundColor;
  final Color? actionButtonForegroundColor;
  final double actionButtonBorderRadius;
  final double actionButtonSpacing;
  final double actionButtonMinHeight;
  final bool isActionButtonLoading;
  final bool isActionButtonDisabled;
  final PhoneAuthLegalConfig? legalConfig;
}
