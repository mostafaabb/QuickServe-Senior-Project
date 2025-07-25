class BusModel {
  final int id;
  final String busNumber;
  final String driverName;
  final int capacity;
  final int availableSeats;
  final String departureTime;
  final String arrivalTime;
  final String route;

  BusModel({
    required this.id,
    required this.busNumber,
    required this.driverName,
    required this.capacity,
    required this.availableSeats,
    required this.departureTime,
    required this.arrivalTime,
    required this.route,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'],
      busNumber: json['bus_number'],
      driverName: json['driver_name'],
      capacity: json['capacity'],
      availableSeats: json['available_seats'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      route: json['route'],
    );
  }
}
