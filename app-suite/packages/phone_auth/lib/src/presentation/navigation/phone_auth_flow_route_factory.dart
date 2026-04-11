import 'package:phone_auth/src/application/providers/phone_auth_providers.dart';
import 'package:phone_auth/src/presentation/controllers/phone_auth_flow_actions.dart';
import 'package:phone_auth/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:phone_auth/src/presentation/models/phone_auth_view_config.dart';
import 'package:phone_auth/src/presentation/navigation/phone_auth_flow_navigation.dart';
import 'package:phone_auth/src/presentation/navigation/phone_auth_page_route.dart';
import 'package:phone_auth/src/presentation/navigation/phone_auth_route_paths.dart';
import 'package:phone_auth/src/presentation/screens/otp_verification_screen.dart';
import 'package:phone_auth/src/presentation/screens/phone_number_input_screen.dart';
import 'package:phone_auth/src/presentation/utils/phone_auth_flow_view_data_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract final class PhoneAuthFlowRouteFactory {
  static Route<void> build(
    RouteSettings settings, {
    required PhoneNumberInputController controller,
    required PhoneAuthViewConfig config,
  }) {
    switch (settings.name) {
      case PhoneAuthRoutePaths.otpVerification:
        return PhoneAuthPageRoute.build<void>(
          settings: settings,
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(phoneAuthFlowControllerProvider);
              final notifier =
                  ref.read(phoneAuthFlowControllerProvider.notifier);

              return OtpVerificationScreen(
                data: PhoneAuthFlowViewDataFactory
                    .createOtpVerificationScreenData(
                  context,
                  state: state,
                  config: config,
                ),
                onBackPressed: () =>
                    PhoneAuthFlowNavigation.closeOtpAndReturnToPhone(
                  context,
                  ref,
                  controller,
                ),
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
            },
          ),
        );
      case PhoneAuthRoutePaths.phoneNumberInput:
      default:
        return PhoneAuthPageRoute.build<void>(
          settings: const RouteSettings(
            name: PhoneAuthRoutePaths.phoneNumberInput,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(phoneAuthFlowControllerProvider);
              final isTransitioningToOtp =
                  ref.watch(phoneAuthPhoneNumberInputTransitioningProvider);
              final notifier =
                  ref.read(phoneAuthFlowControllerProvider.notifier);

              return PhoneNumberInputScreen(
                controller: controller,
                data: PhoneAuthFlowViewDataFactory
                    .buildPhoneNumberInputScreenData(
                  context,
                  state: state,
                  config: config,
                  isTransitioningToOtp: isTransitioningToOtp,
                ),
                onChanged: notifier.handlePhoneNumberChanged,
                onSubmitted: notifier.handlePhoneNumberSubmitted,
                onSendOtpPressed: () =>
                    PhoneAuthFlowNavigation.openOtpAfterSend(
                  context,
                  ref,
                  controller,
                ),
              );
            },
          ),
        );
    }
  }
}
