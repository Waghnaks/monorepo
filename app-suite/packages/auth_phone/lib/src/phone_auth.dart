import 'package:auth_phone/src/application/providers/auth_phone_providers.dart';
import 'package:auth_phone/src/domain/models/phone_auth_api_config.dart';
import 'package:auth_phone/src/domain/models/phone_auth_legal_config.dart';
import 'package:auth_phone/src/domain/models/phone_auth_session.dart';
import 'package:auth_phone/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:auth_phone/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:auth_phone/src/presentation/models/phone_auth_view_config.dart';
import 'package:auth_phone/src/presentation/screens/phone_auth_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({
    super.key,
    this.appName,
    this.tagLine,
    this.themeColor,
    this.initialCountry = IsoCode.IN,
    this.apiConfig = const PhoneAuthApiConfig(),
    this.legalConfig,
    this.onVerificationSuccess,
    this.resendIntervalSeconds = PhoneAuthLayoutDefaults.resendIntervalSeconds,
  });

  final String? appName;
  final String? tagLine;
  final Color? themeColor;
  final IsoCode initialCountry;
  final PhoneAuthApiConfig apiConfig;
  final PhoneAuthLegalConfig? legalConfig;
  final ValueChanged<PhoneAuthSession>? onVerificationSuccess;
  final int resendIntervalSeconds;

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  late final PhoneNumberInputController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PhoneNumberInputController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        phoneAuthResendIntervalSecondsProvider.overrideWith(
          (ref) => widget.resendIntervalSeconds,
        ),
        phoneAuthApiConfigProvider.overrideWith(
          (ref) => widget.apiConfig,
        ),
      ],
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: PhoneAuthLayoutDefaults.contentMaxWidth,
                  ),
                  child: PhoneAuthFlowScreen(
                    controller: _controller,
                    config: PhoneAuthViewConfig(
                      appName: widget.appName,
                      tagLine: widget.tagLine,
                      title: PhoneAuthCopyDefaults.phoneTitle,
                      subtitle: PhoneAuthCopyDefaults.phoneSubtitle,
                      otpTitle: PhoneAuthCopyDefaults.otpTitle,
                      initialCountry: widget.initialCountry,
                      hintText: PhoneAuthCopyDefaults.phoneFieldHintText,
                      themeColor: widget.themeColor,
                      actionButtonTitle:
                          PhoneAuthCopyDefaults.sendOtpButtonTitle,
                      verifyButtonTitle:
                          PhoneAuthCopyDefaults.verifyOtpButtonTitle,
                      legalConfig: widget.legalConfig,
                      onVerificationSuccess: widget.onVerificationSuccess,
                      actionButtonBorderRadius:
                          PhoneAuthLayoutDefaults.buttonBorderRadius,
                      actionButtonSpacing:
                          PhoneAuthLayoutDefaults.sectionSpacing,
                      actionButtonMinHeight:
                          PhoneAuthLayoutDefaults.buttonMinHeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
