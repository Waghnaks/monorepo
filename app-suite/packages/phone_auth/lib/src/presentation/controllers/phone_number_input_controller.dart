import 'package:phone_auth/src/domain/models/phone_number_result.dart';
import 'package:flutter/foundation.dart';

/// Stores the latest parsed phone number and lets the flow request clear or
/// unfocus without reaching into the field widget directly.
class PhoneNumberInputController extends ChangeNotifier {
  PhoneNumberResult? _value;
  VoidCallback? _onClearRequested;
  VoidCallback? _onUnfocusRequested;

  PhoneNumberResult? get value => _value;

  bool get hasValue => _value != null;

  void updateValue(PhoneNumberResult? value) {
    _value = value;
    notifyListeners();
  }

  void bindClearHandler(VoidCallback onClearRequested) {
    _onClearRequested = onClearRequested;
  }

  void bindUnfocusHandler(VoidCallback onUnfocusRequested) {
    _onUnfocusRequested = onUnfocusRequested;
  }

  void clear() => _onClearRequested?.call();

  void unfocus() => _onUnfocusRequested?.call();

  @override
  void dispose() {
    _onClearRequested = null;
    _onUnfocusRequested = null;
    super.dispose();
  }
}
