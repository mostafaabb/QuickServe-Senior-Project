import 'package:flutter/material.dart';
import 'tic_tac_toe_screen.dart';
import 'memory_game_screen.dart';
import 'puzzle_game_screen.dart';
import 'food_quiz_screen.dart';
import 'guess_food_emoji_screen.dart';
import 'healthy_or_not_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<Map<String, dynamic>> games = const [
    {
      'title': 'Tic Tac Toe',
      'icon': Icons.grid_3x3,
      'screen': TicTacToeScreen(),
      'color': Colors.orange,
      'subtitle': 'Classic strategy game',
    },
    {
      'title': 'Memory Game',
      'icon': Icons.memory,
      'screen': MemoryGameScreen(),
      'color': Colors.deepOrange,
      'subtitle': 'Test your memory skills',
    },
    {
      'title': 'Puzzle Game',
      'icon': Icons.extension,
      'screen': PuzzleGameScreen(),
      'color': Colors.redAccent,
      'subtitle': 'Solve the puzzles',
    },
    {
      'title': 'Guess the Food Emoji',
      'icon': Icons.emoji_food_beverage,
      'screen': GuessFoodEmojiScreen(),
      'color': Colors.amber,
      'subtitle': 'Fun emoji guessing',
    },
    {
      'title': 'Food Quiz',
      'icon': Icons.quiz,
      'screen': FoodQuizScreen(),
      'color': Colors.deepOrangeAccent,
      'subtitle': 'Test your food knowledge',
    },
    {
      'title': 'Healthy or Not?',
      'icon': Icons.favorite,
      'screen': HealthyOrNotScreen(),
      'color': Colors.green,
      'subtitle': 'Learn healthy choices',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Games'),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final game = games[index];
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => game['screen'] as Widget),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (game['color'] as Color).withOpacity(0.8),
                      (game['color'] as Color).withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (game['color'] as Color).withOpacity(0.4),
                      offset: const Offset(0, 8),
                      blurRadius: 12,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      game['icon'] as IconData,
                      size: 72,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        game['title'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black45,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        game['subtitle'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
