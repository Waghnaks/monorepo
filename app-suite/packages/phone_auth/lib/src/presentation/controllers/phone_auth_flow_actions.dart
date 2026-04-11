import 'package:phone_auth/src/application/providers/phone_auth_providers.dart';
import 'package:phone_auth/src/domain/models/phone_auth_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract final class PhoneAuthFlowActions {
  /// Keeps widget callbacks thin by routing send and verify actions through a
  /// single facade for the Riverpod controller.
  static Future<bool> sendOtp(
    WidgetRef ref, {
    bool isResend = false,
  }) {
    return ref
        .read(phoneAuthFlowControllerProvider.notifier)
        .sendOtp(isResend: isResend);
  }

  static Future<void> verifyOtp(
    WidgetRef ref, {
    ValueChanged<PhoneAuthSession>? onVerificationSuccess,
  }) async {
    final session =
        await ref.read(phoneAuthFlowControllerProvider.notifier).verifyOtp();

    if (session != null && session.isVerified) {
      onVerificationSuccess?.call(session);
    }
  }
}
