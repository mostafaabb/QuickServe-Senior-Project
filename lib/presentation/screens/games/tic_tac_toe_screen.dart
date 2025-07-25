import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;

  void _handleTap(int index) {
    if (board[index].isEmpty && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        winner = _checkWinner();
        if (winner == null) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  String? _checkWinner() {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var combo in wins) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[0]] == board[combo[2]]) {
        return board[combo[0]];
      }
    }
    return board.contains('') ? null : 'Draw';
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe'), backgroundColor: Colors.deepOrange),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Player: $currentPlayer', style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _handleTap(index),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.orange[50],
                ),
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(fontSize: 48, color: board[index] == 'X' ? Colors.red : Colors.green),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (winner != null)
            Text(
              winner == 'Draw' ? 'It\'s a Draw!' : '$winner Wins!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
