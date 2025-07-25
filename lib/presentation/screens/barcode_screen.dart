import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  // Just a simple text inside the QR code — customize as you like
  final String qrData = 'QuickServeApp2025';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickServe QR Code'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Scan this QR code to connect with QuickServe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 250,
                ),
                const SizedBox(height: 24),
                Text(
                  qrData,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
