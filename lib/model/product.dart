class Product {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // Создание Product из JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'].toString(),
      title: json['Name'],
      description: json['Description'],
      price: (json['Price'] as num).toInt(),
      imageUrl: json['ImageURL'],
    );
  }

  // Преобразование Product в JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': int.parse(id),
      'Name': title,
      'Description': description,
      'Price': price,
      'ImageURL': imageUrl,
    };
  }
}
