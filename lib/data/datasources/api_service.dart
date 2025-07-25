import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:untitled1/core/constants/app_constants.dart';
import 'package:untitled1/data/models/category_model.dart';
import 'package:untitled1/data/models/food_model.dart';
import 'package:untitled1/data/models/order_model.dart';
import 'package:untitled1/data/models/offer_model.dart';
import 'package:untitled1/data/models/restaurant_model.dart';
import 'package:untitled1/data/models/user_model.dart';
import 'package:untitled1/data/models/rating.dart';
import 'package:untitled1/data/models/reward_model.dart';
import 'package:untitled1/data/models/bus_model.dart';
import 'package:untitled1/data/models/bus_booking_model.dart';
import'package:untitled1/data/models/driver.dart';
import'package:untitled1/data/models/driver_request.dart';
import 'package:untitled1/data/models/picnic_place_model.dart';

class ApiService {
  static const Duration timeoutDuration = Duration(seconds: 30);

  Future<http.Response> _get(String url) async {
    return await http
        .get(Uri.parse(url), headers: AppConstants.headers)
        .timeout(timeoutDuration);
  }

  Future<http.Response> _post(String url, Map<String, dynamic> data) async {
    return await http
        .post(
        Uri.parse(url), headers: AppConstants.headers, body: jsonEncode(data))
        .timeout(timeoutDuration);
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _get(AppConstants.categories);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<FoodModel>> fetchFoods() async {
    try {
      final response = await _get(AppConstants.foods);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => FoodModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      throw Exception('Failed to load foods: $e');
    }
  }

  Future<List<OfferModel>> fetchOffers() async {
    try {
      final response = await _get(AppConstants.offers);
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        List<dynamic> offersList = [];

        if (jsonData is List) {
          offersList = jsonData;
        } else if (jsonData is Map && jsonData['data'] is List) {
          offersList = jsonData['data'];
        } else {
          throw Exception('Unexpected offers data format');
        }

        return offersList.map((e) => OfferModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers: $e');
    }
  }

  Future<List<RestaurantModel>> fetchRestaurants() async {
    try {
      final response = await _get('${AppConstants.baseUrl}/restaurants');
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => RestaurantModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Failed to load restaurants: $e');
    }
  }

  Future<bool> createOrder(OrderModel order) async {
    try {
      final response = await _post(AppConstants.orders, order.toJson());
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Exception creating order: $e');
      return false;
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _get(AppConstants.orders);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _post(AppConstants.login, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'token': data['token'], 'user': data['user']};
      } else {
        return null;
      }
    } catch (e) {
      print('Exception during login: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(String name, String email,
      String password) async {
    try {
      final response = await _post(AppConstants.register, {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'token': data['token'], 'user': data['user']};
      } else {
        return null;
      }
    } catch (e) {
      print('Exception during registration: $e');
      return null;
    }
  }

  Future<String> askAi(String question) async {
    try {
      final response = await _post(AppConstants.askAI, {'question': question});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] ?? data['response'] ?? data['message'] ??
            'No response from AI.';
      } else {
        return 'Sorry, I could not process your request.';
      }
    } catch (e) {
      return 'Sorry, something went wrong.';
    }
  }

  Future<String> askAiWithMenu(String question, List<FoodModel> menu) async {
    try {
      String menuSummary = menu.map((food) {
        return '${food.name}: ${food.description ?? 'No description'}';
      }).join('\n');

      String prompt = 'Menu:\n$menuSummary\n\nUser question: $question';

      if (prompt.length > 1000) {
        final fixedPart = 'Menu:\n\nUser question: $question';
        final allowedMenuLength = 1000 - fixedPart.length;
        String truncatedMenu = menuSummary.substring(
            0, allowedMenuLength.clamp(0, menuSummary.length));
        prompt = 'Menu:\n$truncatedMenu\n\nUser question: $question';
      }

      final response = await _post(AppConstants.askAI, {'question': prompt});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] ?? data['response'] ?? data['message'] ??
            'No response from AI.';
      } else {
        return 'Sorry, I could not process your request.';
      }
    } catch (e) {
      return 'Sorry, something went wrong.';
    }
  }

  Future<Rating?> submitRating(Rating rating) async {
    try {
      final response = await _post(AppConstants.ratings, rating.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Rating.fromJson(data['rating']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      final response = await _post(
          AppConstants.forgotPassword, {'email': email});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(String token, String email,
      String newPassword) async {
    try {
      final response = await _post(AppConstants.resetPassword, {
        'token': token,
        'email': email,
        'password': newPassword,
        'password_confirmation': newPassword,
      });
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> fetchUserProfile(int userId) async {
    try {
      final response = await _get('${AppConstants.baseUrl}/users/$userId');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUserProfile(UserModel user) async {
    try {
      final url = '${AppConstants.baseUrl}/users/${user.id}';
      final response = await http.put(
        Uri.parse(url),
        headers: AppConstants.headers,
        body: jsonEncode(user.toJson()),
      ).timeout(timeoutDuration);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<RewardModel>> fetchRewards() async {
    try {
      final response = await _get(AppConstants.rewards);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => RewardModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load rewards (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching rewards: $e');
    }
  }

  Future<RewardModel> addReward({
    required int userId,
    required String title,
    required String code,
    required double discountAmount,
  }) async {
    try {
      final response = await _post(AppConstants.addReward, {
        'user_id': userId,
        'title': title,
        'code': code,
        'discount_amount': discountAmount,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RewardModel.fromJson(data);
      } else {
        throw Exception('Failed to add reward (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error adding reward: $e');
    }
  }

  Future<List<FoodModel>> fetchTrendingFoods() async {
    try {
      final response = await _get(AppConstants.trendingFoods);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => FoodModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load trending foods');
      }
    } catch (e) {
      throw Exception('Failed to load trending foods: $e');
    }
  }

  Future<List<BusModel>> fetchAvailableBuses() async {
    try {
      final response = await _get(AppConstants.buses);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => BusModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load buses');
      }
    } catch (e) {
      throw Exception('Failed to load buses: $e');
    }
  }

  Future<bool> bookBus(int userId, int busId, int seatsBooked) async {
    try {
      final response = await _post(AppConstants.busBooking, {
        'user_id': userId,
        'bus_id': busId,
        'seats_booked': seatsBooked,
      });
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<List<BusBookingModel>> getUserBusBookings(int userId) async {
    try {
      final response = await _get(
          '${AppConstants.busBooking}/my?user_id=$userId');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> bookingsJson = jsonData['bookings'];
        return bookingsJson.map((e) => BusBookingModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch user bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<bool> cancelBusBooking(int bookingId, int userId) async {
    try {
      final url = '${AppConstants.busBooking}/$bookingId';
      print('Sending DELETE to $url with userId: $userId');

      final response = await http.delete(
        Uri.parse(url),
        headers: AppConstants.headers,
        body: json.encode({'user_id': userId}), // send user_id in body
      ).timeout(timeoutDuration);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Error cancelling bus booking: $e');
      return false;
    }
  }

  Future<bool> updateBusBooking({
    required int bookingId,
    required int userId,
    required int newSeats,
  }) async {
    final url = Uri.parse(AppConstants.updateBooking(bookingId));

    final response = await http.put(
      url,
      headers: AppConstants.headers,
      body: jsonEncode({
        'user_id': userId,
        'seats_booked': newSeats,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update booking: ${response.body}');
      return false;
    }
  }

  Future<List<Driver>> fetchDrivers() async {
    try {
      final response = await _get('${AppConstants.baseUrl}/drivers');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List jsonData = jsonMap['data'];
        return jsonData.map((e) => Driver.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load drivers');
      }
    } catch (e) {
      throw Exception('Failed to load drivers: $e');
    }
  }

// Create a driver booking request
  Future<bool> createDriverRequest(DriverRequest request) async {
    try {
      print('Sending driver request: ${request.toJson()}'); // Debug print

      final response = await _post(
          '${AppConstants.baseUrl}/driver-request', request.toJson());

      print('Response status: ${response.statusCode}');
      print('Response body: ${response
          .body}'); // Sometimes backend returns error details here

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Log error if status code is unexpected
        print(
            'Failed to create driver request: ${response.statusCode} ${response
                .body}');
        return false;
      }
    } catch (e) {
      print('Exception creating driver request: $e');
      return false;
    }
  }

  Future<List<PicnicPlace>> fetchPicnicPlaces() async {
    try {
      final response = await _get('${AppConstants.baseUrl}/picnic-places');
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => PicnicPlace.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load picnic places');
      }
    } catch (e) {
      throw Exception('Failed to load picnic places: $e');
    }
  }

  Future<UserModel?> fetchProfile(int userId) async {
    try {
      final url = AppConstants.profileGet(userId); // uses /profile/1
      final response = await http.get(Uri.parse(url), headers: AppConstants.headers);

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          return UserModel.fromJson(data['user']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }



  Future<bool> updateProfile(UserModel user) async {
    try {
      final url = AppConstants.profileUpdate(user.id);
      final response = await http.put(
        Uri.parse(url),
        headers: AppConstants.headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      } else {
        print('Failed to update profile: HTTP ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}

