import 'package:auth_phone/src/domain/models/phone_country.dart';

class PhoneNumberHintValue {
  const PhoneNumberHintValue({
    required this.country,
    required this.nationalNumber,
  });

  final PhoneCountry country;
  final String nationalNumber;
}
