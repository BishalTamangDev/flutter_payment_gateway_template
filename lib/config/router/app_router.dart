import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';
import 'package:payment_gateways_template/features/home/presentation/pages/home_page.dart';
import 'package:payment_gateways_template/features/product_details/presentations/pages/product_details.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/product-details',
        builder: (context, state) {
          final ProductEntity product = state.extra as ProductEntity;
          return ProductDetails(product: product);
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Column(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Page Not Found"),
              OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
