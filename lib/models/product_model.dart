

class ProductModel{

  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image']?.toString() ?? '',
    );
  }
}