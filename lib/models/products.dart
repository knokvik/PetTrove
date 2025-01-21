class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String pet;
  final String imagePath;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.pet,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'pet': pet,
      'imagePath': imagePath,
    };
  }


  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
      category: json['category'],
      pet: json['pet'],
    );
  }
}
