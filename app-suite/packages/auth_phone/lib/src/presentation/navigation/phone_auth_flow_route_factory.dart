import 'package:auth_phone/src/application/providers/auth_phone_providers.dart';
import 'package:auth_phone/src/presentation/controllers/phone_auth_flow_actions.dart';
import 'package:auth_phone/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:auth_phone/src/presentation/models/phone_auth_view_config.dart';
import 'package:auth_phone/src/presentation/navigation/phone_auth_flow_navigation.dart';
import 'package:auth_phone/src/presentation/navigation/phone_auth_page_route.dart';
import 'package:auth_phone/src/presentation/navigation/phone_auth_route_paths.dart';
import 'package:auth_phone/src/presentation/screens/otp_verification_screen.dart';
import 'package:auth_phone/src/presentation/screens/phone_entry_screen.dart';
import 'package:auth_phone/src/presentation/utils/phone_auth_flow_view_data_factory.dart';
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
      case PhoneAuthRoutePaths.phoneEntry:
      default:
        return PhoneAuthPageRoute.build<void>(
          settings: const RouteSettings(name: PhoneAuthRoutePaths.phoneEntry),
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(phoneAuthFlowControllerProvider);
              final isTransitioningToOtp =
                  ref.watch(phoneAuthPhoneEntryTransitioningProvider);
              final notifier =
                  ref.read(phoneAuthFlowControllerProvider.notifier);

              return PhoneEntryScreen(
                controller: controller,
                data: PhoneAuthFlowViewDataFactory.createPhoneEntryScreenData(
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
