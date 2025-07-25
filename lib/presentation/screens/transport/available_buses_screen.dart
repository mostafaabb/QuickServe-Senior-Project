import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../presentation/providers/bus_provider.dart';
import '../../../presentation/providers/user_provider.dart';
import '../../../data/models/bus_model.dart';

class AvailableBusesScreen extends StatefulWidget {
  const AvailableBusesScreen({Key? key}) : super(key: key);

  @override
  State<AvailableBusesScreen> createState() => _AvailableBusesScreenState();
}

class _AvailableBusesScreenState extends State<AvailableBusesScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final busProvider = Provider.of<BusProvider>(context, listen: false);
    busProvider.fetchAvailableBuses();
  }

  void _showSeatSelectorDialog(BusModel bus, int userId) {
    int seats = 1;
    final maxSeats = bus.availableSeats > 0 ? bus.availableSeats : 1;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Number of Seats'),
        content: StatefulBuilder(
          builder: (context, setState) => DropdownButton<int>(
            value: seats,
            isExpanded: true,
            items: List.generate(maxSeats, (i) => i + 1)
                .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                .toList(),
            onChanged: (val) {
              setState(() => seats = val ?? 1);
            },
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6D00), // Orange color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final busProvider = Provider.of<BusProvider>(context, listen: false);
              final userProvider = Provider.of<UserProvider>(context, listen: false);
              final success = await busProvider.bookBus(userId, bus.id, seats);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'Bus booked!' : 'Booking failed'),
                  backgroundColor: success ? Colors.green : Colors.red,
                ),
              );

              if (success) {
                await busProvider.fetchAvailableBuses();

                final currentUserId = userProvider.user?.id;
                if (currentUserId != null) {
                  await busProvider.fetchUserBookings(currentUserId);
                }
              }
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }

  String _formatTime(String timeString) {
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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    // Filter buses by available seats > 0 AND by route matching search query
    final filteredBuses = busProvider.availableBuses
        .where((bus) =>
    bus.availableSeats > 0 &&
        bus.route.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("🚍 Available Buses"),
        centerTitle: true,
        elevation: 3,
        backgroundColor: const Color(0xFFFF6D00), // Orange appbar
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by route...',
                prefixIcon: const Icon(Icons.alt_route, color: Color(0xFFFF6D00)),
                filled: true,
                fillColor: Colors.orange.shade50,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: busProvider.isLoading
                ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF6D00)),
            )
                : filteredBuses.isEmpty
                ? const Center(
              child: Text(
                "No buses available.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
              itemCount: filteredBuses.length,
              itemBuilder: (context, index) {
                final bus = filteredBuses[index];
                final seatsAvailable = bus.availableSeats;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor:
                  const Color(0xFFFF6D00).withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + bus number
                        Text(
                          "Bus #${bus.busNumber}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: Color(0xFFFF6D00),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Driver row with icon
                        Row(
                          children: [
                            const Icon(Icons.person,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "Driver: ${bus.driverName}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 28, thickness: 1),
                        // Info Row with route and timings
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.alt_route,
                                          size: 18,
                                          color: Color(0xFFFF6D00)),
                                      SizedBox(width: 6),
                                    ],
                                  ),
                                  Text(
                                    bus.route,
                                    style:
                                    const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule,
                                          size: 18,
                                          color: Colors.green),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Departs: ${_formatTime(bus.departureTime)}",
                                        style: const TextStyle(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule,
                                          size: 18, color: Colors.red),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Arrives: ${_formatTime(bus.arrivalTime)}",
                                        style: const TextStyle(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Seats left column
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Seats Left",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: seatsAvailable > 0
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "$seatsAvailable",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: seatsAvailable > 0
                                          ? Colors.green.shade800
                                          : Colors.red.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: seatsAvailable > 0
                                  ? const Color(0xFFFF6D00)
                                  : Colors.grey.shade400,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              elevation: seatsAvailable > 0 ? 6 : 0,
                            ),
                            onPressed: seatsAvailable > 0
                                ? () =>
                                _showSeatSelectorDialog(
                                    bus, user.id!)
                                : null,
                            icon:
                            const Icon(Icons.directions_bus, size: 20),
                            label: Text(
                              seatsAvailable > 0 ? "Book Now" : "Full",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: seatsAvailable > 0
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
