class DriverRequest {
  final int id;
  final int userId;
  final int? driverId; // optional, if you want to link driver
  final String description;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String status;
  final double? price;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverRequest({
    required this.id,
    required this.userId,
    this.driverId,
    required this.description,
    this.pickupLocation,
    this.dropoffLocation,
    required this.status,
    this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverRequest.fromJson(Map<String, dynamic> json) {
    return DriverRequest(
      id: json['id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      description: json['description'],
      pickupLocation: json['pickup_location'],
      dropoffLocation: json['dropoff_location'],
      status: json['status'],
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'driver_id': driverId,
    'description': description,
    'pickup_location': pickupLocation,
    'dropoff_location': dropoffLocation,
    'status': status,
    'price': price,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
