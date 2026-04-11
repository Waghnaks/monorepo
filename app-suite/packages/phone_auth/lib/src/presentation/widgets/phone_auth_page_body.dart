import 'package:phone_auth/src/foundation/layout/phone_auth_layout_defaults.dart';
import 'package:flutter/material.dart';

class PhoneAuthPageBody extends StatelessWidget {
  const PhoneAuthPageBody({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: PhoneAuthLayoutDefaults.contentMaxWidth,
            ),
            child: SizedBox(
              height: constraints.maxHeight,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
