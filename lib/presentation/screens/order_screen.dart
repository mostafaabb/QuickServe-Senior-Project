import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/order_model.dart';
import '../providers/order_provider.dart';
import '../providers/cart_provider.dart';

class OrderScreen extends StatefulWidget {
  final List<OrderedFood> selectedFoods;
  final double totalPrice;
  final int userId;
  final String customerName;

  const OrderScreen({
    Key? key,
    required this.selectedFoods,
    required this.totalPrice,
    required this.userId,
    required this.customerName,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final String status = 'pending';

  void _submitOrder() async {
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter delivery address')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final order = OrderModel(
        userId: widget.userId,
        customerName: widget.customerName,
        deliveryAddress: addressController.text,
        status: status,
        totalPrice: widget.totalPrice,
        foods: widget.selectedFoods,
      );

      final success = await Provider.of<OrderProvider>(context, listen: false)
          .submitOrder(order);

      if (success) {
        Provider.of<CartProvider>(context, listen: false).clearCart();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order submitted successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order submission failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: addressController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter full delivery address...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter delivery address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (provider.message.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  provider.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
