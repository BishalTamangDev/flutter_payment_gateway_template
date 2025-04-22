class ProductEntity {
  String? id;
  String? name;
  double? price;
  int? stock;
  int? quantity;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.quantity,
  });

  // to string
  @override
  String toString() =>
      "ProductEntity{id: $id, name: $name, price: $price, stock: $stock, quantity: $quantity}";
}
