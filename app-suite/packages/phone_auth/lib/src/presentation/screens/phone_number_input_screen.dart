import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/src/domain/models/phone_auth_legal_config.dart';
import 'package:phone_auth/src/domain/models/phone_number_result.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:phone_auth/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:phone_auth/src/presentation/models/phone_number_input_screen_data.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/widgets/phone_auth_feedback_banner.dart';
import 'package:phone_auth/src/presentation/widgets/phone_auth_legal_notice.dart';
import 'package:phone_auth/src/presentation/widgets/phone_auth_page_body.dart';
import 'package:phone_auth/src/presentation/widgets/phone_number_input_field.dart';

class PhoneNumberInputScreen extends StatelessWidget {
  const PhoneNumberInputScreen({
    required this.controller,
    required this.data,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
    super.key,
  });

  final PhoneNumberInputController controller;
  final PhoneNumberInputScreenData data;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: data.themeColor,
    );
    final hasAppName = data.appName?.trim().isNotEmpty ?? false;
    final keyboardInset = data.userPhoneAuth && hasAppName
        ? MediaQuery.viewInsetsOf(context).bottom
        : 0.0;
    final hasLegalNotice = data.legalConfig?.hasAnyLink ?? false;
    final hasBrandedHeader = hasAppName;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: hasLegalNotice
          ? _LegalNoticeFooter(
              legalConfig: data.legalConfig!,
              themeColor: resolvedTheme.accentColor,
            )
          : null,
      body: SafeArea(
        child: PhoneAuthPageBody(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.only(bottom: keyboardInset),
            child: AbsorbPointer(
              absorbing: data.isInteractionLocked,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    PhoneAuthLayoutDefaults.screenHorizontalPadding,
                    PhoneAuthLayoutDefaults.phoneInputscreenTopPadding,
                    PhoneAuthLayoutDefaults.screenHorizontalPadding,
                    PhoneAuthLayoutDefaults.screenBottomPadding,
                  ),
                  child: data.userPhoneAuth
                      ? hasAppName
                          ? _ReturningUserPhoneNumberLayout(
                              controller: controller,
                              data: data,
                              resolvedTheme: resolvedTheme,
                              hasBrandedHeader: hasBrandedHeader,
                              onChanged: onChanged,
                              onSubmitted: onSubmitted,
                              onSendOtpPressed: onSendOtpPressed,
                            )
                          : _CenteredFallbackPhoneNumberLayout(
                              controller: controller,
                              data: data,
                              resolvedTheme: resolvedTheme,
                              onChanged: onChanged,
                              onSubmitted: onSubmitted,
                              onSendOtpPressed: onSendOtpPressed,
                            )
                      : _NewUserPhoneNumberLayout(
                          controller: controller,
                          data: data,
                          resolvedTheme: resolvedTheme,
                          hasBrandedHeader: hasBrandedHeader,
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                          onSendOtpPressed: onSendOtpPressed,
                        )),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegalNoticeFooter extends StatelessWidget {
  const _LegalNoticeFooter({
    required this.legalConfig,
    required this.themeColor,
  });

  final PhoneAuthLegalConfig legalConfig;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: PhoneAuthLegalNotice(
        legalConfig: legalConfig,
        themeColor: themeColor,
      ),
    );
  }
}

class _CenteredFallbackPhoneNumberLayout extends StatelessWidget {
  const _CenteredFallbackPhoneNumberLayout({
    required this.controller,
    required this.data,
    required this.resolvedTheme,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
  });

  final PhoneNumberInputController controller;
  final PhoneNumberInputScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FallbackHeaderSection(
            title: data.title,
            subtitle: data.subtitle,
            resolvedTheme: resolvedTheme,
          ),
          _PhoneNumberFormSection(
            controller: controller,
            data: data,
            resolvedTheme: resolvedTheme,
            showPrompt: false,
            showCountryPicker: data.showCountryPicker,
            mainAxisAlignment: MainAxisAlignment.start,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onSendOtpPressed: onSendOtpPressed,
          ),
        ],
      ),
    );
  }
}

class _ReturningUserPhoneNumberLayout extends StatelessWidget {
  const _ReturningUserPhoneNumberLayout({
    required this.controller,
    required this.data,
    required this.resolvedTheme,
    required this.hasBrandedHeader,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
  });

