import 'package:flutter/material.dart';
import '../../../data/models/food_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<FoodModel> _favorites = [];

  List<FoodModel> get favorites => List.unmodifiable(_favorites);

  void toggleFavorite(FoodModel food) {
    final exists = _favorites.any((item) => item.id == food.id);
    if (exists) {
      _favorites.removeWhere((item) => item.id == food.id);
    } else {
      _favorites.add(food);
    }
    notifyListeners();
  }

  bool isFavorite(FoodModel food) {
    return _favorites.any((item) => item.id == food.id);
  }
}
