import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/driver.dart';
import '../../presentation/providers/DriverProvider.dart';

class AvailableDriversScreen extends StatefulWidget {
  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DriverProvider>(context, listen: false).fetchDrivers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // Gradient background behind app bar and body
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade700, Colors.orangeAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar alternative with shadow
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  'Available Drivers',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<DriverProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    if (provider.drivers.isEmpty) {
                      return Center(
                        child: Text(
                          'No drivers available.',
                          style: theme.textTheme.titleMedium!
                              .copyWith(color: Colors.white70),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: provider.drivers.length,
                      itemBuilder: (context, index) {
                        Driver d = provider.drivers[index];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.shade50,
                                  Colors.orange.shade100,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ID and Status row
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID: ${d.id}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: d.status == 'available'
                                            ? Colors.green.shade400
                                            : d.status == 'busy'
                                            ? Colors.orange.shade400
                                            : Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        d.status.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Name
                                Text(
                                  d.name,
                                  style: theme.textTheme.headlineSmall!.copyWith(
                                    color: Colors.deepOrange.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Divider(color: Colors.deepOrange.shade200),

                                // Contact info with icons
                                Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.deepOrange),
                                    SizedBox(width: 8),
                                    Text(d.phone),
                                    SizedBox(width: 24),
                                    Icon(Icons.email, color: Colors.deepOrange),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        d.email ?? 'N/A',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Vehicle info row
                                Row(
                                  children: [
                                    Icon(Icons.directions_car,
                                        color: Colors.deepOrange),
                                    SizedBox(width: 8),
                                    Text('${d.vehicleType} - ${d.vehicleNumber}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.deepOrange.shade700)),
                                  ],
                                ),

                                SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      elevation: 5,
                                    ),
                                    icon: Icon(Icons.send),
                                    label: Text('Request'),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/requestDriver',
                                          arguments: d);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
