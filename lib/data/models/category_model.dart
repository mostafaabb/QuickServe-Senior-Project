import 'package:untitled1/core/constants/app_constants.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? image;  // raw image path from backend

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  // Construct full image URL dynamically
  String? get imageUrl {
    if (image == null || image!.isEmpty) return null;
    final normalizedPath = image!.startsWith('storage/') ? image! : 'storage/$image';
    return Uri.encodeFull('${AppConstants.baseUrl.replaceAll('/api', '')}/$normalizedPath');
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],  // raw path, NOT full URL
    );
  }
}
