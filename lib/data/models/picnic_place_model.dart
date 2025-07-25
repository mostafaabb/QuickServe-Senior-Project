import '../../core/constants/app_constants.dart';

class PicnicPlace {
  final int id;
  final String name;
  final String description;
  final String location;
  final String? image;

  PicnicPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    this.image,
  });

  factory PicnicPlace.fromJson(Map<String, dynamic> json) {
    String? imagePath = json['image'];
    String? imageUrl;

    if (imagePath != null && imagePath.isNotEmpty) {
      // Construct full image URL here once
      imageUrl = '${AppConstants.baseUrl.replaceAll('/api', '')}/storage/$imagePath';
    }

    return PicnicPlace(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      location: json['location'],
      image: imageUrl, // full URL or null
    );
  }
}
