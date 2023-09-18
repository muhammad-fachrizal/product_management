class Product {
  String id;
  String title;
  String description;
  num price;
  int stock;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(dynamic json) => Product(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as num,
        stock: json['stock'] as int,
      );

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, stock: $stock)';
  }
}
