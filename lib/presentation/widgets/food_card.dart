import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/food_model.dart';
import '../screens/food_details_screen.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  String _imageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://via.placeholder.com/150';
    }
    final normalizedPath = path.startsWith('storage/') ? path : 'storage/$path';
    final baseUrl = AppConstants.baseUrl.replaceAll('/api', '');
    final fullUrl = '$baseUrl/$normalizedPath';
    return Uri.encodeFull(fullUrl);
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = _imageUrl(food.image);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(food: food),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${food.price.toStringAsFixed(2)} \$',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
