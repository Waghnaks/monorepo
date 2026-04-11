import 'package:phone_auth/src/application/providers/phone_auth_providers.dart';
import 'package:phone_auth/src/presentation/controllers/phone_auth_flow_actions.dart';
import 'package:phone_auth/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:phone_auth/src/presentation/navigation/phone_auth_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract final class PhoneAuthFlowNavigation {
  /// Centralizes the phone -> OTP route transition so the input lock, focus
  /// cleanup, and route push stay in sync.
  static Future<void> openOtpAfterSend(
    BuildContext context,
    WidgetRef ref,
    PhoneNumberInputController controller,
  ) async {
    ref.read(phoneAuthPhoneNumberInputTransitioningProvider.notifier).state =
        true;
    FocusScope.of(context).unfocus();
    controller.unfocus();

    final didSendOtp = await PhoneAuthFlowActions.sendOtp(ref);
    if (!didSendOtp || !context.mounted) {
      ref.read(phoneAuthPhoneNumberInputTransitioningProvider.notifier).state =
          false;
      return;
    }

    try {
      await Navigator.of(context)
          .pushNamed(PhoneAuthRoutePaths.otpVerification);
    } finally {
      ref.read(phoneAuthPhoneNumberInputTransitioningProvider.notifier).state =
          false;
    }

    controller.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.unfocus();
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  static void closeOtpAndReturnToPhone(
    BuildContext context,
    WidgetRef ref,
    PhoneNumberInputController controller,
  ) {
    ref.read(phoneAuthPhoneNumberInputTransitioningProvider.notifier).state =
        false;
    ref.read(phoneAuthFlowControllerProvider.notifier).stopResendTimer();
    controller.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pop();
  }
}
