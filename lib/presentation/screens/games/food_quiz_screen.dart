import 'package:flutter/material.dart';

class FoodQuizScreen extends StatefulWidget {
  const FoodQuizScreen({super.key});

  @override
  State<FoodQuizScreen> createState() => _FoodQuizScreenState();
}

class _FoodQuizScreenState extends State<FoodQuizScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Which fruit is known as the "King of Fruits"?',
      'options': ['Apple', 'Mango', 'Banana', 'Orange'],
      'answer': 'Mango',
      'reward': 10,
    },
    {
      'question': 'Which vegetable is used to make sauerkraut?',
      'options': ['Cabbage', 'Carrot', 'Spinach', 'Broccoli'],
      'answer': 'Cabbage',
      'reward': 10,
    },
    {
      'question': 'Which spice is known as the most expensive in the world?',
      'options': ['Saffron', 'Vanilla', 'Cinnamon', 'Pepper'],
      'answer': 'Saffron',
      'reward': 15,
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _rewardPoints = 0;
  bool _answered = false;
  String? selectedOption;

  void _answerQuestion(String option) {
    if (_answered) return;
    setState(() {
      _answered = true;
      selectedOption = option;
      final correctAnswer = _questions[_currentQuestionIndex]['answer'] as String;
      if (option == correctAnswer) {
        _score++;
        // Add reward points for this question
        _rewardPoints += (_questions[_currentQuestionIndex]['reward'] as int);
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex + 1 < _questions.length) {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        selectedOption = null;
      });
    } else {
      // Quiz finished — show reward dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RewardDialog(pointsWon: _rewardPoints),
      );
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _rewardPoints = 0;
      _answered = false;
      selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      // This block is no longer needed because dialog shows at the end
      return Scaffold(
        appBar: AppBar(title: const Text('Food Quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Completed!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade700),
              ),
              const SizedBox(height: 20),
              Text('Your score: $_score / ${_questions.length}',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              Text('You earned $_rewardPoints reward points!',
                  style: const TextStyle(fontSize: 20, color: Colors.green)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: _restartQuiz,
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final options = question['options'] as List<String>;
    final correctAnswer = question['answer'] as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Food Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text(question['question'] as String,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ...options.map(
                  (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_answered
                        ? Colors.deepOrange
                        : option == correctAnswer
                        ? Colors.green
                        : option == selectedOption
                        ? Colors.red
                        : null,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => _answerQuestion(option),
                  child: Text(option, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const Spacer(),
            if (_answered)
              Center(
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                  onPressed: _nextQuestion,
                  child: const Text('Next Question'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RewardDialog extends StatelessWidget {
  final int pointsWon;

  const RewardDialog({Key? key, required this.pointsWon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Congratulations! 🎉'),
      content: Text('You earned $pointsWon reward points!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Go back from quiz screen or you can restart
          },
          child: const Text('Awesome!'),
        ),
      ],
    );
  }
}
