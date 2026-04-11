abstract final class PhoneAuthPlatformDefaults {
  /// Code usage: method channel name shared by the Flutter hint service and the
  /// Android plugin implementation.
  static const String phoneNumberHintChannelName =
      'phone_auth/phone_number_hint';

  /// Code usage: method invoked from Dart to trigger the Android phone number
  /// hint sheet.
  static const String requestPhoneNumberHintMethod = 'requestPhoneNumberHint';

  /// Code usage: text input system method used to hide the keyboard before the
  /// phone number hint prompt is shown.
  static const String hideTextInputMethod = 'TextInput.hide';

  /// Code usage: unique prefix for registered web view factories inside the
  /// document viewer.
  static const String webDocumentViewTypePrefix = 'phone-auth-document-viewer-';

  /// Code usage: PDF fragment appended on web to reduce native browser PDF
  /// chrome.
  static const String webPdfViewerFragment =
      '#toolbar=0&navpanes=0&scrollbar=0';

  /// Code usage: debug log prefix for web document load failures.
  static const String webDocumentLoadFailureLogPrefix =
      'PhoneAuth document viewer failed to load:';

  /// Code usage: debug log prefix for native document load failures.
  static const String nativeDocumentLoadFailureLogPrefix =
      'PhoneAuth native document load failed:';
}
