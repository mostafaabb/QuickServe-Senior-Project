import '../models/order_model.dart';
import '../datasources/api_service.dart';

class OrderRepositoryImpl {
  final ApiService api;

  OrderRepositoryImpl(this.api);

  Future<bool> submitOrder(OrderModel order) {
    return api.createOrder(order);
  }

  Future<List<OrderModel>> fetchOrders() {
    return api.getOrders();
  }
}
