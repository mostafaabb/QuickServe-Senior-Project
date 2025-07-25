import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/order_model.dart';
import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const double usdToLbpRate = 90000;

  String formatLbp(double priceUsd) {
    final priceLbp = (priceUsd * usdToLbpRate).round();
    final str = priceLbp.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i != 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return '${buffer.toString()} LBP';
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final cartItems = cartProvider.items;
    final loggedInUser = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            } else {
              Navigator.pushNamed(context, '/home'); // replace with your actual route
            }
          },
        ),
        title: const Text("Your Cart"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if (cartProvider.items.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your cart is already empty')),
                );
                return;
              }
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Empty Cart'),
                  content: const Text('Are you sure you want to empty your cart?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        cartProvider.clearCart();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Empty'),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'Empty Cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.orange.shade100,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_cart_outlined, color: Colors.deepOrange, size: 28),
                SizedBox(width: 10),
                Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Add some delicious food to your cart!",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
          ),
        ],
      )
          : Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.deepOrange.shade50,
            child: const Center(
              child: Text(
                "Ready to order? Review your items below!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final food = item.food;
                final quantity = item.quantity;

                final imageUrl = food.image != null && food.image!.isNotEmpty
                    ? '${AppConstants.baseUrl.replaceAll('/api', '')}/storage/${food.image}'
                    : null;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrange.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageUrl != null
                          ? Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 60),
                      )
                          : const Icon(Icons.broken_image, size: 60),
                    ),
                    title: Text(
                      food.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      '\$${food.price.toStringAsFixed(2)} x $quantity',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          color: Colors.deepOrange,
                          onPressed: () {
                            if (quantity > 1) {
                              cartProvider.updateQuantity(food, quantity - 1);
                            } else {
                              cartProvider.removeFromCart(food);
                            }
                          },
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          color: Colors.deepOrange,
                          onPressed: () =>
                              cartProvider.updateQuantity(food, quantity + 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total (USD):',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total (LBP):',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatLbp(cartProvider.totalPrice),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    if (cartProvider.items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Your cart is empty')),
                      );
                      return;
                    }

                    if (loggedInUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please login first')),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(
                          selectedFoods: cartProvider.items
                              .map(
                                (item) => OrderedFood(
                              foodId: item.food.id,
                              quantity: item.quantity,
                              price: item.food.price,
                            ),
                          )
                              .toList(),
                          totalPrice: cartProvider.totalPrice,
                          userId: loggedInUser.id,
                          customerName: loggedInUser.name,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.payment),
                  label: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
