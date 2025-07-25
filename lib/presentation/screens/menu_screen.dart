import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart'; // Import your AppConstants
import '../../../data/datasources/api_service.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/food_model.dart';
import '../widgets/category_card.dart';

class MenuScreen extends StatefulWidget {
  final int? categoryId;
  const MenuScreen({super.key, this.categoryId});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<FoodModel>> _foods;
  late Future<List<CategoryModel>> _categories;

  @override
  void initState() {
    super.initState();
    _foods = ApiService().fetchFoods();
    _categories = ApiService().fetchCategories();
  }

  String _imageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://via.placeholder.com/100';
    }
    final normalizedPath = path.startsWith('storage/') ? path : 'storage/$path';
    final baseUrl = AppConstants.baseUrl.replaceAll('/api', ''); // Remove /api if present
    final fullUrl = '$baseUrl/$normalizedPath';
    return Uri.encodeFull(fullUrl);
  }

  Widget _buildFoodCard(FoodModel food) {
    final imageUrl = _imageUrl(food.image);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.fastfood);
            },
          ),
        ),
        title: Text(
          food.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          food.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '\$${food.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryId == null ? 'All Foods' : 'Category Foods'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<List<CategoryModel>>(
            future: _categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 120,
                  child: Center(child: Text('Error loading categories')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: Text('No categories found')),
                );
              }

              final categories = snapshot.data!;
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: CategoryCard(category: categories[index]),
                    );
                  },
                ),
              );
            },
          ),
          Expanded(
            child: FutureBuilder<List<FoodModel>>(
              future: _foods,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items available'));
                }

                final filteredFoods = widget.categoryId == null
                    ? snapshot.data!
                    : snapshot.data!.where((food) => food.categoryId == widget.categoryId).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredFoods.length,
                  itemBuilder: (context, index) {
                    return _buildFoodCard(filteredFoods[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
