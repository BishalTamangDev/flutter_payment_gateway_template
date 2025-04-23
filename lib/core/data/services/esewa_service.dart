import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/payment_failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';
import 'package:payment_gateways_template/core/error/failures/failures.dart';

class EsewaService {
  // pay
  Future<Either<Failure, Map<String, dynamic>>> pay(ProductEntity product, String userId) async {
    final completer = Completer<Either<Failure, Map<String, dynamic>>>();
    try {
      // get client id
      final String clientId = dotenv.get('ESEWA_CLIENT_ID');

      // get secret key
      final String secretKey = dotenv.get('ESEWA_SECRET_KEY');

      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(clientId: clientId, secretId: secretKey, environment: Environment.test),
        esewaPayment: EsewaPayment(productId: product.id!, productName: product.name!, productPrice: product.price.toString(), callbackUrl: ""),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint("ESEWA SUCCESS :: $result");

          completer.complete(
            Right({
              'message': result.message ?? '',
              'productId': result.productId ?? '',
              'totalAmount': result.totalAmount ?? '',
              'refId': result.refId ?? '',
              'code': result.code ?? '',
              'date': result.date ?? DateTime.now(),
            }),
          );
          // verifyTransactionStatus(result);
        },
        onPaymentFailure: (EsewaPaymentFailure data) {
          debugPrint("ESEWA FAILURE :: $data");
          completer.complete(Left(Failure(message: "Payment failed!")));
        },
        onPaymentCancellation: (data) {
          debugPrint("ESEWA CANCELLATION :: $data");
          completer.complete(Left(Failure(message: "Payment cancelled!")));
        },
      );
    } catch (e, stackTrace) {
      debugPrint("ERROR IN ESEWA PAYMENT :: $e\n$stackTrace");
      completer.complete(Left(Failure(message: "Something went wrong!")));
    }
    return await completer.future;
  }

  // verify
  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {}
}
