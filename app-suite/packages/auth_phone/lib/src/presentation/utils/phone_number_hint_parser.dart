import 'dart:math' as math;

import 'package:auth_phone/src/domain/models/phone_country.dart';
import 'package:auth_phone/src/presentation/models/phone_number_hint_value.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

PhoneNumberHintValue? resolvePhoneNumberHint(
  String rawPhoneNumber, {
  required PhoneCountry fallbackCountry,
}) {
  final trimmedPhoneNumber = rawPhoneNumber.trim();
  if (trimmedPhoneNumber.isEmpty) {
    return null;
  }

  try {
    final parsedPhoneNumber = PhoneNumber.parse(trimmedPhoneNumber);
    final country = phoneCountryByIso(parsedPhoneNumber.isoCode);
    final nationalNumber = _clampNationalNumber(
      parsedPhoneNumber.nsn,
      maxLength: country.maxNationalNumberLength,
    );

    if (nationalNumber.isEmpty) {
      return null;
    }

    return PhoneNumberHintValue(
      country: country,
      nationalNumber: nationalNumber,
    );
  } catch (_) {
    final digitsOnly = trimmedPhoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }

    final dialCodeDigits = fallbackCountry.dialCode.replaceAll('+', '');
    final nationalNumber = digitsOnly.startsWith(dialCodeDigits) &&
            digitsOnly.length > dialCodeDigits.length
        ? digitsOnly.substring(dialCodeDigits.length)
        : digitsOnly;

    final clampedNationalNumber = _clampNationalNumber(
      nationalNumber,
      maxLength: fallbackCountry.maxNationalNumberLength,
    );

    if (clampedNationalNumber.isEmpty) {
      return null;
    }

    return PhoneNumberHintValue(
      country: fallbackCountry,
      nationalNumber: clampedNationalNumber,
    );
  }
}

String _clampNationalNumber(String nationalNumber, {required int maxLength}) {
  final digitsOnly = nationalNumber.replaceAll(RegExp(r'\D'), '');
  if (digitsOnly.isEmpty) {
    return '';
  }

  return digitsOnly.substring(0, math.min(digitsOnly.length, maxLength));
}
