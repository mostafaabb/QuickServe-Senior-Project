import 'package:flutter/material.dart';
import '../../data/datasources/api_service.dart';
import '../../data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  String? _token;
  String? get token => _token;

  UserModel? _user;
  UserModel? get user => _user;

  bool get isLoggedIn => _token != null;

  /// Login
  Future<bool> login(String email, String password) async {
    try {
      final result = await apiService.login(email, password);

      if (result != null && result['token'] != null) {
        _token = result['token'];
        _user = UserModel.fromJson(result['user']);
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return false;
  }

  /// Register
  Future<bool> register(String name, String email, String password) async {
    try {
      final result = await apiService.register(name, email, password);

      if (result != null && result['token'] != null) {
        _token = result['token'];
        _user = UserModel.fromJson(result['user']);
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Register error: $e');
    }
    return false;
  }

  /// Logout
  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }


  Future<void> loadToken() async {

    _token = null;
    notifyListeners();
  }
}
