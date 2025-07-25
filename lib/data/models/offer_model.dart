import '../../core/constants/app_constants.dart';
class OfferModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final double discount;
  final String startDate;
  final String endDate;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.discount,
    required this.startDate,
    required this.endDate,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      discount: double.tryParse(json['discount'].toString()) ?? 0.0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
    );
  }

  // Add this getter:
  String get imageUrl {
    if (image.isEmpty) {
      return 'https://via.placeholder.com/150'; // fallback image
    }

    // Assume image path might start with 'storage/' or not:
    final normalizedPath = image.startsWith('storage/') ? image : 'storage/$image';

    // Use your app's base URL without '/api':
    final baseUrl = AppConstants.baseUrl.replaceAll('/api', '');

    return Uri.encodeFull('$baseUrl/$normalizedPath');
  }
}
