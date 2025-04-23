import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/product-details', extra: product),
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${product.name}", style: Theme.of(context).textTheme.titleLarge),
                  Opacity(opacity: 0.6, child: Text("Only ${product.stock ?? 0} left.", style: Theme.of(context).textTheme.bodyMedium)),
                ],
              ),
              Text("\$${product.price}", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.green.shade500)),
            ],
          ),
        ),
      ),
    );
  }
}
