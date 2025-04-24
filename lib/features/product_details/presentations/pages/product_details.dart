import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/data/models/user_model.dart';

import '../../../../core/data/models/product_model.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // variables
  final List<Map<String, dynamic>> paymentGateways = [
    {'name': 'Esewa', 'image': 'esewa.webp'},
    {'name': 'Khalti', 'image': 'khalti.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // product details
            // id
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("ID"), Text("${widget.product.id}", style: Theme.of(context).textTheme.titleMedium)],
            ),

            // name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Name"), Text("${widget.product.name}", style: Theme.of(context).textTheme.titleMedium)],
            ),

            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Price"), Text("\$${widget.product.price}", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.green))],
            ),

            // stock
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Stock"), Text("${widget.product.stock}", style: Theme.of(context).textTheme.titleMedium)],
            ),

            // quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Quantity"), Text("${widget.product.quantity}", style: Theme.of(context).textTheme.titleMedium)],
            ),

            // divider
            Divider(height: 5.0, color: Theme.of(context).colorScheme.secondary),

            // buy now
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  // proceed
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    useSafeArea: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 12.0,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Select Payment Options", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: paymentGateways.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    final Map<String, dynamic> data = {'user': UserModel(id: '1', name: 'bishal tamang'), 'product': widget.product};
                                    context.pop();
                                    if (paymentGateways[index]['name'].toString().toLowerCase() == 'esewa') {
                                      context.push('/payment-gateways/esewa', extra: data);
                                    } else if (paymentGateways[index]['name'].toString().toLowerCase() == 'khalti') {
                                      context.push('/payment-gateways/khalti', extra: data);
                                    }
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        spacing: 16.0,
                                        children: [
                                          Image.asset("assets/logos/${paymentGateways[index]['image']}", width: 50.0, height: 50.0),
                                          Text(paymentGateways[index]['name']),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("BUY NOW"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
