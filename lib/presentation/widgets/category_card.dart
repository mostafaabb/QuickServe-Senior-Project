import 'package:flutter/material.dart';
import '../../../data/models/category_model.dart';
import '../screens/category_details_screen.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryDetailsScreen(category: category),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        height: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.orange.shade100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            category.imageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                category.imageUrl!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image,
                      color: Colors.orange, size: 40);
                },
              ),
            )
                : const Icon(Icons.category, color: Colors.orange, size: 40),

            const SizedBox(height: 6),  // reduced height here

            Flexible(
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,  // added to help wrapping properly
              ),
            ),
          ],
        ),
      ),
    );
  }
}
