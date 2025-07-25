import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/models/picnic_place_model.dart';
import '../../core/constants/app_constants.dart';

class PicnicPlaceProvider with ChangeNotifier {
  List<PicnicPlace> _places = [];
  bool _isLoading = false;

  List<PicnicPlace> get places => _places;
  bool get isLoading => _isLoading;

  Future<void> fetchPicnicPlaces() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(AppConstants.picnicPlaces));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _places = data.map((item) => PicnicPlace.fromJson(item)).toList();
      } else {
        print('Failed to load picnic places: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching picnic places: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
