import 'package:flutter/material.dart';

import 'package:auth_phone/auth_phone.dart';

import 'config/app_info.dart';
import 'config/phone_auth_config.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInfo.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PhoneAuth(
        appName: AppInfo.brandName,
        tagLine: AppInfo.tagLine,
        apiConfig: PartnerPhoneAuthConfig.apiConfig,
        legalConfig: PartnerPhoneAuthConfig.legalConfig,
      ),
    );
  }
}
