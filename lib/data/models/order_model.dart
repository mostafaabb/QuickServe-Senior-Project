import 'dart:convert';
import 'order_model.dart'; // or wherever OrderedFood is

class OrderModel {
  final int? id;
  final int userId;
  final String customerName;       // NEW: customer's name
  final String deliveryAddress;
  final String status;
  final double totalPrice;
  final List<OrderedFood> foods;

  OrderModel({
    this.id,
    required this.userId,
    required this.customerName,       // NEW required field
    required this.deliveryAddress,
    required this.status,
    required this.totalPrice,
    required this.foods,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      customerName: json['customer_name'],        // NEW: from JSON
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      totalPrice: (json['total_price'] as num).toDouble(),
      foods: (json['foods'] as List)
          .map((item) => OrderedFood.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'customer_name': customerName,              // NEW: to JSON
      'delivery_address': deliveryAddress,
      'status': status,
      'total_price': totalPrice,
      'foods': foods.map((f) => f.toJson()).toList(),
    };
  }
}

class OrderedFood {
  final int foodId;
  final int quantity;
  final double price;

  OrderedFood({
    required this.foodId,
    required this.quantity,
    required this.price,
  });

  factory OrderedFood.fromJson(Map<String, dynamic> json) {
    return OrderedFood(
      foodId: json['food_id'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'quantity': quantity,
      'price': price,
    };
  }
}
