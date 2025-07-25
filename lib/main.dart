import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/providers/order_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/food_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/cart_provider.dart';
import 'presentation/providers/offer_provider.dart';
import 'presentation/providers/profile_provider.dart';
import 'presentation/providers/rating_provider.dart';
import 'presentation/providers/setting_provider.dart';
import 'presentation/providers/favorites_provider.dart';
import 'presentation/providers/reward_provider.dart';
import 'presentation/providers/trending_food_provider.dart';
import 'presentation/providers/bus_provider.dart';

import 'presentation/providers/DriverProvider.dart';           // DriverProvider import
import 'presentation/providers/DriverRequestProvider.dart';

import 'presentation/providers/picnic_place_provider.dart';// DriverRequestProvider import

import 'data/datasources/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => RatingProvider(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => RewardProvider()),
        ChangeNotifierProvider(create: (_) => TrendingFoodProvider(apiService)),
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_) => DriverProvider()),          // Added DriverProvider
        ChangeNotifierProvider(create: (_) => DriverRequestProvider()),
        ChangeNotifierProvider(create: (_) => PicnicPlaceProvider()..fetchPicnicPlaces()),// Added DriverRequestProvider
      ],
      child: Consumer<SettingProvider>(
        builder: (context, settingProvider, _) {
          return MaterialApp(
            title: 'Food Ordering App',
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            routes: appRoutes,
            theme: settingProvider.currentTheme,
          );
        },
      ),
    );
  }
}
