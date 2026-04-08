import 'package:auth_phone/src/foundation/layout/phone_auth_document_defaults.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:auth_phone/src/presentation/widgets/document_viewer/phone_auth_document_error_view.dart';
import 'package:auth_phone/src/presentation/widgets/document_viewer/phone_auth_document_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PhoneAuthDocumentViewer extends StatefulWidget {
  const PhoneAuthDocumentViewer({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<PhoneAuthDocumentViewer> createState() =>
      _PhoneAuthDocumentViewerState();
}

class _PhoneAuthDocumentViewerState extends State<PhoneAuthDocumentViewer> {
  bool _hasLoadError = false;
  bool _isDocumentLoaded = false;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(context);
    final viewerBackgroundColor = resolvedTheme.documentViewerBackgroundColor;

    if (_hasLoadError) {
      return ColoredBox(
        color: viewerBackgroundColor,
        child: const PhoneAuthDocumentErrorView(),
      );
    }

    return ColoredBox(
      color: viewerBackgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: SfPdfViewerTheme(
              data: SfPdfViewerThemeData(
                backgroundColor: viewerBackgroundColor,
                progressBarColor: resolvedTheme.documentLoaderColor,
              ),
              child: SfPdfViewer.network(
                widget.url,
                pageLayoutMode: PdfPageLayoutMode.continuous,
                pageSpacing: PhoneAuthDocumentDefaults.pageSpacing,
                interactionMode: PdfInteractionMode.pan,
                enableTextSelection: false,
                canShowPaginationDialog: false,
                canShowScrollHead: false,
                canShowScrollStatus: false,
                canShowPageLoadingIndicator: false,
                onDocumentLoaded: (_) {
                  if (!mounted || _isDocumentLoaded) {
                    return;
                  }
                  setState(() {
                    _isDocumentLoaded = true;
                  });
                },
                onDocumentLoadFailed: (details) {
                  debugPrint(
                    'PhoneAuth native document load failed: ${details.description}',
                  );
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    _hasLoadError = true;
                  });
                },
              ),
            ),
          ),
          if (!_isDocumentLoaded)
            Positioned.fill(
              child: ColoredBox(
                color: viewerBackgroundColor,
                child: const PhoneAuthDocumentLoadingView(),
              ),
            ),
        ],
      ),
    );
  }
}
