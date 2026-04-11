import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneNumberResult {
  const PhoneNumberResult({
    required this.nationalNumber,
    required this.dialCode,
    required this.isoCode,
    required this.isValid,
    required this.isComplete,
    this.validationMessage,
  });

  final String nationalNumber;
  final String dialCode;
  final IsoCode isoCode;
  final bool isValid;
  final bool isComplete;
  final String? validationMessage;

  String get completeNumber => '$dialCode$nationalNumber';

  @override
  String toString() => completeNumber;
}
