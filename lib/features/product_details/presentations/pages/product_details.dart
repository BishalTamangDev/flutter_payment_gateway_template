import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';
import 'package:payment_gateways_template/core/data/services/esewa_service.dart';
import 'package:payment_gateways_template/core/error/failures/failures.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final ProductEntity product;

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
                                    if (paymentGateways[index]['name'].toString().toLowerCase() == 'esewa') {
                                      final EsewaService service = EsewaService();
                                      final Either<Failure, Map<String, dynamic>> response = await service.pay(widget.product, '123');
                                      if (!context.mounted) return;
                                      context.pop();

                                      response.fold(
                                        (failure) {
                                          debugPrint("FINAL FAILURE RESPONSE :: ${failure.message}");
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(title: const Text("Payment failure!"), content: Text(failure.message)),
                                          );
                                        },
                                        (data) {
                                          debugPrint("FINAL SUCCESS RESPONSE :: $data");
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Payment successful!"),
                                                content: Column(
                                                  spacing: 16.0,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("Product Id: ${data['productId']}"),
                                                    Text("Total amount: ${data['totalAmount']}"),
                                                    Text("Ref Id: ${data['refId']}"),
                                                    Text("Code: ${data['code']}"),
                                                    Text("Date: ${data['date']}"),
                                                  ],
                                                ),
                                                actions: [OutlinedButton(onPressed: () => context.pop(), child: const Text("Great!"))],
                                              );
                                            },
                                          );
                                        },
                                      );
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
