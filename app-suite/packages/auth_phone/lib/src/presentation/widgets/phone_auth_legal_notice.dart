import 'package:auth_phone/src/domain/models/phone_auth_legal_config.dart';
import 'package:auth_phone/src/foundation/copy/phone_auth_legal_copy_defaults.dart';
import 'package:auth_phone/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:auth_phone/src/presentation/utils/phone_auth_document_route.dart';
import 'package:flutter/material.dart';

class PhoneAuthLegalNotice extends StatelessWidget {
  const PhoneAuthLegalNotice({
    required this.legalConfig,
    required this.themeColor,
    super.key,
  });

  final PhoneAuthLegalConfig legalConfig;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: themeColor,
    );
    final legalTextStyle = resolvedTheme.legalTextStyle;
    final legalLinkStyle = resolvedTheme.legalLinkTextStyle;
    final legalJoinerStyle = legalLinkStyle.copyWith(
      decoration: TextDecoration.none,
    );

    if (!legalConfig.hasAnyLink) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: PhoneAuthLayoutDefaults.legalNoticeTopSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: PhoneAuthLayoutDefaults.legalNoticeMaxWidth,
          ),
          child: Column(
            children: [
              Text(
                PhoneAuthLegalCopyDefaults.legalAcknowledgementPrefix,
                textAlign: TextAlign.center,
                style: legalTextStyle,
              ),
              const SizedBox(
                height: PhoneAuthLayoutDefaults.legalNoticeLineSpacing,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                runSpacing: 2,
                children: [
                  if (legalConfig.hasTermsOfUse)
                    _LegalLinkText(
                      label: legalConfig.termsOfUseTitle,
                      style: legalLinkStyle,
                      onTap: () => Navigator.of(context).push(
                        PhoneAuthDocumentRoute.build(
                          title: legalConfig.termsOfUseTitle,
                          url: legalConfig.termsOfUseUrl,
                        ),
                      ),
                    ),
                  if (legalConfig.hasTermsOfUse && legalConfig.hasPrivacyPolicy)
                    Text(
                      PhoneAuthLegalCopyDefaults.legalAcknowledgementJoiner,
                      textAlign: TextAlign.center,
                      style: legalJoinerStyle,
                    ),
                  if (legalConfig.hasPrivacyPolicy)
                    _LegalLinkText(
                      label: legalConfig.privacyPolicyTitle,
                      style: legalLinkStyle,
                      onTap: () => Navigator.of(context).push(
                        PhoneAuthDocumentRoute.build(
                          title: legalConfig.privacyPolicyTitle,
                          url: legalConfig.privacyPolicyUrl,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalLinkText extends StatelessWidget {
  const _LegalLinkText({
    required this.label,
    required this.style,
    required this.onTap,
  });

  final String label;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
