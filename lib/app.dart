import 'package:flutter/material.dart';
import 'package:payment_gateways_template/config/router/app_router.dart';
import 'package:payment_gateways_template/config/theme/app_theme.dart';

class PaymentGatewaysApp extends StatelessWidget {
  const PaymentGatewaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Payment Gateways',
      debugShowCheckedModeBanner: true,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
