import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/auth_provider.dart';  // Adjust path if needed

class RewardDialog extends StatelessWidget {
  final int pointsWon;

  const RewardDialog({Key? key, required this.pointsWon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final int? userId = authProvider.user?.id;

    // You can print or use the userId here
    debugPrint('Logged in user ID: $userId, Points earned: $pointsWon');

    return AlertDialog(
      title: const Text('Congratulations! 🎉'),
      content: Text('You earned $pointsWon reward points!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Awesome!'),
        ),
      ],
    );
  }
}
