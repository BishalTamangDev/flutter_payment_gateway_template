import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:payment_gateways_template/config/router/app_router.dart';
import 'package:payment_gateways_template/config/theme/app_theme.dart';

class PaymentGatewaysApp extends StatelessWidget {
  const PaymentGatewaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: '__live_public_key__',
      enabledDebugging: true,
      navigatorKey: AppRouter.rootNavigatorKey,
      builder: (context, navKey) {
        return MaterialApp.router(
          // routerConfig: AppRouter.router,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          title: 'Payment Gateways',
          debugShowCheckedModeBanner: true,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: [KhaltiLocalizations.delegate],
        );
      },
    );
  }
}
