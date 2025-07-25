import 'bus_model.dart';

class BusBookingModel {
  final int id;
  final int userId;
  final int busId;
  final int seatsBooked;
  final DateTime createdAt;
  final DateTime updatedAt;

  final BusModel? bus; // optional nested BusModel

  BusBookingModel({
    required this.id,
    required this.userId,
    required this.busId,
    required this.seatsBooked,
    required this.createdAt,
    required this.updatedAt,
    this.bus,
  });

  factory BusBookingModel.fromJson(Map<String, dynamic> json) {
    return BusBookingModel(
      id: json['id'],
      userId: json['user_id'],
      busId: json['bus_id'],
      seatsBooked: json['seats_booked'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bus: json['bus'] != null ? BusModel.fromJson(json['bus']) : null,
    );
  }

  BusBookingModel copyWith({
    BusModel? bus,
  }) {
    return BusBookingModel(
      id: id,
      userId: userId,
      busId: busId,
      seatsBooked: seatsBooked,
      createdAt: createdAt,
      updatedAt: updatedAt,
      bus: bus ?? this.bus,
    );
  }
}
