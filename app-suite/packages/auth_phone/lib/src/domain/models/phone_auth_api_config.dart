class PhoneAuthApiConfig {
  const PhoneAuthApiConfig({
    this.sendOtpEndpoint = '/sms/send-otp',
    this.verifyOtpEndpoint = '/sms/verify-otp',
  });

  final String sendOtpEndpoint;
  final String verifyOtpEndpoint;
}
