import 'package:flutter/material.dart';
import '../../data/models/driver_request.dart';
import '../../data/datasources/api_service.dart';

class DriverRequestProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  Future<bool> submitDriverRequest(DriverRequest request) async {
    _isSubmitting = true;
    notifyListeners();

    bool success = false;
    try {
      success = await _apiService.createDriverRequest(request);
    } catch (e) {
      print('Error submitting driver request: $e');
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }

    return success;
  }
}
