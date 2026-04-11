import 'package:phone_auth/src/foundation/layout/phone_auth_document_defaults.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:flutter/cupertino.dart';

class PhoneAuthDocumentLoadingView extends StatelessWidget {
  const PhoneAuthDocumentLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(context);

    return Center(
      child: CupertinoActivityIndicator(
        radius: PhoneAuthDocumentDefaults.loaderRadius,
        color: resolvedTheme.documentLoaderColor,
      ),
    );
  }
}
