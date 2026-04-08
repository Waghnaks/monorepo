abstract final class PhoneAuthDocumentUrlResolver {
  static String resolveWebUrl(String rawUrl) {
    return rawUrl.trim();
  }

  static bool looksLikePdf(String rawUrl) {
    final trimmedUrl = rawUrl.trim();
    final uri = Uri.tryParse(trimmedUrl);

    if (uri == null) {
      return trimmedUrl.toLowerCase().contains('.pdf');
    }

    return uri.path.toLowerCase().endsWith('.pdf');
  }
}
