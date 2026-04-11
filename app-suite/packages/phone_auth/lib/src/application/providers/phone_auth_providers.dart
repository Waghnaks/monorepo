import 'package:phone_auth/src/application/controllers/phone_auth_flow_controller.dart';
import 'package:phone_auth/src/application/models/phone_auth_flow_messages.dart';
import 'package:phone_auth/src/application/models/phone_auth_flow_state.dart';
import 'package:phone_auth/src/domain/models/phone_auth_api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/phone_auth_datasource.dart';
import '../../data/repositories/phone_auth_repository_impl.dart';
import '../../domain/repositories/phone_auth_repository.dart';
import '../../domain/usecases/send_phone_otp.dart';
import '../../domain/usecases/verify_phone_otp.dart';

final phoneAuthResendIntervalSecondsProvider = Provider<int>((ref) {
  return 30;
});

final phoneAuthApiConfigProvider = Provider<PhoneAuthApiConfig>((ref) {
  return const PhoneAuthApiConfig();
});

final phoneAuthOtpLengthProvider = Provider<int>((ref) {
  return 6;
});

final phoneAuthFlowMessagesProvider = Provider<PhoneAuthFlowMessages>((ref) {
  return PhoneAuthFlowMessages.fallback();
});

final phoneAuthPhoneNumberInputTransitioningProvider =
    StateProvider.autoDispose<bool>((ref) {
  return false;
});

final phoneAuthDataSourceProvider = Provider<PhoneAuthDataSource>((ref) {
  return PhoneAuthDataSource(
    apiConfig: ref.watch(phoneAuthApiConfigProvider),
    otpLength: ref.watch(phoneAuthOtpLengthProvider),
  );
});

final phoneAuthRepositoryProvider = Provider<PhoneAuthRepository>((ref) {
  return PhoneAuthRepositoryImpl(ref.watch(phoneAuthDataSourceProvider));
});

final sendPhoneOtpProvider = Provider<SendPhoneOtp>((ref) {
  return SendPhoneOtp(ref.watch(phoneAuthRepositoryProvider));
});

final verifyPhoneOtpProvider = Provider<VerifyPhoneOtp>((ref) {
  return VerifyPhoneOtp(ref.watch(phoneAuthRepositoryProvider));
});

final phoneAuthFlowControllerProvider = StateNotifierProvider.autoDispose<
    PhoneAuthFlowController, PhoneAuthFlowState>((ref) {
  return PhoneAuthFlowController(
    sendPhoneOtp: ref.watch(sendPhoneOtpProvider),
    verifyPhoneOtp: ref.watch(verifyPhoneOtpProvider),
    messages: ref.watch(phoneAuthFlowMessagesProvider),
    resendIntervalSeconds: ref.watch(phoneAuthResendIntervalSecondsProvider),
    otpLength: ref.watch(phoneAuthOtpLengthProvider),
  );
});
