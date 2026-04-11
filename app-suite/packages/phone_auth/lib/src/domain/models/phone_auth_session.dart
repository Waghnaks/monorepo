class PhoneAuthSession {
  const PhoneAuthSession({
    required this.phoneNumber,
    this.verificationId,
    this.isVerified = false,
  });

  final String phoneNumber;
  final String? verificationId;
  final bool isVerified;

  PhoneAuthSession copyWith({
    String? phoneNumber,
    String? verificationId,
    bool? isVerified,
  }) {
    return PhoneAuthSession(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
