import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/setting_provider.dart';
import '../providers/auth_provider.dart';
import '../../core/themes/app_theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔒Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingProvider>();
    final currentTheme = settingProvider.themeType;

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️Settings'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎨App Theme',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Theme options
            ...AppThemeType.values.map((themeType) {
              final isSelected = currentTheme == themeType;
              final themeColor = _themeColor(themeType);
              final iconData = _themeIcon(themeType);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isSelected ? themeColor.withOpacity(0.15) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected ? themeColor : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                elevation: 1,
                child: ListTile(
                  leading: Icon(iconData, color: themeColor, size: 28),
                  title: Text(
                    _themeName(themeType),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? themeColor : Colors.black87,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () => settingProvider.setTheme(themeType),
                ),
              );
            }).toList(),

            const SizedBox(height: 30),
            const Divider(thickness: 1.2),
            const SizedBox(height: 30),

            // Follow us section
            Center(
              child: Column(
                children: [
                  const Text(
                    '📲 Follow us on',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        iconSize: 30,
                        tooltip: 'Facebook',
                        onPressed: () {
                          // TODO: Add Facebook URL
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.purple),
                        iconSize: 30,
                        tooltip: 'Instagram',
                        onPressed: () {
                          // TODO: Add Instagram URL
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.alternate_email, color: Colors.lightBlue),
                        iconSize: 30,
                        tooltip: 'Twitter',
                        onPressed: () {
                          // TODO: Add Twitter URL
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Logout button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: () => _logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _themeName(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return 'Light';
      case AppThemeType.dark:
        return 'Dark';
      case AppThemeType.blue:
        return 'Blue';
      case AppThemeType.green:
        return 'Green';
      case AppThemeType.red:
        return 'Red';
    }
  }

  Color _themeColor(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return Colors.grey.shade600;
      case AppThemeType.dark:
        return Colors.black87;
      case AppThemeType.blue:
        return Colors.blue.shade700;
      case AppThemeType.green:
        return Colors.green.shade700;
      case AppThemeType.red:
        return Colors.red.shade700;
    }
  }

  IconData _themeIcon(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return Icons.wb_sunny;
      case AppThemeType.dark:
        return Icons.nightlight_round;
      case AppThemeType.blue:
        return Icons.water;
      case AppThemeType.green:
        return Icons.eco;
      case AppThemeType.red:
        return Icons.fireplace;
    }
  }
}
