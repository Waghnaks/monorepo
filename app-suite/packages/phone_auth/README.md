# phone_auth

Config-driven phone authentication package for Flutter.

This package provides:

- phone number entry
- OTP send and verify flow
- resend timer
- legal document links
- Android phone number hint support
- app-level theming through `PhoneAuthThemeExtension`

The package now uses a single `PhoneAuthConfig` object instead of passing many
constructor parameters individually.

## Public API

Import:

```dart
import 'package:phone_auth/phone_auth.dart';
```

Main widget:

```dart
PhoneAuth(
  config: yourPhoneAuthConfig,
)
```

Exported models:

- `PhoneAuth`
- `PhoneAuthConfig`
- `PhoneAuthApiConfig`
- `PhoneAuthLegalConfig`
- `PhoneAuthSession`
- `PhoneNumberResult`
- `PhoneAuthThemeExtension`
- `PhoneNumberInputController`

## Recommended App Setup

Keep auth configuration in one app-level config file.

Example:

```dart
import 'package:phone_auth/phone_auth.dart';

import 'app_info.dart';

abstract final class PartnerPhoneAuthConfig {
  static const PhoneAuthConfig config = PhoneAuthConfig(
    appName: AppInfo.brandName,
    tagLine: AppInfo.tagLine,
    userPhoneAuth: true,
    apiConfig: PhoneAuthApiConfig(
      sendOtpEndpoint: '/partner/auth/send-otp',
      verifyOtpEndpoint: '/partner/auth/verify-otp',
    ),
    legalConfig: PhoneAuthLegalConfig(
      termsOfUseUrl: 'https://example.com/terms',
      privacyPolicyUrl: 'https://example.com/privacy',
    ),
  );
}
```

Then use it in your app:

```dart
import 'package:flutter/material.dart';
import 'package:phone_auth/phone_auth.dart';

import 'config/app_info.dart';
import 'config/phone_auth_config.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInfo.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PhoneAuth(
        config: PartnerPhoneAuthConfig.config,
      ),
    );
  }
}
```

## PhoneAuthConfig

`PhoneAuthConfig` is the main integration model.

Fields:

- `appName`
  Used in branded layouts and OTP app bar title.
- `tagLine`
  Optional supporting branding text on the phone screen.
- `userPhoneAuth`
  Controls which phone screen layout the package uses.
- `themeColor`
  Optional accent override for buttons and active states.
- `initialCountry`
  Initial country for the phone input field.
- `apiConfig`
  Endpoint configuration for send/verify OTP.
- `legalConfig`
  Terms and privacy document configuration.
- `onVerificationSuccess`
  Callback after successful OTP verification.
- `resendIntervalSeconds`
  Resend cooldown in seconds.

## API Config

Use `PhoneAuthApiConfig` for endpoint setup:

```dart
const PhoneAuthApiConfig(
  sendOtpEndpoint: '/partner/auth/send-otp',
  verifyOtpEndpoint: '/partner/auth/verify-otp',
)
```

## Legal Config

Use `PhoneAuthLegalConfig` to enable the legal notice and document pages:

```dart
const PhoneAuthLegalConfig(
  termsOfUseUrl: 'https://example.com/terms',
  privacyPolicyUrl: 'https://example.com/privacy',
)
```

Optional titles:

```dart
const PhoneAuthLegalConfig(
  termsOfUseUrl: 'https://example.com/terms',
  privacyPolicyUrl: 'https://example.com/privacy',
  termsOfUseTitle: 'Terms of Use',
  privacyPolicyTitle: 'Privacy Policy',
)
```

## Success Callback

Use `onVerificationSuccess` if the app needs the verified session:

```dart
PhoneAuthConfig(
  onVerificationSuccess: (session) {
    debugPrint(session.phoneNumber);
    debugPrint(session.verificationId);
  },
)
```

## Theming

The package reads `PhoneAuthThemeExtension` from your app theme.

Example:

```dart
ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    PhoneAuthThemeExtension(
      brandTextStyle: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
      ),
      headingTextStyle: const TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w800,
      ),
      supportingTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyEmphasisTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      legalTextStyle: const TextStyle(
        fontSize: 12,
      ),
      legalLinkTextStyle: const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    ),
  ],
)
```

Common extension fields:

- `brandTextStyle`
- `tagLineTextStyle`
- `headingTextStyle`
- `supportingTextStyle`
- `bodyEmphasisTextStyle`
- `actionTextStyle`
- `valueTextStyle`
- `fieldLabelTextStyle`
- `fieldHintTextStyle`
- `legalTextStyle`
- `legalLinkTextStyle`
- `documentTitleTextStyle`
- `accentTitleTextStyle`
- `surfaceMutedColor`
- `outlineColor`
- `mutedForegroundColor`
- `dangerColor`
- `documentBackgroundColor`
- `documentViewerBackgroundColor`
- `documentLoaderColor`

## Layout Modes

`userPhoneAuth` controls the phone screen layout mode:

- `true`
  Branded returning-user style.
- `false`
  Welcome-style new-user layout.

If `appName` is missing, the package falls back to the centered default title
and subtitle:

- `Enter your mobile number`
- `We will send a one-time password to verify your number.`

## Android Phone Number Hint

On Android, the phone field can request the system phone number hint on first
tap when the field is empty.

This is handled internally by the package plugin and does not require extra app
code beyond normal package setup.

## Package Structure

Current structure inside this package:

- `lib/src/application`
  Shared flow state, controller, and providers.
- `lib/src/data`
  Datasource, repository implementation, platform services.
- `lib/src/domain`
  Public config/session models, repository contracts, validation.
- `lib/src/foundation`
  Copy, layout defaults, theme defaults, platform/debug constants.
- `lib/src/presentation`
  Screens, widgets, navigation, resolved theme logic.

## Notes

- Keep app-specific setup in your app config folder, not inside widgets.
- Prefer using `PhoneAuthConfig` from one place per app.
- Prefer theme overrides in the app theme, not hardcoded widget values.
- Legal links are optional. If `legalConfig` is null, the legal footer is not
  shown.
