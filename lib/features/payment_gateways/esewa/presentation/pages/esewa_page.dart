import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment_gateways_template/core/data/models/product_model.dart';
import 'package:payment_gateways_template/core/data/models/user_model.dart';

import '../../../../../core/data/services/esewa_service.dart';
import '../../../../../core/error/failures/failures.dart';

class EsewaPage extends StatefulWidget {
  const EsewaPage({super.key, required this.user, required this.product});

  final UserModel user;
  final ProductModel product;

  @override
  State<EsewaPage> createState() => _EsewaPageState();
}

class _EsewaPageState extends State<EsewaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Esewa")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final EsewaService service = EsewaService();
            final Either<Failure, Map<String, dynamic>> response = await service.pay(widget.product, '123');
            if (!context.mounted) return;

            response.fold(
              (failure) {
                debugPrint("FINAL FAILURE RESPONSE :: ${failure.message}");
                showDialog(context: context, builder: (context) => AlertDialog(title: const Text("Payment failure!"), content: Text(failure.message)));
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
                          Text("Merchant Name: ${data['merchantName']}"),
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
          },
          child: const Text("Pay Now"),
        ),
      ),
    );
  }
}
