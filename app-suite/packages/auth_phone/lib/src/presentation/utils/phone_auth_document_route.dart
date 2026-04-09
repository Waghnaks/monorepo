import 'package:auth_phone/src/presentation/navigation/phone_auth_page_route.dart';
import 'package:auth_phone/src/presentation/screens/phone_auth_document_screen.dart';
import 'package:flutter/material.dart';

abstract final class PhoneAuthDocumentRoute {
  static Route<void> build({
    required String title,
    required String url,
  }) {
    return PhoneAuthPageRoute.build<void>(
      child: PhoneAuthDocumentScreen(title: title, url: url),
    );
  }
}
