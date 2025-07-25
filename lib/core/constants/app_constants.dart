class AppConstants {
  // Base API URL
  static const String baseUrl = 'http://192.168.0.106:8000/api';

  // Authentication endpoints
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';

  // Password reset endpoints
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String verifyResetCode = '$baseUrl/verify-reset-code';
  static const String resetPassword = '$baseUrl/reset-password';

  // User endpoints
  static String updateUser(int id) => '$baseUrl/users/$id';
  static String userDetails(int id) => '$baseUrl/users/$id';

  // Resources endpoints
  static const String foods = '$baseUrl/foods';
  static const String trendingFoods = '$baseUrl/foods/trending';
  static const String categories = '$baseUrl/categories';
  static const String offers = '$baseUrl/offers';
  static const String orders = '$baseUrl/orders';
  // Profile endpoints
  static String profileGet(int userId) => '$baseUrl/profile/$userId';
  static String profileUpdate(int userId) => '$baseUrl/profile/$userId';
  static const String ratings = '$baseUrl/ratings';
  static const String picnicPlaces = '$baseUrl/picnic_places';

  // Bus endpoints
  static const String buses = '$baseUrl/buses';                       // GET available buses
  static const String busBooking = '$baseUrl/bus-bookings';          // POST to book a bus
  static const String userBookings = '$baseUrl/bus-bookings/my';     // GET user's bookings
  static const String cancelBookingBase = '$baseUrl/bus-bookings';   // DELETE requires /{id} appended
  static String updateBooking(int id) => '$baseUrl/bus-bookings/$id'; // PUT to update booking

  // Cart endpoints
  static const String cartAdd = '$baseUrl/cart/add';    // POST to add/update cart item
  static const String cartItems = '$baseUrl/cart';      // GET to fetch user's cart items

  // AI Chatbot endpoint
  static const String askAI = '$baseUrl/ask-ai';

  // Rewards endpoints
  static const String rewards = '$baseUrl/rewards';
  static const String addReward = '$baseUrl/rewards'; // POST to add reward

  static const String driverRequest = '$baseUrl/driver-request';
  static const String driverRequests = '$baseUrl/driver-request';
  static String driverRequestUpdateStatus(int id) => '$baseUrl/driver-request/$id/status';

  static const String drivers = '$baseUrl/drivers';
  static String driverDetails(int id) => '$baseUrl/drivers/$id';

  // Default headers for requests without authentication
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Headers with Bearer token authorization (use when logged in)
  static Map<String, String> authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
