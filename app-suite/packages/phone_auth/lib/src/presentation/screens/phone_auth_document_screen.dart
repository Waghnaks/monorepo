import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/widgets/document_viewer/phone_auth_document_viewer.dart';
import 'package:flutter/material.dart';

class PhoneAuthDocumentScreen extends StatelessWidget {
  const PhoneAuthDocumentScreen({
    required this.title,
    required this.url,
    super.key,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(context);

    return Scaffold(
      backgroundColor: resolvedTheme.documentViewerBackgroundColor,
      appBar: AppBar(
        backgroundColor: resolvedTheme.documentViewerBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: resolvedTheme.documentTitleTextStyle,
        ),
        centerTitle: false,
      ),
      body: PhoneAuthDocumentViewer(url: url),
    );
  }
}
