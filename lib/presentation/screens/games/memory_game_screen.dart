import 'package:flutter/material.dart';
import 'dart:math';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late List<String> _emojis;
  late List<bool> _revealed;
  List<int> _selectedIndexes = [];
  bool _canTap = true;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _emojis = ['🍎', '🍌', '🍇', '🍉', '🍎', '🍌', '🍇', '🍉'];
    _emojis.shuffle(Random());
    _revealed = List.filled(_emojis.length, false);
    _selectedIndexes.clear();
    _canTap = true;
    setState(() {});
  }

  void _onTap(int index) {
    if (!_canTap || _revealed[index] || _selectedIndexes.contains(index)) return;

    setState(() {
      _revealed[index] = true;
      _selectedIndexes.add(index);
    });

    if (_selectedIndexes.length == 2) {
      _canTap = false;
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          final first = _selectedIndexes[0];
          final second = _selectedIndexes[1];
          if (_emojis[first] != _emojis[second]) {
            _revealed[first] = false;
            _revealed[second] = false;
          }
          _selectedIndexes.clear();
          _canTap = true;
        });
      });
    }

    if (_revealed.every((r) => r)) {
      Future.delayed(const Duration(milliseconds: 600), () {
        _showWinDialog();
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🎉 You Won!"),
        content: const Text("Great memory! Want to play again?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _emojis.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _revealed[index] ? Colors.white : primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _revealed[index] ? _emojis[index] : '❓',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: _startGame,
              icon: const Icon(Icons.refresh),
              label: const Text("Restart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
