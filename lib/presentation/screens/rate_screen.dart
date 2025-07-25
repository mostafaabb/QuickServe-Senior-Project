import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/data/models/rating.dart';
import 'package:untitled1/presentation/providers/rating_provider.dart';
import 'package:untitled1/presentation/providers/user_provider.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  String? _submittedComment;

  final List<String> _quotes = [
    "⭐ One star or five, we value every opinion. 🙌",
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String quote = _quotes[DateTime.now().second % _quotes.length];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Rate Our App'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.deepOrangeAccent.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Motivational Quote
            Text(
              quote,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Main Rating Prompt
            Text(
              'How would you rate our app?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade700,
                letterSpacing: 0.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return IconButton(
                  icon: Icon(
                    _rating >= starIndex ? Icons.star : Icons.star_border,
                    size: 42,
                    color: Colors.deepOrange,
                    shadows: [
                      Shadow(
                        color: Colors.deepOrangeAccent.withOpacity(0.4),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = starIndex.toDouble();
                    });
                  },
                  splashRadius: 28,
                );
              }),
            ),
            const SizedBox(height: 12),

            // Emoji Reactions (decorative)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['😡', '😕', '😐', '😊', '😍'].map((emoji) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 34),

            // Comment Label
            Text(
              'Add a comment or report a problem:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),

            // Comment Box
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.deepOrange, width: 1.5),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Leave a comment to improve community service.',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 26),

            // Submitted Comment Display
            if (_submittedComment != null) ...[
              const Text(
                'Your submitted comment:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.15),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  _submittedComment!,
                  style: const TextStyle(fontSize: 16, height: 1.3),
                ),
              ),
              const SizedBox(height: 28),
            ],

            // Submit Button
            Consumer<RatingProvider>(
              builder: (context, ratingProvider, child) {
                if (ratingProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  );
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _rating == 0 ? Colors.deepOrange.shade200 : Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: Colors.deepOrangeAccent,
                  ),
                  onPressed: _rating == 0
                      ? null
                      : () async {
                    FocusScope.of(context).unfocus();

                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    final loggedUserId = userProvider.user?.id;

                    if (loggedUserId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You must be logged in to submit a rating.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final rating = Rating(
                      userId: loggedUserId,
                      rating: _rating.toInt(),
                      comment: _commentController.text.trim().isEmpty
                          ? null
                          : _commentController.text.trim(),
                    );

                    final success = await ratingProvider.submitRating(rating);

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success
                            ? 'Thanks for rating us ${_rating.toInt()} stars!'
                            : ratingProvider.errorMessage ?? 'Failed to submit rating'),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );

                    if (success) {
                      setState(() {
                        _submittedComment = _commentController.text.trim().isEmpty
                            ? null
                            : _commentController.text.trim();
                        _rating = 0;
                        _commentController.clear();
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _rating == 0 ? Colors.white70 : Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
