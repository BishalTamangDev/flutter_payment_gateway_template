import 'package:dartz/dartz.dart';
import 'package:payment_gateways_template/core/data/models/product_model.dart';
import 'package:payment_gateways_template/core/error/failures/failures.dart';
import 'package:payment_gateways_template/features/home/data/repositories/home_repository_impl.dart';

class HomeFetchProductsUseCase {
  final HomeRepositoryImpl homeRepository;

  HomeFetchProductsUseCase(this.homeRepository);

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await homeRepository.fetchProducts();
  }
}
