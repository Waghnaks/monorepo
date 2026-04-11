abstract final class PhoneAuthLegalCopyDefaults {
  /// UI usage: small acknowledgement line above the legal links in
  /// `phone_auth_legal_notice.dart`.
  static const String legalAcknowledgementPrefix =
      'By proceeding, I accept the';

  /// UI usage: joiner between the two legal links in the legal notice widget.
  static const String legalAcknowledgementJoiner = '&';

  /// UI usage: generic title when the document preview cannot be shown.
  static const String documentPreviewUnavailableTitle = 'Something went wrong.';

  /// UI usage: generic title when a document viewer fails to load.
  static const String documentLoadFailedTitle = 'Something went wrong.';

  /// UI usage: supporting message below the document load failure title.
  static const String documentLoadFailedSubtitle =
      'Please try again in a moment.';
}
