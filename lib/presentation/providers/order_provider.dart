import 'package:flutter/material.dart';
import 'package:untitled1/data/models/order_model.dart';
import 'package:untitled1/data/datasources/api_service.dart';

class OrderProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  Future<bool> submitOrder(OrderModel order) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final success = await ApiService().createOrder(order);
      if (success) {
        _message = 'Order submitted successfully!';
      } else {
        _message = 'Failed to submit order.';
      }
      return success;
    } catch (e) {
      _message = 'Error: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
