import 'package:flutter/material.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:phone_auth/src/presentation/models/otp_verification_screen_data.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/widgets/otp_code_input_field.dart';
import 'package:phone_auth/src/presentation/widgets/phone_auth_feedback_banner.dart';
import 'package:phone_auth/src/presentation/widgets/phone_auth_page_body.dart';

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
          title: data.userPhoneAuth &&
                  data.appBarTitle != null &&
                  data.appBarTitle!.trim().isNotEmpty
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
                PhoneAuthLayoutDefaults.otpVerificationscreenTopPadding,
                PhoneAuthLayoutDefaults.screenHorizontalPadding,
                PhoneAuthLayoutDefaults.screenBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _OtpHeaderSection(
                    data: data,
                    phoneChipBackgroundColor: phoneChipBackgroundColor,
                    phoneChipBorderColor: phoneChipBorderColor,
                    phoneChipTextColor: phoneChipTextColor,
                    resolvedTheme: resolvedTheme,
                  ),
                  const SizedBox(height: 30),
                  _OtpInputSection(
                    data: data,
                    resolvedTheme: resolvedTheme,
                    onOtpChanged: onOtpChanged,
                    onVerifyPressed: onVerifyPressed,
                  ),
                  _OtpFeedbackSection(data: data),
                  if (data.isVerifyingOtp) ...[
                    const SizedBox(height: 18),
                    _OtpProgressIndicator(color: resolvedTheme.accentColor),
                  ],
                  const SizedBox(height: 22),
                  _OtpResendSection(
                    data: data,
                    resolvedTheme: resolvedTheme,
                    onResendPressed: onResendPressed,
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

class _OtpHeaderSection extends StatelessWidget {
  const _OtpHeaderSection({
    required this.data,
    required this.phoneChipBackgroundColor,
    required this.phoneChipBorderColor,
    required this.phoneChipTextColor,
    required this.resolvedTheme,
  });

  final OtpVerificationScreenData data;
  final Color phoneChipBackgroundColor;
  final Color phoneChipBorderColor;
  final Color phoneChipTextColor;
  final PhoneAuthResolvedTheme resolvedTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}

class _OtpInputSection extends StatelessWidget {
  const _OtpInputSection({
    required this.data,
    required this.resolvedTheme,
    required this.onOtpChanged,
    required this.onVerifyPressed,
  });

  final OtpVerificationScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerifyPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

class _OtpFeedbackSection extends StatelessWidget {
  const _OtpFeedbackSection({
    required this.data,
  });

  final OtpVerificationScreenData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

class _OtpProgressIndicator extends StatelessWidget {
  const _OtpProgressIndicator({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.4,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

class _OtpResendSection extends StatelessWidget {
  const _OtpResendSection({
    required this.data,
    required this.resolvedTheme,
    required this.onResendPressed,
  });

  final OtpVerificationScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final VoidCallback onResendPressed;

  @override
  Widget build(BuildContext context) {
    if (data.resendSecondsRemaining > 0) {
      return Center(
        child: Text(
          PhoneAuthCopyDefaults.resendCountdownLabel(
            data.resendSecondsRemaining,
          ),
          textAlign: TextAlign.center,
          style: resolvedTheme.actionTextStyle,
        ),
      );
    }

    return Center(
      child: TextButton(
        onPressed:
            data.isResendingOtp || data.isVerifyingOtp ? null : onResendPressed,
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
    );
  }
}
