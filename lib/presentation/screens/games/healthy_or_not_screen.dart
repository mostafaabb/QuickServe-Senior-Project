import 'package:flutter/material.dart';

class HealthyOrNotScreen extends StatefulWidget {
  const HealthyOrNotScreen({super.key});

  @override
  State<HealthyOrNotScreen> createState() => _HealthyOrNotScreenState();
}

class _HealthyOrNotScreenState extends State<HealthyOrNotScreen> {
  final List<Map<String, Object>> _foods = [
    {'name': 'Apple', 'emoji': '🍎', 'isHealthy': true},
    {'name': 'Chocolate Cake', 'emoji': '🍰', 'isHealthy': false},
    {'name': 'Carrot', 'emoji': '🥕', 'isHealthy': true},
    {'name': 'French Fries', 'emoji': '🍟', 'isHealthy': false},
    {'name': 'Salmon', 'emoji': '🍣', 'isHealthy': true},
    {'name': 'Soda', 'emoji': '🥤', 'isHealthy': false},
  ];

  int _currentIndex = 0;
  int _score = 0;
  String _feedback = '';

  void _answer(bool choice) {
    final correct = _foods[_currentIndex]['isHealthy'] as bool;
    setState(() {
      if (choice == correct) {
        _score++;
        _feedback = 'Correct!';
      } else {
        _feedback = 'Wrong!';
      }
    });
  }

  void _next() {
    setState(() {
      _feedback = '';
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _foods.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Healthy or Not')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your score: $_score / ${_foods.length}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: () {
                  setState(() {
                    _score = 0;
                    _currentIndex = 0;
                    _feedback = '';
                  });
                },
                child: const Text('Play Again'),
              )
            ],
          ),
        ),
      );
    }

    final food = _foods[_currentIndex];
    final String foodName = food['name'] as String;
    final String foodEmoji = food['emoji'] as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Healthy or Not')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$foodEmoji  $foodName',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => _answer(true),
                  child: const Text('Healthy', style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _answer(false),
                  child: const Text('Not Healthy', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              _feedback,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _feedback == 'Correct!' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 30),
            if (_feedback.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: _next,
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}
