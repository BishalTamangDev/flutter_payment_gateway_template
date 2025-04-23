import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:payment_gateways_template/core/business/entities/product_entity.dart';
import 'package:payment_gateways_template/features/home/data/repositories/home_repository_impl.dart';
import 'package:payment_gateways_template/features/home/domain/usecases/home_fetch_products_usecase.dart';
import 'package:payment_gateways_template/features/home/presentation/widgets/product_widget.dart';

import '../../../../core/error/failures/failures.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  late Future<Either<Failure, List<ProductEntity>>> _products;

  // functions
  // fetch products
  Future<Either<Failure, List<ProductEntity>>> _fetchProducts() async {
    return await HomeFetchProductsUseCase(HomeRepositoryImpl()).call();
  }

  @override
  void initState() {
    super.initState();
    _products = _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products"), elevation: 0, centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Either<Failure, List<ProductEntity>>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error :: ${snapshot.error}"));
                } else {
                  final result = snapshot.data;
                  return result!.fold(
                    (failure) {
                      return Center(child: Text(failure.message));
                    },
                    (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ProductWidget(product: data[index]),
                      );
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
