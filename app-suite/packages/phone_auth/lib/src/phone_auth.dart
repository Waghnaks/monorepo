import 'package:phone_auth/src/application/providers/phone_auth_providers.dart';
import 'package:phone_auth/src/domain/models/phone_auth_config.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_flow_messages_defaults.dart';
import 'package:phone_auth/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:phone_auth/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:phone_auth/src/presentation/models/phone_auth_view_config.dart';
import 'package:phone_auth/src/presentation/navigation/phone_auth_flow_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({
    super.key,
    required this.config,
  });

  final PhoneAuthConfig config;

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
          (ref) => widget.config.resendIntervalSeconds,
        ),
        phoneAuthApiConfigProvider.overrideWith(
          (ref) => widget.config.apiConfig,
        ),
        phoneAuthOtpLengthProvider.overrideWith(
          (ref) => PhoneAuthLayoutDefaults.otpLength,
        ),
        phoneAuthFlowMessagesProvider.overrideWith(
          (ref) => buildPhoneAuthFlowMessages(),
        ),
      ],
      child: PhoneAuthFlowNavigator(
        controller: _controller,
        config: PhoneAuthViewConfig(
          appName: widget.config.appName,
          tagLine: widget.config.tagLine,
          userPhoneAuth: widget.config.userPhoneAuth,
          title: PhoneAuthCopyDefaults.phoneTitle,
          subtitle: PhoneAuthCopyDefaults.phoneSubtitle,
          otpTitle: PhoneAuthCopyDefaults.otpTitle,
          initialCountry: widget.config.initialCountry,
          hintText: PhoneAuthCopyDefaults.phoneFieldHintText,
          themeColor: widget.config.themeColor,
          actionButtonTitle: PhoneAuthCopyDefaults.sendOtpButtonTitle,
          legalConfig: widget.config.legalConfig,
          onVerificationSuccess: widget.config.onVerificationSuccess,
          actionButtonBorderRadius: PhoneAuthLayoutDefaults.buttonBorderRadius,
          actionButtonSpacing: PhoneAuthLayoutDefaults.sectionSpacing,
          actionButtonMinHeight: PhoneAuthLayoutDefaults.buttonMinHeight,
        ),
      ),
    );
  }
}
