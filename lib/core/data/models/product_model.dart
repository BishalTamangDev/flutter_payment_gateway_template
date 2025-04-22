import 'package:payment_gateways_template/core/business/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.stock,
    required super.quantity,
  });

  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0.0,
      stock: json['stock'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
  };

  // from entity
  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    name: entity.name,
    price: entity.price,
    stock: entity.stock,
    quantity: entity.quantity,
  );

  // to entity
  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    price: price,
    stock: stock,
    quantity: quantity,
  );

  // to string
  @override
  String toString() =>
      "ProductModel{id: $id, name: $name, price: $price, stock: $stock, quantity: $quantity}";
}
