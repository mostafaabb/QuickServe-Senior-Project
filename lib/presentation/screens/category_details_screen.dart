import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled1/data/models/category_model.dart';
import 'package:untitled1/data/models/food_model.dart';
import 'package:untitled1/presentation/providers/food_provider.dart';
import 'package:untitled1/presentation/widgets/food_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoryModel category;
  const CategoryDetailsScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    // Filter foods by category id
    final List<FoodModel> categoryFoods = foodProvider.foods
        .where((food) => food.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: categoryFoods.isEmpty
          ? const Center(child: Text('No foods available in this category.'))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: categoryFoods.length,
        itemBuilder: (context, index) =>
            FoodCard(food: categoryFoods[index]),
      ),
    );
  }
}
