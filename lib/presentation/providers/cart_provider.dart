import 'package:flutter/material.dart';
import '../../data/models/food_model.dart';

class CartItemModel {
  final FoodModel food;
  int quantity;

  CartItemModel({required this.food, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  double get totalPrice => _items.fold(0, (sum, item) => sum + (item.food.price * item.quantity));

  void addToCart(FoodModel food, [int quantity = 1]) {
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItemModel(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(FoodModel food) {
    _items.removeWhere((item) => item.food.id == food.id);
    notifyListeners();
  }

  void updateQuantity(FoodModel food, int newQuantity) {
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(FoodModel food) {
    return _items.any((item) => item.food.id == food.id);
  }
}
