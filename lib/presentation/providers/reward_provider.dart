import 'package:flutter/material.dart';
import 'package:untitled1/data/datasources/api_service.dart';
import 'package:untitled1/data/models/reward_model.dart';

class RewardProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<RewardModel> _rewards = [];
  List<RewardModel> get rewards => _rewards;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double _totalDiscountAmount = 0;
  double get totalDiscountAmount => _totalDiscountAmount;

  Future<void> fetchRewards() async {
    _isLoading = true;
    notifyListeners();

    try {
      _rewards = await _apiService.fetchRewards();

      _totalDiscountAmount = _rewards.fold(
          0, (sum, reward) => sum + reward.discountAmount);

    } catch (e) {
      print('Error fetching rewards: $e');
      _rewards = [];
      _totalDiscountAmount = 0;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addReward({
    required int userId,
    required String title,
    required String code,
    required double discountAmount,
  }) async {
    try {
      final newReward = await _apiService.addReward(
        userId: userId,
        title: title,
        code: code,
        discountAmount: discountAmount,
      );

      _rewards.insert(0, newReward);
      _totalDiscountAmount += discountAmount;

      notifyListeners();
    } catch (e) {
      print('Error adding reward: $e');
    }
  }
}
