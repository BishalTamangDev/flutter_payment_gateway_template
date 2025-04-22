import 'package:dartz/dartz.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';
import 'package:payment_gateways_template/core/error/failures/failures.dart';
import 'package:payment_gateways_template/features/home/data/repositories/home_repository_impl.dart';

class HomeFetchProductsUseCase {
  final HomeRepositoryImpl homeRepository;

  HomeFetchProductsUseCase(this.homeRepository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await homeRepository.fetchProducts();
  }
}
