import '../models/phone_auth_session.dart';
import '../repositories/phone_auth_repository.dart';

class SendPhoneOtp {
  const SendPhoneOtp(this._repository);

  final PhoneAuthRepository _repository;

  Future<PhoneAuthSession> call(String phoneNumber) {
    return _repository.sendOtp(phoneNumber);
  }
}
