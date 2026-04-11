import 'package:phone_auth/src/domain/models/phone_country.dart';
import 'package:phone_auth/src/domain/validation/phone_number_validation_result.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

abstract final class PhoneNumberValidator {
  static final Map<IsoCode, RegExp> _strictCountryPatterns = <IsoCode, RegExp>{
    IsoCode.IN: RegExp(r'^[6-9]\d{9}$'),
    IsoCode.US: RegExp(r'^[2-9]\d{9}$'),
    IsoCode.CA: RegExp(r'^[2-9]\d{9}$'),
  };

  static PhoneNumberValidationResult validate({
    required PhoneCountry country,
    required String nationalNumber,
  }) {
    final digitsOnly = nationalNumber.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return const PhoneNumberValidationResult(
        isComplete: false,
        isValid: false,
      );
    }

    final isComplete = digitsOnly.length == country.maxNationalNumberLength;
    if (!isComplete) {
      return const PhoneNumberValidationResult(
        isComplete: false,
        isValid: false,
      );
    }

    final strictPattern = _strictCountryPatterns[country.isoCode];
    if (strictPattern != null && !strictPattern.hasMatch(digitsOnly)) {
      return const PhoneNumberValidationResult(
        isComplete: true,
        isValid: false,
        failure: PhoneNumberValidationFailure.unsupportedPattern,
      );
    }

    if (_hasRepeatedDigits(digitsOnly)) {
      return const PhoneNumberValidationResult(
        isComplete: true,
        isValid: false,
        failure: PhoneNumberValidationFailure.repeatedDigits,
      );
    }

    if (_hasSequentialDigits(digitsOnly)) {
      return const PhoneNumberValidationResult(
        isComplete: true,
        isValid: false,
        failure: PhoneNumberValidationFailure.sequentialDigits,
      );
    }

    return const PhoneNumberValidationResult(
      isComplete: true,
      isValid: true,
    );
  }

  static bool _hasRepeatedDigits(String digits) {
    final firstDigit = digits[0];
    for (var index = 1; index < digits.length; index++) {
      if (digits[index] != firstDigit) {
        return false;
      }
    }
    return true;
  }

  static bool _hasSequentialDigits(String digits) {
    var ascending = true;
    var descending = true;

    for (var index = 1; index < digits.length; index++) {
      final previousDigit = digits.codeUnitAt(index - 1);
      final currentDigit = digits.codeUnitAt(index);

      if (currentDigit != previousDigit + 1) {
        ascending = false;
      }
      if (currentDigit != previousDigit - 1) {
        descending = false;
      }

      if (!ascending && !descending) {
        return false;
      }
    }

    return ascending || descending;
  }
}
