import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardgame/providers/draughts_game_provider.dart';
import 'package:cardgame/models/coordinate.dart';
import 'package:cardgame/models/block_table.dart';
import 'package:cardgame/models/men.dart';

class DraughtsGameScreen extends StatelessWidget {
  const DraughtsGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DraughtsGameProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!provider.isMenInitialized) {
    //     provider.initMen(); // Initialize men pieces after the build.
    //   }
    // });

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
          } else if (provider.isGameStarted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!provider.isMenInitialized) {
                provider.initMen(); // Initialize men pieces after the build.
              }
            });
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
                child: Center(
                  child: buildGameTable(context, provider),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildGameTable(BuildContext context, DraughtsGameProvider provider) {
    List<Widget> listCol = [];
    for (int row = 0; row < provider.board.length; row++) {
      List<Widget> listRow = [];
      for (int col = 0; col < provider.board[row].length; col++) {
        listRow.add(buildBlockContainer(
            context, provider, Coordinate(row: row, col: col)));
      }
      listCol.add(Row(mainAxisSize: MainAxisSize.min, children: listRow));
    }
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.brown[700], // Color of the board border
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: listCol,
      ),
    );
  }

  Widget buildBlockContainer(
      BuildContext context, DraughtsGameProvider provider, Coordinate coor) {
    BlockTable block = provider.getBlock(coor);

    // Alternate color for board cells (checkered pattern)
    Color colorBackground = (coor.row + coor.col) % 2 == 0
        ? Colors.brown[200]!
        : Colors.brown[700]!;

    // Highlight colors
    if (block.isHighlight) {
      colorBackground = Colors.blue[500]!;
    } else if (block.isHighlightAfterKilling) {
      colorBackground = Colors.purple[500]!;
    } else {
      // print(block.men);
      // print(coor.row);
      // print(coor.col);
      // print(provider.isBlockTypeF(coor, 'opponent_piece'));
      // Check if the block contains the player's piece
      if (provider.isBlockTypeF(coor, 'your_piece')) {
        colorBackground = Colors.brown[200]!;
      }
    }

    // Men widget
    Widget menWidget;
    if (block.men != null) {
      Men men = block.men!;
      menWidget = Center(
        child: buildMenWidget(player: men.player, isKing: men.isKing, size: 40),
      );

      // Make draggable only if it's the current player's turn and their piece
      if (provider.yourTurn && men.player == provider.currentPlayerTurn!) {
        menWidget = Draggable<Men>(
          child: menWidget,
          feedback: menWidget,
          childWhenDragging: Container(),
          data: men,
          onDragStarted: () {
            provider.highlightWalkable(men);
          },
          onDragEnd: (details) {
            provider.clearHighlightWalkable();
          },
        );
      }
    } else {
      menWidget = Container(); // Empty block if no Men
    }

    // DragTarget for each block
    return DragTarget<Men>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 40,
          height: 40,
          color: colorBackground,
          margin: const EdgeInsets.all(2),
          child: menWidget,
        );
      },
      onWillAcceptWithDetails: (details) {
        return block.isHighlight || block.isHighlightAfterKilling;
      },
      onAcceptWithDetails: (details) {
        // Extract the source block coordinates (where the piece is being dragged from)
        final fromRow = details.data.coordinate.row;
        final fromCol = details.data.coordinate.col;

        // Extract the destination block coordinates (where the piece is being dragged to)
        final toRow = block.row;
        final toCol = block.col;

        // Print the move information for debugging
        print(
            'Moving player from Block ($fromCol, $fromRow) to Block ($toCol, $toRow)');

        // Validate and execute the move for the logged-in player
        provider.makeMove(
          Coordinate(row: fromRow, col: fromCol),
          Coordinate(row: toRow, col: toCol),
        );
      },
    );
  }

  Widget buildMenWidget(
      {int player = 1, bool isKing = false, double size = 30}) {
    if (isKing) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: player == 1 ? Colors.black : Colors.white,
        ),
        child:
            Icon(Icons.star, color: player == 1 ? Colors.white : Colors.black),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: player == 1 ? Colors.black : Colors.white,
      ),
    );
  }
}
