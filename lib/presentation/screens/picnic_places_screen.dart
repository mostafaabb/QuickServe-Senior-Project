import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../presentation/providers/picnic_place_provider.dart';
import '../../data/models/picnic_place_model.dart';

class PicnicPlacesScreen extends StatefulWidget {
  const PicnicPlacesScreen({Key? key}) : super(key: key);

  @override
  _PicnicPlacesScreenState createState() => _PicnicPlacesScreenState();
}

class _PicnicPlacesScreenState extends State<PicnicPlacesScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch picnic places once when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PicnicPlaceProvider>(context, listen: false).fetchPicnicPlaces();
    });
  }

  Future<void> _launchMaps(String location) async {
    final encoded = Uri.encodeComponent(location);
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Show error if URL cannot be launched
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open map')),
        );
      }
    }
  }

  void _showPlaceDetails(BuildContext context, PicnicPlace place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              if (place.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    place.image!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 180,
                        color: Colors.orange.shade100,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.deepOrange.shade300,
                      child: const Icon(Icons.broken_image, size: 64, color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(place.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.deepOrange),
                  const SizedBox(width: 6),
                  Expanded(child: Text(place.location, style: const TextStyle(fontSize: 16, color: Colors.black87))),
                ],
              ),
              const SizedBox(height: 16),
              Text(place.description, style: const TextStyle(fontSize: 16, height: 1.4)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Visit Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _launchMaps(place.location),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PicnicPlaceProvider>(context);
    final filteredPlaces = _searchQuery.isEmpty
        ? provider.places
        : provider.places
        .where((place) => place.location.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        title: const Text('🌳 Picnic Places'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search by location...',
                prefixIcon: const Icon(Icons.location_on, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.deepOrange.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.orange.shade100,
      body: RefreshIndicator(
        onRefresh: provider.fetchPicnicPlaces,
        color: Colors.deepOrange,
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.deepOrange))
            : filteredPlaces.isEmpty
            ? Center(
          child: Text(
            'No picnic places found.',
            style: TextStyle(
              color: Colors.deepOrange.shade400,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: filteredPlaces.length,
          itemBuilder: (context, index) {
            final place = filteredPlaces[index];
            return GestureDetector(
              onTap: () => _showPlaceDetails(context, place),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade300.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: place.image != null
                            ? Image.network(
                          place.image!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 120,
                          height: 120,
                          color: Colors.deepOrange.shade300,
                          child: const Icon(Icons.park, size: 64, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange.shade900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 18, color: Colors.deepOrange),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    place.location,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.deepOrange.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              place.description,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.deepOrange.shade800,
                                height: 1.3,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
