import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/favorite_screen.dart';
import '../providers/user_provider.dart';
// Import transport screens
import '../screens/transport/available_buses_screen.dart';
import '../screens/transport/my_bus_bookings_screen.dart';

// Import driver-related screens
import '../screens/available_drivers_screen.dart';
import '../screens/request_driver_screen.dart';
import '../screens/barcode_screen.dart';
import '../screens/picnic_places_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (_) => SplashScreen(),
  '/login': (_) => LoginScreen(),
  '/register': (_) => RegisterScreen(),
  '/home': (_) => HomeScreen(),
  '/favorite': (_) => FavoriteScreen(),

  // Transport routes
  '/availableBuses': (_) => AvailableBusesScreen(),
  '/myBusBookings': (_) => MyBusBookingsScreen(),

  // Driver routes
  '/availableDrivers': (_) => AvailableDriversScreen(),
  '/requestDriver': (_) => RequestDriverScreen(),

  '/barcode': (_) => BarcodeScreen(),
  '/picnicPlaces': (context) => PicnicPlacesScreen(),
 // Make sure this screen exists
  '/profile': (_) => ProfileScreen(),
};
