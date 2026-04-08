import '../models/phone_auth_session.dart';
import '../repositories/phone_auth_repository.dart';

class VerifyPhoneOtp {
  const VerifyPhoneOtp(this._repository);

  final PhoneAuthRepository _repository;

  Future<PhoneAuthSession> call({
    required String verificationId,
    required String otpCode,
  }) {
    return _repository.verifyOtp(
      verificationId: verificationId,
      otpCode: otpCode,
    );
  }
}

