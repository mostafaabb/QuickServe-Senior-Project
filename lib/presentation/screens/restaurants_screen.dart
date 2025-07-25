import 'package:flutter/material.dart';
import '../../data/models/restaurant_model.dart';
import '../../data/datasources/api_service.dart';

class RestaurantsScreen extends StatelessWidget {
  final ApiService apiService = ApiService(); // create instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Restaurants")),
      body: FutureBuilder<List<RestaurantModel>>(
        future: apiService.fetchRestaurants(),  // use instance method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Failed to load restaurants"));

          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (_, index) {
              final res = restaurants[index];
              return ListTile(
                title: Text(res.name),
                subtitle: Text(res.location),
              );
            },
          );
        },
      ),
    );
  }
}
