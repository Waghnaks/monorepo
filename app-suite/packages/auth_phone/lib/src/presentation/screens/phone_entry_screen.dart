import 'package:auth_phone/src/domain/models/phone_number_result.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:auth_phone/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:auth_phone/src/presentation/models/phone_entry_screen_data.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:auth_phone/src/presentation/widgets/phone_auth_feedback_banner.dart';
import 'package:auth_phone/src/presentation/widgets/phone_auth_legal_notice.dart';
import 'package:auth_phone/src/presentation/widgets/phone_number_input_field.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PhoneEntryScreen extends StatelessWidget {
  const PhoneEntryScreen({
    required this.controller,
    required this.data,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
    super.key,
  });

  final PhoneNumberInputController controller;
  final PhoneEntryScreenData data;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: data.themeColor,
    );
    final hasBrandedHeader =
        (data.appName != null && data.appName!.trim().isNotEmpty) ||
            (data.tagLine != null && data.tagLine!.trim().isNotEmpty);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        PhoneAuthLayoutDefaults.screenHorizontalPadding,
        PhoneAuthLayoutDefaults.screenTopPadding,
        PhoneAuthLayoutDefaults.screenHorizontalPadding,
        PhoneAuthLayoutDefaults.screenBottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (hasBrandedHeader) ...[
            if (data.appName != null && data.appName!.trim().isNotEmpty)
              Text(
                data.appName!,
                textAlign: TextAlign.center,
                style: resolvedTheme.brandTextStyle,
              ),
            if (data.tagLine != null && data.tagLine!.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                data.tagLine!,
                textAlign: TextAlign.center,
                style: resolvedTheme.tagLineTextStyle,
              ),
            ],
            const SizedBox(height: 24),
          ] else ...[
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: resolvedTheme.headingTextStyle,
            ),
            const SizedBox(height: 12),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: resolvedTheme.supportingTextStyle,
            ),
            const SizedBox(height: 28),
          ],
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
              ),
              child: PhoneNumberInputField(
                controller: controller,
                initialCountry: data.initialCountry,
                hintText: data.hintText,
                enabled: data.enabled,
                showCountryPicker: data.showCountryPicker,
                themeColor: resolvedTheme.accentColor,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
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
                message: data.phoneErrorMessage,
              ),
            ),
          ),
          if (data.showActionButton) ...[
            SizedBox(height: data.actionButtonSpacing + 4),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
                ),
                child: PrimaryButton(
                  isDisabled: data.isActionButtonDisabled,
                  isLoading: data.isActionButtonLoading,
                  title: data.actionButtonTitle,
                  onPressed: onSendOtpPressed,
                  backgroundColor: data.actionButtonBackgroundColor,
                  foregroundColor: data.actionButtonForegroundColor,
                  borderRadius: data.actionButtonBorderRadius,
                  minHeight: data.actionButtonMinHeight,
                ),
              ),
            ),
          ],
          if (data.legalConfig != null && data.legalConfig!.hasAnyLink)
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
                ),
                child: PhoneAuthLegalNotice(
                  legalConfig: data.legalConfig!,
                  themeColor: resolvedTheme.accentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
