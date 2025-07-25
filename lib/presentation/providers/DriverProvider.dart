import 'package:flutter/material.dart';
import '../../data/models/driver.dart';
import '../../data/datasources/api_service.dart';

class DriverProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Driver> _drivers = [];
  bool _isLoading = false;

  List<Driver> get drivers => _drivers;
  bool get isLoading => _isLoading;

  Future<void> fetchDrivers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _drivers = await _apiService.fetchDrivers();
    } catch (e) {
      print('Error fetching drivers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
