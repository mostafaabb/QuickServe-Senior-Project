class FoodModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String? image;
  final int categoryId;

  FoodModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.image,
    required this.categoryId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}
