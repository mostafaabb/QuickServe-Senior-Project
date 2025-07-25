import 'package:flutter/material.dart';
import 'package:untitled1/data/models/bus_model.dart';
import 'package:untitled1/data/models/bus_booking_model.dart';
import 'package:untitled1/data/datasources/api_service.dart';

class BusProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<BusModel> _availableBuses = [];
  List<BusBookingModel> _userBookings = [];

  List<BusModel> get availableBuses => _availableBuses;
  List<BusBookingModel> get userBookings => _userBookings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch available buses
  Future<void> fetchAvailableBuses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _availableBuses = await _apiService.fetchAvailableBuses();
    } catch (e) {
      print('Error fetching buses: $e');
      _availableBuses = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch user bookings
  Future<void> fetchUserBookings(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userBookings = await _apiService.getUserBusBookings(userId);
    } catch (e) {
      print('Error fetching bookings: $e');
      _userBookings = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Book a bus
  Future<bool> bookBus(int userId, int busId, int seats) async {
    bool success = false;
    try {
      success = await _apiService.bookBus(userId, busId, seats);
      if (success) {
        await fetchUserBookings(userId);
        await fetchAvailableBuses();
      }
    } catch (e) {
      print('Error booking bus: $e');
    }
    return success;
  }

  // Cancel booking
  Future<bool> cancelBooking(int bookingId, int userId) async {
    bool success = false;
    try {
      success = await _apiService.cancelBusBooking(bookingId, userId);
      if (success) {
        _userBookings.removeWhere((b) => b.id == bookingId);
        notifyListeners();
      }
    } catch (e) {
      print('Error cancelling booking: $e');
    }
    return success;
  }

  // Update booking seats
  Future<bool> updateBookingSeats({
    required int bookingId,
    required int userId,
    required int newSeats,
  }) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _apiService.updateBusBooking(
      bookingId: bookingId,
      userId: userId,
      newSeats: newSeats,
    );

    if (success) {
      int index = _userBookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        // Use copyWith to update seatsBooked as well as keep other fields unchanged
        final oldBooking = _userBookings[index];
        _userBookings[index] = BusBookingModel(
          id: oldBooking.id,
          userId: oldBooking.userId,
          busId: oldBooking.busId,
          seatsBooked: newSeats,
          createdAt: oldBooking.createdAt,
          updatedAt: DateTime.now(), // or oldBooking.updatedAt if you want
          bus: oldBooking.bus,
        );
        notifyListeners();
      }
    } else {
      print('Failed to update booking seats');
    }

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
