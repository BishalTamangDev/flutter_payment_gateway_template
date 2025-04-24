import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/data/models/product_model.dart';
import 'package:payment_gateways_template/features/home/presentation/pages/home_page.dart';
import 'package:payment_gateways_template/features/independent_pages/page_not_found.dart';
import 'package:payment_gateways_template/features/payment_gateways/esewa/presentation/pages/esewa_page.dart';
import 'package:payment_gateways_template/features/payment_gateways/khalti/presentation/pages/khalti_page.dart';
import 'package:payment_gateways_template/features/product_details/presentations/pages/product_details.dart';

import '../../core/data/models/user_model.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/product-details',
        builder: (context, state) {
          final ProductModel product = state.extra as ProductModel;
          return ProductDetails(product: product);
        },
      ),
      GoRoute(
        path: '/payment-gateways',
        builder: (context, state) => PageNotFound(),
        routes: [
          GoRoute(
            path: '/esewa',
            builder: (context, state) {
              final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
              final UserModel user = data['user'];
              final ProductModel product = data['product'];
              return EsewaPage(user: user, product: product);
            },
          ),
          GoRoute(
            path: '/khalti',
            builder: (context, state) {
              final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
              final UserModel user = data['user'];
              final ProductModel product = data['product'];
              return KhaltiPage(user: user, product: product);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
