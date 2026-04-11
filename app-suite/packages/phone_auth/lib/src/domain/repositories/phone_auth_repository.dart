import '../models/phone_auth_session.dart';

abstract class PhoneAuthRepository {
  Future<PhoneAuthSession> sendOtp(String phoneNumber);
  Future<PhoneAuthSession> verifyOtp({
    required String verificationId,
    required String otpCode,
  });
  Future<void> signOut();
}
