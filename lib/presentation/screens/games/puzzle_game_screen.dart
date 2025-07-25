import 'package:flutter/material.dart';
import 'dart:math';

class PuzzleGameScreen extends StatefulWidget {
  const PuzzleGameScreen({super.key});

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  static const int gridSize = 3;
  late List<int> tiles;
  final int emptyTile = 0;

  @override
  void initState() {
    super.initState();
    _initTiles();
  }

  void _initTiles() {
    // Initialize a solvable shuffled puzzle
    tiles = List.generate(gridSize * gridSize, (index) => index);
    do {
      tiles.shuffle();
    } while (!_isSolvable(tiles) || _isCompleted());
    setState(() {});
  }

  bool _isCompleted() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  // Check if the puzzle is solvable (based on inversion count)
  bool _isSolvable(List<int> list) {
    int inversions = 0;
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (list[i] != 0 && list[j] != 0 && list[i] > list[j]) {
          inversions++;
        }
      }
    }
    // For odd grid size, number of inversions must be even
    return inversions % 2 == 0;
  }

  void _moveTile(int index) {
    int emptyIndex = tiles.indexOf(emptyTile);
    int row = index ~/ gridSize;
    int col = index % gridSize;
    int emptyRow = emptyIndex ~/ gridSize;
    int emptyCol = emptyIndex % gridSize;

    // Check if clicked tile is adjacent to empty tile
    if ((row == emptyRow && (col - emptyCol).abs() == 1) ||
        (col == emptyCol && (row - emptyRow).abs() == 1)) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = emptyTile;
      });

      if (_isCompleted()) {
        _showCompletedDialog();
      }
    }
  }

  void _showCompletedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You solved the puzzle! 🎉'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initTiles();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(int number, int index) {
    if (number == emptyTile) {
      return Container(
        color: Colors.deepOrange.shade100,
      );
    }
    return GestureDetector(
      onTap: () => _moveTile(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.shade700.withOpacity(0.6),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double gridSizePx = MediaQuery.of(context).size.width - 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initTiles,
            tooltip: 'Restart',
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: gridSizePx,
          height: gridSizePx,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: tiles.length,
            itemBuilder: (context, index) => _buildTile(tiles[index], index),
          ),
        ),
      ),
    );
  }
}
