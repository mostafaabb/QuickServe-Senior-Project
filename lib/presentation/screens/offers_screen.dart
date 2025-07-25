import 'package:flutter/material.dart';
import 'package:untitled1/data/models/offer_model.dart';
import 'package:untitled1/data/datasources/api_service.dart';
import 'package:untitled1/core/constants/app_constants.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseUrl = AppConstants.baseUrl;
    final baseUrlWithoutApi = baseUrl.endsWith('/api')
        ? baseUrl.substring(0, baseUrl.length - 4)
        : baseUrl;

    return Scaffold(
      appBar: AppBar(title: const Text("Offers")),
      body: FutureBuilder<List<OfferModel>>(
        future: ApiService().fetchOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load offers"));
          }

          final offers = snapshot.data ?? [];

          if (offers.isEmpty) {
            return const Center(child: Text('No offers available'));
          }

          return ListView.builder(
            itemCount: offers.length,
            itemBuilder: (_, index) {
              final offer = offers[index];

              final imageUrl = offer.image.isNotEmpty
                  ? '$baseUrlWithoutApi/storage/${offer.image}'
                  : null;

              return ListTile(
                leading: imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          size: 24,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                )
                    : const Icon(Icons.local_offer_outlined, size: 50),
                title: Text(offer.title),
                subtitle: Text(offer.description),
                trailing: Text(
                  '${offer.discount}% OFF',
                  style: const TextStyle(color: Colors.orangeAccent),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
