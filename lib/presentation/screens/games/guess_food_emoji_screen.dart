import 'package:flutter/material.dart';

class GuessFoodEmojiScreen extends StatefulWidget {
  const GuessFoodEmojiScreen({Key? key}) : super(key: key);

  @override
  State<GuessFoodEmojiScreen> createState() => _GuessFoodEmojiScreenState();
}

class _GuessFoodEmojiScreenState extends State<GuessFoodEmojiScreen> {
  final List<Map<String, String>> _emojiQuestions = [
    {'emoji': '🍕', 'answer': 'pizza'},
    {'emoji': '🍔', 'answer': 'burger'},
    {'emoji': '🍣', 'answer': 'sushi'},
    {'emoji': '🍩', 'answer': 'donut'},
    {'emoji': '🍎', 'answer': 'apple'},
  ];

  int _currentQuestionIndex = 0;
  final TextEditingController _controller = TextEditingController();
  String _message = '';

  void _checkAnswer() {
    final userAnswer = _controller.text.trim().toLowerCase();
    final correctAnswer = _emojiQuestions[_currentQuestionIndex]['answer']!;

    setState(() {
      if (userAnswer == correctAnswer) {
        _message = 'Correct! 🎉';
        _currentQuestionIndex =
            (_currentQuestionIndex + 1) % _emojiQuestions.length;
      } else {
        _message = 'Try again!';
      }
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentEmoji = _emojiQuestions[_currentQuestionIndex]['emoji'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Food Emoji'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(  // <-- Wrap with SingleChildScrollView here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currentEmoji ?? '',
                style: const TextStyle(fontSize: 100),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Your Guess',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _checkAnswer(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: _checkAnswer,
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 30),
              Text(
                _message,
                style: TextStyle(
                  fontSize: 20,
                  color: _message == 'Correct! 🎉'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
