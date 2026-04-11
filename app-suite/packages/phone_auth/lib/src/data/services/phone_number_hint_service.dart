import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth/src/foundation/platform/phone_auth_platform_defaults.dart';

abstract final class PhoneNumberHintService {
  static const MethodChannel _channel = MethodChannel(
    PhoneAuthPlatformDefaults.phoneNumberHintChannelName,
  );

  static Future<String?> requestPhoneNumberHint() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return null;
    }

    try {
      final hintedPhoneNumber = await _channel.invokeMethod<String>(
        PhoneAuthPlatformDefaults.requestPhoneNumberHintMethod,
      );

      if (hintedPhoneNumber == null || hintedPhoneNumber.trim().isEmpty) {
        return null;
      }

      return hintedPhoneNumber.trim();
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }
}
