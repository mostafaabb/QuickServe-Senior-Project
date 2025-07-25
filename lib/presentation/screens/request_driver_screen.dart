import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/driver.dart';
import '../../data/models/driver_request.dart';
import '../../presentation/providers/DriverRequestProvider.dart';
import '../../presentation/providers/auth_provider.dart';

class RequestDriverScreen extends StatefulWidget {
  @override
  _RequestDriverScreenState createState() => _RequestDriverScreenState();
}

class _RequestDriverScreenState extends State<RequestDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final driver = ModalRoute.of(context)?.settings.arguments as Driver?;
    final driverRequestProvider = Provider.of<DriverRequestProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (driver == null || user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Request Driver'),
          backgroundColor: Colors.orange.shade700,
        ),
        body: Center(
          child: Text(driver == null
              ? 'No driver selected.'
              : 'Please log in to make a request.'),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade700, Colors.orangeAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Request ${driver.name}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildStyledTextField(
                            controller: _descriptionController,
                            label: 'Request Description',
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter a description'
                                : null,
                            icon: Icons.description_outlined,
                          ),
                          SizedBox(height: 18),
                          _buildStyledTextField(
                            controller: _pickupController,
                            label: 'Pickup Location',
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter pickup location'
                                : null,
                            icon: Icons.location_on_outlined,
                          ),
                          SizedBox(height: 18),
                          _buildStyledTextField(
                            controller: _dropoffController,
                            label: 'Dropoff Location',
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter dropoff location'
                                : null,
                            icon: Icons.flag_outlined,
                          ),
                          SizedBox(height: 28),
                          driverRequestProvider.isSubmitting
                              ? CircularProgressIndicator(color: Colors.orange)
                              : ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final now = DateTime.now();
                                final request = DriverRequest(
                                  id: 0,
                                  userId: user.id,
                                  driverId: driver.id,
                                  description:
                                  _descriptionController.text.trim(),
                                  pickupLocation:
                                  _pickupController.text.trim(),
                                  dropoffLocation:
                                  _dropoffController.text.trim(),
                                  status: 'pending',
                                  price: null,
                                  createdAt: now,
                                  updatedAt: now,
                                );

                                final success =
                                await driverRequestProvider
                                    .submitDriverRequest(request);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(success
                                        ? 'Request sent successfully'
                                        : 'Failed to send request'),
                                  ),
                                );

                                if (success) Navigator.pop(context);
                              }
                            },
                            icon: Icon(Icons.send),
                            label: Text('Submit Request'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade700,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.orange.shade700)
            : null,
        labelText: label,
        labelStyle: TextStyle(color: Colors.orange.shade800),
        filled: true,
        fillColor: Colors.orange.shade50,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.orange.shade200),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
