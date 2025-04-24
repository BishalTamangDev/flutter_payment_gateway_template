import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:payment_gateways_template/core/data/models/product_model.dart';
import 'package:payment_gateways_template/core/error/failures/failures.dart';
import 'package:payment_gateways_template/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      // fetch products
      final String jsonString = await rootBundle.loadString('lib/core/data/sources/products.json');

      final List<dynamic> jsonData = jsonDecode(jsonString);

      List<ProductModel> products = [];

      for (var datum in jsonData) {
        final ProductModel product = ProductModel.fromJson(datum);
        products.add(product);
      }

      return Right(products);
    } catch (e, stackTrace) {
      debugPrint("Error fetching products :: $e\n$stackTrace");
      return Left(Failure(message: e.toString()));
    }
  }
}
