import 'package:auth_phone/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:auth_phone/src/presentation/models/otp_verification_screen_data.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:auth_phone/src/presentation/widgets/otp_code_input_field.dart';
import 'package:auth_phone/src/presentation/widgets/phone_auth_feedback_banner.dart';
import 'package:auth_phone/src/presentation/widgets/phone_auth_page_body.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({
    required this.data,
    required this.onBackPressed,
    required this.onOtpChanged,
    required this.onResendPressed,
    required this.onVerifyPressed,
    super.key,
  });

  final OtpVerificationScreenData data;
  final VoidCallback onBackPressed;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onResendPressed;
  final VoidCallback onVerifyPressed;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: data.themeColor,
    );
    final phoneChipBackgroundColor =
        resolvedTheme.surfaceMutedColor.withValues(alpha: 0.65);
    final phoneChipBorderColor =
        resolvedTheme.accentColor.withValues(alpha: 0.14);
    final phoneChipTextColor = Theme.of(context).colorScheme.onSurface;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !data.isVerifyingOtp) {
          onBackPressed();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: data.isVerifyingOtp ? null : onBackPressed,
          ),
          title: data.appBarTitle != null && data.appBarTitle!.trim().isNotEmpty
              ? Text(
                  data.appBarTitle!,
                  style: resolvedTheme.accentTitleTextStyle,
                )
              : null,
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          child: PhoneAuthPageBody(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                PhoneAuthLayoutDefaults.screenHorizontalPadding,
                PhoneAuthLayoutDefaults.screenTopPadding,
                PhoneAuthLayoutDefaults.screenHorizontalPadding,
                PhoneAuthLayoutDefaults.screenBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data.otpTitle,
                    textAlign: TextAlign.center,
                    style: resolvedTheme.headingTextStyle,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    PhoneAuthCopyDefaults.otpMessage,
                    textAlign: TextAlign.center,
                    style: resolvedTheme.supportingTextStyle,
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: phoneChipBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: phoneChipBorderColor),
                      ),
                      child: Text(
                        data.phoneLabel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: phoneChipTextColor,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
                      ),
                      child: OtpCodeInputField(
                        key: ValueKey<int>(data.otpInputResetKey),
                        length: PhoneAuthLayoutDefaults.otpLength,
                        enabled: !data.isVerifyingOtp,
                        themeColor: resolvedTheme.accentColor,
                        hasError: data.otpErrorMessage != null,
                        onChanged: onOtpChanged,
                        onCompleted: (code) {
                          onOtpChanged(code);
                          if (!data.isVerifyingOtp) {
                            onVerifyPressed();
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
                      ),
                      child: PhoneAuthFeedbackBanner(
                        color: data.errorColor,
                        message: data.otpErrorMessage,
                        presentation: PhoneAuthFeedbackPresentation.inlineText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
                      ),
                      child: PhoneAuthFeedbackBanner(
                        color: data.successColor,
                        message: data.successMessage,
                      ),
                    ),
                  ),
                  if (data.isVerifyingOtp) ...[
                    const SizedBox(height: 18),
                    Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            resolvedTheme.accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 22),
                  Center(
                    child: data.resendSecondsRemaining > 0
                        ? Text(
                            '${PhoneAuthCopyDefaults.resendLabel} in ${data.resendSecondsRemaining}s',
                            textAlign: TextAlign.center,
                            style: resolvedTheme.actionTextStyle,
                          )
                        : TextButton(
                            onPressed:
                                data.isResendingOtp || data.isVerifyingOtp
                                    ? null
                                    : onResendPressed,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              foregroundColor: resolvedTheme.accentColor,
                            ),
                            child: Text(
                              PhoneAuthCopyDefaults.resendLabel,
                              style: resolvedTheme.actionTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: resolvedTheme.accentColor,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
