enum PhoneNumberValidationFailure {
  unsupportedPattern,
  repeatedDigits,
  sequentialDigits,
}

class PhoneNumberValidationResult {
  const PhoneNumberValidationResult({
    required this.isComplete,
    required this.isValid,
    this.failure,
  });

  final bool isComplete;
  final bool isValid;
  final PhoneNumberValidationFailure? failure;

  bool get hasVisibleError => isComplete && !isValid;
}
