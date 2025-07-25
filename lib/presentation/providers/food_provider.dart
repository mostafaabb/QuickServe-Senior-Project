import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../../data/models/food_model.dart';
import '../../data/models/offer_model.dart';
import '../../data/datasources/api_service.dart';

class FoodProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<FoodModel> _foods = [];
  List<FoodModel> get foods => _foods;

  List<OfferModel> _offers = [];
  List<OfferModel> get offers => _offers;

  // Add this getter for trending foods
  List<FoodModel> get trendingFoods {
    // Return first 5 foods as a simple example
    return _foods.take(5).toList();
  }

  // Fetch categories individually
  Future<void> fetchCategories() async {
    _categories = await _apiService.fetchCategories();
    notifyListeners();
  }

  // Fetch foods individually
  Future<void> fetchFoods() async {
    _foods = await _apiService.fetchFoods();
    notifyListeners();
  }

  // Fetch offers individually
  Future<void> fetchOffers() async {
    _offers = await _apiService.fetchOffers();
    notifyListeners();
  }

  // Combined method to fetch all at once
  Future<void> fetchAllData() async {
    try {
      await Future.wait([
        fetchCategories(),
        fetchFoods(),
        fetchOffers(),
      ]);
    } catch (e) {
      print('Error fetching data in fetchAllData: $e');
    }
  }
}
