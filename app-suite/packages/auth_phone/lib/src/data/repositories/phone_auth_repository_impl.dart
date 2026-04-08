import '../../domain/models/phone_auth_session.dart';
import '../../domain/repositories/phone_auth_repository.dart';
import '../datasources/phone_auth_datasource.dart';

class PhoneAuthRepositoryImpl implements PhoneAuthRepository {
  const PhoneAuthRepositoryImpl(this._dataSource);

  final PhoneAuthDataSource _dataSource;

  @override
  Future<PhoneAuthSession> sendOtp(String phoneNumber) async {
    final verificationId = await _dataSource.requestOtp(phoneNumber);

    return PhoneAuthSession(
      phoneNumber: phoneNumber,
      verificationId: verificationId,
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<PhoneAuthSession> verifyOtp({
    required String verificationId,
    required String otpCode,
  }) async {
    final isVerified = await _dataSource.confirmOtp(
      verificationId: verificationId,
      otpCode: otpCode,
    );
    final phoneNumber = _dataSource.phoneNumberForVerification(verificationId);

    return PhoneAuthSession(
      phoneNumber: phoneNumber ?? '',
      verificationId: verificationId,
      isVerified: isVerified,
    );
  }
}
