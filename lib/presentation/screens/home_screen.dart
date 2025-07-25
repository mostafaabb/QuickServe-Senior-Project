import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled1/data/models/food_model.dart';
import 'package:untitled1/presentation/providers/cart_provider.dart';
import 'package:untitled1/presentation/providers/food_provider.dart';
import 'package:untitled1/presentation/providers/offer_provider.dart';
import 'package:untitled1/presentation/providers/user_provider.dart';

import 'package:untitled1/presentation/widgets/category_card.dart';
import 'package:untitled1/presentation/widgets/food_card.dart';
import 'package:untitled1/presentation/widgets/offer_carousel.dart';
import 'package:untitled1/presentation/providers/bus_provider.dart';
import 'setting_screen.dart';
import 'cart_screen.dart';
import 'barcode_screen.dart';
import 'ai_assistant/ai_assistant_screen.dart';
import 'games/games_screen.dart';
import 'rate_screen.dart';
import 'favorite_screen.dart'; // Make sure this exists

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<FoodModel> filteredFoods = [];
  String searchQuery = '';
  bool _isLoading = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final foodProvider = Provider.of<FoodProvider>(context, listen: false);
      final offerProvider = Provider.of<OfferProvider>(context, listen: false);
      await Future.wait([
        foodProvider.fetchAllData(),
        offerProvider.loadOffers(),
      ]);
      filteredFoods = List.from(foodProvider.foods);
      _animationController.forward();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void searchFoods(String query) {
    final foodProvider = Provider.of<FoodProvider>(context, listen: false);
    final allFoods = foodProvider.foods;

    if (query.isEmpty) {
      setState(() {
        filteredFoods = List.from(allFoods);
        searchQuery = '';
      });
    } else {
      final results = allFoods
          .where((food) => food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredFoods = results;
        searchQuery = query;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<void> _onRefresh() async {
    await _loadData();
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: _onRefresh,
          child: FadeTransition(opacity: _fadeAnimation, child: _buildHomeContent()),
        );
      case 1:
        return const CartScreen();
      case 2:
        return const BarcodeScreen();
      case 3:
        return const AiAssistantScreen();
      case 4:
        return const RateScreen();
      case 5:
        return const GamesScreen();
      case 6:
        return const SettingScreen();
    // Removed Favorites from navigation here
      default:
        return _buildHomeContent();
    }
  }
  Widget _buildHomeContent() {
    final foodProvider = Provider.of<FoodProvider>(context);
    final offerProvider = Provider.of<OfferProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final userName = userProvider.user?.name ?? "Student";
    final primaryColor = Colors.deepOrange.shade700;
    final secondaryColor = Colors.deepOrange.shade400;

    final studentQuotes = [
      "🚀 QuickServe. 🍜 Comfort. 😌 Peace of Mind.",
    ];

    String randomQuote = studentQuotes[DateTime.now().second % studentQuotes.length];

    Widget sectionTitle(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Divider(
                color: secondaryColor.withOpacity(0.7),
                thickness: 2,
                endIndent: 8,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Hello, $userName 👋',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
          ),
          // Quote
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 800),
            child: Text(
              randomQuote,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 12),  // Reduced spacing to bring search closer to quote

          // SEARCH BAR - moved directly below the quote
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: TextField(
              onChanged: searchFoods,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search tasty foods 🍔🍕🍣...",
                icon: Icon(Icons.search, color: primaryColor),
              ),
            ),
          ),

          const SizedBox(height: 28), // spacing before next sections

          // Bus Booking Shortcut
          sectionTitle("Available Services"),
          _quickAccessCard(
            title: "University Buses",
            subtitle: "Need a ride? Book a bus now.",
            icon: Icons.directions_bus,
            color: Colors.blueAccent,
            onTap: () => Navigator.pushNamed(context, '/availableBuses'),
          ),
          const SizedBox(height: 16),
          _quickAccessCard(
            title: "Drivers",
            subtitle: "View and contact available drivers.",
            icon: Icons.person_pin_circle,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/availableDrivers'),
          ),

          const SizedBox(height: 16),
          _quickAccessCard(
            title: "Picnic Places",
            subtitle: "Find the best food picnic spots nearby.",
            icon: Icons.park,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, '/picnicPlaces'),
          ),
          const SizedBox(height: 28),

          // const SizedBox(height: 16),
          // _quickAccessCard(
          //   title: "Picnic Places",
          //   subtitle: "Find the best food picnic spots nearby.",
          //   icon: Icons.park,
          //   color: Colors.orange,
          //   onTap: () => Navigator.pushNamed(context, '/picnicPlaces'),
          // ),

          // Offers
          if (offerProvider.offers.isNotEmpty) ...[
            sectionTitle("🔥 Hot Offers"),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: OfferCarousel(),
            ),
            const SizedBox(height: 30),
          ],

          // Categories
          sectionTitle("Browse Categories"),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: foodProvider.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return CategoryCard(category: foodProvider.categories[index]);
              },
            ),
          ),
          const SizedBox(height: 30),

          // Trending
          if (foodProvider.trendingFoods.isNotEmpty) ...[
            sectionTitle("🔥 Trending Now"),
            _buildFoodGrid(foodProvider.trendingFoods),
            const SizedBox(height: 30),
          ],

          // Popular Picks
          sectionTitle("🍟 Popular Picks"),
          if (filteredFoods.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  'No results for "$searchQuery". Try a different search.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            _buildFoodGrid(filteredFoods),
        ],
      ),
    );
  }

  Widget _quickAccessCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFoodGrid(List<FoodModel> foods) {
    final primaryColor = Colors.deepOrange.shade700;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            elevation: 4,
            shadowColor: primaryColor.withOpacity(0.15),
            child: FoodCard(food: food),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('QuickServe', style: TextStyle(color: Colors.deepOrange)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.deepOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
            tooltip: 'Favorites',
          ),
          IconButton(
            icon: const Icon(Icons.directions_bus, color: Colors.deepOrange),
            onPressed: () {
              final userId = Provider.of<UserProvider>(context, listen: false).user?.id;
              if (userId != null) {
                Provider.of<BusProvider>(context, listen: false).fetchUserBookings(userId);
              }
              Navigator.pushNamed(context, '/myBusBookings');
            },
            tooltip: 'My Bus Bookings',
          ),

          // Add this for the profile avatar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                final user = userProvider.user;
                if (user == null) {
                  return IconButton(
                    icon: const Icon(Icons.person, color: Colors.deepOrange),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile'); // or your profile route
                    },
                    tooltip: 'Profile',
                  );
                }

                if (user.avatar != null && user.avatar!.isNotEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(user.avatar!),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                // Fallback to initials if no avatar image
                String initials = '';
                if (user.name.isNotEmpty) {
                  final parts = user.name.split(' ');
                  initials = parts.length >= 2
                      ? '${parts[0][0]}${parts[1][0]}'
                      : user.name.substring(0, 1);
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.deepOrange.shade400,
                    child: Text(
                      initials.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrange.shade700,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Barcode'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.star_rate), label: 'Rate'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          // Removed the Favorites tab from bottom navigation bar
        ],
      ),
    );
  }
}
