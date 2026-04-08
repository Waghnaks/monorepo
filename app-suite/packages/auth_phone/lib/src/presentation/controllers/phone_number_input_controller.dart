import 'package:auth_phone/src/domain/models/phone_number_result.dart';
import 'package:flutter/foundation.dart';

class PhoneNumberInputController extends ChangeNotifier {
  PhoneNumberResult? _value;
  VoidCallback? _onClearRequested;

  PhoneNumberResult? get value => _value;

  bool get hasValue => _value != null;

  void updateValue(PhoneNumberResult? value) {
    _value = value;
    notifyListeners();
  }

  void bindClearHandler(VoidCallback onClearRequested) {
    _onClearRequested = onClearRequested;
  }

  void clear() => _onClearRequested?.call();

  @override
  void dispose() {
    _onClearRequested = null;
    super.dispose();
  }
}
