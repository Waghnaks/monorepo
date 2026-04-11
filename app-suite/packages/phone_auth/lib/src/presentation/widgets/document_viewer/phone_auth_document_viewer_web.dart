// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:phone_auth/src/foundation/layout/phone_auth_document_defaults.dart';
import 'package:phone_auth/src/foundation/platform/phone_auth_platform_defaults.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/utils/phone_auth_document_url_resolver.dart';
import 'package:phone_auth/src/presentation/widgets/document_viewer/phone_auth_document_error_view.dart';
import 'package:phone_auth/src/presentation/widgets/document_viewer/phone_auth_document_loading_view.dart';
import 'package:flutter/material.dart';

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
  static int _nextViewId = 0;

  late final String _viewType;
  late final html.Element _documentElement;
  late final bool _isPdfDocument;
  Timer? _loadTimeout;
  Timer? _pdfReadyFallback;
  bool _isLoaded = false;
  bool _hasLoadError = false;

  @override
  void initState() {
    super.initState();
    _viewType =
        '${PhoneAuthPlatformDefaults.webDocumentViewTypePrefix}${_nextViewId++}';
    final resolvedUrl = PhoneAuthDocumentUrlResolver.resolveWebUrl(widget.url);
    _isPdfDocument = PhoneAuthDocumentUrlResolver.looksLikePdf(widget.url);

    if (_isPdfDocument) {
      final frame = html.IFrameElement()
        ..src = '$resolvedUrl${PhoneAuthPlatformDefaults.webPdfViewerFragment}'
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflow = 'hidden'
        ..style.setProperty('color-scheme', 'light')
        ..allowFullscreen = true;
      frame.setAttribute('loading', 'eager');
      frame.onLoad.listen((_) {
        _markLoaded();
      });
      _pdfReadyFallback = Timer(
        const Duration(milliseconds: 900),
        _markLoaded,
      );
      _documentElement = frame;
    } else {
      final frame = html.IFrameElement()
        ..src = resolvedUrl
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflow = 'hidden'
        ..style.setProperty('color-scheme', 'light')
        ..allowFullscreen = true;
      frame.setAttribute('loading', 'eager');

      frame.onLoad.listen((_) {
        _markLoaded();
      });

      frame.onError.listen((_) {
        _handleLoadFailure();
      });

      _loadTimeout = Timer(
        PhoneAuthDocumentDefaults.webDocumentLoadTimeout,
        _handleLoadFailure,
      );
      _documentElement = frame;
    }

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (_) => _documentElement,
    );
  }

  void _markLoaded() {
    _loadTimeout?.cancel();
    _pdfReadyFallback?.cancel();
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoaded = true;
      _hasLoadError = false;
    });
  }

  void _handleLoadFailure() {
    if (!mounted || _isLoaded) {
      return;
    }
    debugPrint(
      '${PhoneAuthPlatformDefaults.webDocumentLoadFailureLogPrefix} ${widget.url}',
    );
    setState(() {
      _hasLoadError = true;
    });
  }

  @override
  void dispose() {
    _loadTimeout?.cancel();
    _pdfReadyFallback?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(context);
    final viewerBackgroundColor = resolvedTheme.documentViewerBackgroundColor;
    _documentElement.style.backgroundColor = _cssColor(viewerBackgroundColor);

    if (_hasLoadError) {
      return ColoredBox(
        color: viewerBackgroundColor,
        child: const PhoneAuthDocumentErrorView(),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: viewerBackgroundColor,
            child: ClipRect(
              child: HtmlElementView(viewType: _viewType),
            ),
          ),
        ),
        if (!_isLoaded)
          Positioned.fill(
            child: ColoredBox(
              color: viewerBackgroundColor,
              child: const PhoneAuthDocumentLoadingView(),
            ),
          ),
      ],
    );
  }

  String _cssColor(Color color) {
    final value = color.toARGB32();
    final rgb = value & 0x00FFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0')}';
  }
}
