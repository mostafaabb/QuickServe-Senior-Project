import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../presentation/providers/bus_provider.dart';
import '../../../presentation/providers/user_provider.dart';

class MyBusBookingsScreen extends StatefulWidget {
  const MyBusBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBusBookingsScreen> createState() => _MyBusBookingsScreenState();
}

class _MyBusBookingsScreenState extends State<MyBusBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<UserProvider>(context, listen: false).user?.id;
      if (userId != null) {
        Provider.of<BusProvider>(context, listen: false).fetchUserBookings(userId);
      }
    });
  }

  Future<bool?> _showCancelConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<int?> _showEditSeatsDialog(int currentSeats) {
    final controller = TextEditingController(text: currentSeats.toString());
    return showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Seats Booked'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Number of seats',
            hintText: 'Enter new seats count',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value == null || value < 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid number greater than 0')),
                );
                return;
              }
              Navigator.pop(context, value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return 'N/A';
    try {
      final dt = DateTime.parse(timeString);
      return DateFormat.jm().format(dt);
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final userId = Provider.of<UserProvider>(context).user?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bus Bookings"),
        centerTitle: true,
        elevation: 4,
        backgroundColor: const Color(0xFFFF6D00),
      ),
      body: busProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : busProvider.userBookings.isEmpty
          ? const Center(
        child: Text(
          "No bookings found.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: busProvider.userBookings.length,
        itemBuilder: (context, index) {
          final booking = busProvider.userBookings[index];
          final bus = booking.bus;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.deepOrangeAccent.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bus Number
                  Text(
                    bus?.busNumber != null ? "Bus #${bus!.busNumber}" : 'Bus info not available',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Driver Name (optional)
                  if (bus?.driverName != null)
                    Text(
                      "Driver: ${bus!.driverName}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  if (bus?.driverName != null) const SizedBox(height: 8),

                  // Route, Departure, Arrival
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Route: ${bus?.route ?? 'N/A'}",
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(
                              "Departure: ${_formatTime(bus?.departureTime)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Arrival: ${_formatTime(bus?.arrivalTime)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                      // Seats booked info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Seats Booked",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(
                            "${booking.seatsBooked}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Buttons Row: Cancel + Edit
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final confirm = await _showCancelConfirmDialog();
                            if (confirm == true) {
                              if (userId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('User not logged in')),
                                );
                                return;
                              }

                              final success = await busProvider.cancelBooking(booking.id, userId);

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? "Booking cancelled" : "Cancellation failed"),
                                ),
                              );

                              if (success) {
                                await busProvider.fetchUserBookings(userId);
                              }
                            }
                          },
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          label: const Text('Cancel Booking'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (userId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('User not logged in')),
                              );
                              return;
                            }

                            final newSeats = await _showEditSeatsDialog(booking.seatsBooked);
                            if (newSeats == null || newSeats == booking.seatsBooked) return;

                            final success = await busProvider.updateBookingSeats(
                              bookingId: booking.id,
                              userId: userId,
                              newSeats: newSeats,
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(success ? "Booking updated" : "Update failed"),
                              ),
                            );

                            if (success) {
                              await busProvider.fetchUserBookings(userId);
                            }
                          },
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: const Text('Edit Seats'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
