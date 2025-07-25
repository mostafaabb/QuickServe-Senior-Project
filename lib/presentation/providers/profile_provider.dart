import 'package:flutter/material.dart';
import 'package:untitled1/data/models/user_model.dart';
import 'package:untitled1/data/datasources/api_service.dart';

class ProfileProvider with ChangeNotifier {
  final ApiService apiService;

  ProfileProvider({required this.apiService});

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchProfile(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedUser = await apiService.fetchProfile(userId);
      if (fetchedUser == null) {
        _error = 'Profile not found';
      } else {
        _user = fetchedUser;
      }
    } catch (e) {
      _error = 'Failed to load profile: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(String name, String email) async {
    if (_user == null) {
      _error = 'No profile loaded';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    // Create updated user object
    UserModel updatedUser = UserModel(
      id: _user!.id,
      name: name,
      email: email,
    );

    final success = await apiService.updateProfile(updatedUser);

    if (success) {
      _user = updatedUser;
      _error = null;
    } else {
      _error = 'Failed to update profile';
    }

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
