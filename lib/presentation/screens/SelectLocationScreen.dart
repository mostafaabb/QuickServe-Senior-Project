// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:latlong2/latlong.dart';
//
// class SelectLocationScreen extends StatefulWidget {
//   @override
//   _SelectLocationScreenState createState() => _SelectLocationScreenState();
// }
//
// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   LatLng? selectedLatLng;
//   String selectedAddress = '';
//
//   Future<void> _getAddressFromLatLng(LatLng latLng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latLng.latitude,
//         latLng.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         setState(() {
//           selectedAddress =
//           '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
//         });
//       }
//     } catch (e) {
//       print('Failed to get address: $e');
//     }
//   }
//
//   void _onTap(LatLng latLng) {
//     setState(() {
//       selectedLatLng = latLng;
//     });
//     _getAddressFromLatLng(latLng);
//   }
//
//   void _confirmLocation() {
//     if (selectedLatLng != null && selectedAddress.isNotEmpty) {
//       Navigator.pop(context, {
//         'address': selectedAddress,
//         'lat': selectedLatLng!.latitude,
//         'lng': selectedLatLng!.longitude,
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a location on the map')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultLocation = LatLng(30.0444, 31.2357); // Cairo as default
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Select Delivery Location')),
//       body: Column(
//         children: [
//           Expanded(
//             child: FlutterMap(
//               options: MapOptions(
//                 center: selectedLatLng ?? defaultLocation,
//                 zoom: 13.0,
//                 onTap: (_, latLng) => _onTap(latLng),
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   userAgentPackageName: 'com.example.app',
//                 ),
//                 if (selectedLatLng != null)
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         width: 80,
//                         height: 80,
//                         point: selectedLatLng!,
//                         child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text(selectedAddress.isEmpty
//                     ? 'No location selected'
//                     : 'Selected: $selectedAddress'),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _confirmLocation,
//                   child: Text('Confirm Location'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
