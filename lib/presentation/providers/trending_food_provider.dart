import 'package:flutter/foundation.dart';
import 'package:untitled1/data/models/food_model.dart';
import 'package:untitled1/data/datasources/api_service.dart';

class TrendingFoodProvider with ChangeNotifier {
  final ApiService apiService;
  TrendingFoodProvider(this.apiService);

  List<FoodModel> _trendingFoods = [];
  List<FoodModel> get trendingFoods => _trendingFoods;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchTrendingFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trendingFoods = await apiService.fetchTrendingFoods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
