class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String pet;
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.pet,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
      category: json['category'],
      pet: json['pet'],
    );
  }
}
