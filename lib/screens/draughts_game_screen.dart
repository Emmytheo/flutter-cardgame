import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardgame/providers/draughts_game_provider.dart';

class DraughtsGameScreen extends StatelessWidget {
  const DraughtsGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draughts Game'),
      ),
      body: Consumer<DraughtsGameProvider>(
        builder: (context, provider, child) {
          if (!provider.isGameStarted) {
            return Center(
              child: Text('Waiting for the game to start...'),
            );
          }

          return Column(
            children: [
              Text(
                provider.yourTurn
                    ? "It's your turn"
                    : "Waiting for opponent...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: 8 * 8, // 8x8 draughts board
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemBuilder: (context, index) {
                    final row = index ~/ 8;
                    final col = index % 8;
                    return GestureDetector(
                      onTap: provider.yourTurn
                          ? () {
                              provider.makeMove(row, col);
                            }
                          : null,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        color: (row + col) % 2 == 0
                            ? Colors.black
                            : Colors.white, // Chessboard pattern
                        child: Center(
                          child: Text(provider.board[row][col] == ''
                              ? ''
                              : provider.board[row][col]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



