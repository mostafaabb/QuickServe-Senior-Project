import 'package:flutter/material.dart';
import 'package:untitled1/data/datasources/api_service.dart';
import 'package:untitled1/data/models/rating.dart';

class RatingProvider extends ChangeNotifier {
  final ApiService apiService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Rating? _savedRating;
  Rating? get savedRating => _savedRating;

  RatingProvider({required this.apiService});

  Future<bool> submitRating(Rating rating) async {
    _isLoading = true;
    _errorMessage = null;
    _savedRating = null;
    notifyListeners();

    try {
      final Rating? response = await apiService.submitRating(rating);
      _isLoading = false;

      if (response != null) {
        _savedRating = response;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to submit rating';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error submitting rating: $e';
      notifyListeners();
      return false;
    }
  }
}
