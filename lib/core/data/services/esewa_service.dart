import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/payment_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';

class EsewaService {
  // pay
  Future<bool> pay(ProductEntity product, String userId) async {
    try {
      // get client id
      final String clientId = dotenv.get('ESEWA_CLIENT_ID');

      // get secret key
      final String secretKey = dotenv.get('ESEWA_SECRET_KEY');

      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          clientId: clientId,
          secretId: secretKey,
          environment: Environment.test,
        ),
        esewaPayment: EsewaPayment(
          productId: product.id!,
          productName: product.name!,
          productPrice: product.price.toString(),
          callbackUrl: "",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint("ESEWA SUCCESS :: $result");
          verifyTransactionStatus(result);
        },
        onPaymentFailure: (EsewaPaymentFailure data) {
          debugPrint("ESEWA FAILURE :: $data");
        },
        onPaymentCancellation: (data) {
          debugPrint("ESEWA CANCELLATION :: $data");
        },
      );
      return true;
    } catch (e, stackTrace) {
      return false;
    }
  }

  // verify
  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {}
}
