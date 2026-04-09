import 'package:auth_phone/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:auth_phone/src/presentation/models/phone_auth_view_config.dart';
import 'package:auth_phone/src/presentation/navigation/phone_auth_flow_route_factory.dart';
import 'package:auth_phone/src/presentation/navigation/phone_auth_route_paths.dart';
import 'package:flutter/material.dart';

class PhoneAuthFlowNavigator extends StatefulWidget {
  const PhoneAuthFlowNavigator({
    required this.controller,
    required this.config,
    super.key,
  });

  final PhoneNumberInputController controller;
  final PhoneAuthViewConfig config;

  @override
  State<PhoneAuthFlowNavigator> createState() => _PhoneAuthFlowNavigatorState();
}

class _PhoneAuthFlowNavigatorState extends State<PhoneAuthFlowNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler<void>(
      onPopWithResult: (_) {
        _navigatorKey.currentState?.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: PhoneAuthRoutePaths.phoneEntry,
        onGenerateRoute: (settings) => PhoneAuthFlowRouteFactory.build(
          settings,
          controller: widget.controller,
          config: widget.config,
        ),
      ),
    );
  }
}
