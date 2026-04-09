import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract final class PhoneNumberHintService {
  static const MethodChannel _channel = MethodChannel(
    'auth_phone/phone_number_hint',
  );

  static Future<String?> requestPhoneNumberHint() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return null;
    }

    try {
      final hintedPhoneNumber = await _channel.invokeMethod<String>(
        'requestPhoneNumberHint',
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
