import 'package:dartz/dartz.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';

import '../../../../core/error/failures/failures.dart';

abstract class HomeRepository {
  // fetch products
  Future<Either<Failure, List<ProductEntity>>> fetchProducts();
}
