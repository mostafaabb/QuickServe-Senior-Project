class RestaurantModel {
  final int id;
  final String name;
  final String location;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.location,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
    );
  }
}