  final PhoneNumberInputController controller;
  final PhoneNumberInputScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final bool hasBrandedHeader;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        hasBrandedHeader
            ? _ReturningUserHeaderSection(
                appName: data.appName,
                tagLine: data.tagLine,
                resolvedTheme: resolvedTheme,
              )
            : _FallbackHeaderSection(
                title: data.title,
                subtitle: data.subtitle,
                resolvedTheme: resolvedTheme,
              ),
        _PhoneNumberFormSection(
          controller: controller,
          data: data,
          resolvedTheme: resolvedTheme,
          showPrompt: false,
          showCountryPicker: data.showCountryPicker,
          mainAxisAlignment: MainAxisAlignment.start,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onSendOtpPressed: onSendOtpPressed,
        ),
      ],
    );
  }
}

class _NewUserPhoneNumberLayout extends StatelessWidget {
  const _NewUserPhoneNumberLayout({
    required this.controller,
    required this.data,
    required this.resolvedTheme,
    required this.hasBrandedHeader,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
  });

  final PhoneNumberInputController controller;
  final PhoneNumberInputScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final bool hasBrandedHeader;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hasBrandedHeader
            ? _WelcomeHeaderSection(
                appName: data.appName,
                resolvedTheme: resolvedTheme,
              )
            : _FallbackHeaderSection(
                title: data.title,
                subtitle: data.subtitle,
                resolvedTheme: resolvedTheme,
              ),
        Expanded(
          child: _PhoneNumberFormSection(
            controller: controller,
            data: data,
            resolvedTheme: resolvedTheme,
            showPrompt: true,
            showCountryPicker: false,
            mainAxisAlignment: MainAxisAlignment.center,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onSendOtpPressed: onSendOtpPressed,
          ),
        ),
      ],
    );
  }
}

class _ReturningUserHeaderSection extends StatelessWidget {
  const _ReturningUserHeaderSection({
    required this.appName,
    required this.tagLine,
    required this.resolvedTheme,
  });

  final String? appName;
  final String? tagLine;
  final PhoneAuthResolvedTheme resolvedTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (appName != null && appName!.trim().isNotEmpty)
          Text(
            appName!,
            textAlign: TextAlign.center,
            style: resolvedTheme.brandTextStyle,
          ),
        if (tagLine != null && tagLine!.trim().isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            tagLine!,
            textAlign: TextAlign.center,
            style: resolvedTheme.tagLineTextStyle,
          ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

class _WelcomeHeaderSection extends StatelessWidget {
  const _WelcomeHeaderSection({
    required this.appName,
    required this.resolvedTheme,
  });

  final String? appName;
  final PhoneAuthResolvedTheme resolvedTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (appName != null && appName!.trim().isNotEmpty)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${PhoneAuthCopyDefaults.welcomePrefix} ',
                  style: resolvedTheme.headingTextStyle,
                ),
                TextSpan(
                  text: appName!,
                  style: resolvedTheme.brandTextStyle,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _FallbackHeaderSection extends StatelessWidget {
  const _FallbackHeaderSection({
    required this.title,
    required this.subtitle,
    required this.resolvedTheme,
  });

  final String title;
  final String subtitle;
  final PhoneAuthResolvedTheme resolvedTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: resolvedTheme.headingTextStyle,
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: resolvedTheme.supportingTextStyle,
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _PhoneNumberFormSection extends StatelessWidget {
  const _PhoneNumberFormSection({
    required this.controller,
    required this.data,
    required this.resolvedTheme,
    required this.showPrompt,
    required this.showCountryPicker,
    required this.mainAxisAlignment,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSendOtpPressed,
  });

  final PhoneNumberInputController controller;
  final PhoneNumberInputScreenData data;
  final PhoneAuthResolvedTheme resolvedTheme;
  final bool showPrompt;
  final bool showCountryPicker;
  final MainAxisAlignment mainAxisAlignment;
  final void Function(PhoneNumberResult result) onChanged;
  final void Function(PhoneNumberResult result) onSubmitted;
  final VoidCallback onSendOtpPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (showPrompt) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              PhoneAuthCopyDefaults.newUserPhoneInputPrompt,
              style: resolvedTheme.bodyEmphasisTextStyle,
            ),
          ),
          const SizedBox(height: 12),
        ],
        _FormWidth(
          child: PhoneNumberInputField(
            controller: controller,
            initialCountry: data.initialCountry,
            hintText: data.hintText,
            enabled: data.enabled,
            showCountryPicker: showCountryPicker,
            themeColor: resolvedTheme.accentColor,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        _FormWidth(
          child: PhoneAuthFeedbackBanner(
            color: data.errorColor,
            message: data.phoneErrorMessage,
            presentation: PhoneAuthFeedbackPresentation.inlineText,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: data.actionButtonSpacing + 4),
        _FormWidth(
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
      ],
    );
  }
}

class _FormWidth extends StatelessWidget {
  const _FormWidth({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: PhoneAuthLayoutDefaults.formMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
