import 'package:auth_phone/src/application/models/phone_auth_flow_state.dart';
import 'package:auth_phone/src/application/providers/auth_phone_providers.dart';
import 'package:auth_phone/src/presentation/controllers/phone_auth_flow_actions.dart';
import 'package:auth_phone/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:auth_phone/src/presentation/models/phone_auth_view_config.dart';
import 'package:auth_phone/src/presentation/screens/otp_verification_screen.dart';
import 'package:auth_phone/src/presentation/screens/phone_entry_screen.dart';
import 'package:auth_phone/src/presentation/utils/phone_auth_flow_view_data_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneAuthFlowScreen extends ConsumerWidget {
  const PhoneAuthFlowScreen({
    required this.controller,
    required this.config,
    super.key,
  });

  final PhoneNumberInputController controller;
  final PhoneAuthViewConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneAuthFlowControllerProvider);
    final notifier = ref.read(phoneAuthFlowControllerProvider.notifier);

    final currentStepView = state.currentStep == PhoneAuthFlowStep.phoneNumber
        ? PhoneEntryScreen(
            controller: controller,
            data: PhoneAuthFlowViewDataFactory.createPhoneEntryScreenData(
              context,
              state: state,
              config: config,
            ),
            onChanged: notifier.handlePhoneNumberChanged,
            onSubmitted: notifier.handlePhoneNumberSubmitted,
            onSendOtpPressed: () => PhoneAuthFlowActions.sendOtp(ref),
          )
        : OtpVerificationScreen(
            data: PhoneAuthFlowViewDataFactory.createOtpVerificationScreenData(
              context,
              state: state,
              config: config,
            ),
            onBackPressed: notifier.goBackToPhoneStep,
            onOtpChanged: notifier.handleOtpChanged,
            onResendPressed: () => PhoneAuthFlowActions.sendOtp(
              ref,
              isResend: true,
            ),
            onVerifyPressed: () => PhoneAuthFlowActions.verifyOtp(
              ref,
              onVerificationSuccess: config.onVerificationSuccess,
            ),
          );

    return currentStepView;
  }
}
