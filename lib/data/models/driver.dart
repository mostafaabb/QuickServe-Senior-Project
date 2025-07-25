class Driver {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String vehicleType;
  final String vehicleNumber;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'vehicle_type': vehicleType,
    'vehicle_number': vehicleNumber,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
