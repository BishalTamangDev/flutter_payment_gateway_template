import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:payment_gateways_template/core/data/models/product_model.dart';
import 'package:payment_gateways_template/core/data/models/user_model.dart';

class KhaltiPage extends StatefulWidget {
  const KhaltiPage({super.key, required this.user, required this.product});

  final ProductModel product;
  final UserModel user;

  @override
  State<KhaltiPage> createState() => _KhaltiPageState();
}

class _KhaltiPageState extends State<KhaltiPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Khalti")), body: Center(child: ElevatedButton(onPressed: _payWithKhalti, child: const Text("Pay Now"))));
  }

  _payWithKhalti() {
    KhaltiScope.of(context).pay(
      preferences: [PaymentPreference.khalti],
      config: PaymentConfig(amount: (widget.product.price! * 100).toInt(), productIdentity: widget.product.id!, productName: widget.product.name!),
      onSuccess: (PaymentSuccessModel result) {
        debugPrint("KHALTI RESPONSE SUCCESS :: $result");
      },
      onFailure: (PaymentFailureModel result) {
        debugPrint("KHALTI RESPONSE FAILURE :: $result");
      },
      onCancel: () {
        debugPrint("KHALTI RESPONSE CANCELLED");
      },
    );
  }
}
