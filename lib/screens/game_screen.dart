import 'package:cardgame/components/game_board.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/providers/crazy_eights_game_provider.dart';
import 'package:cardgame/providers/thirty_one_game_provider.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // late final ThirtyOneGameProvider _gameProvider;
  // late final CrazyEightsGameProvider _gameProvider;
  late WhotGameProvider _gameProvider;

  @override
  void initState() {
    // _gameProvider = Provider.of<ThirtyOneGameProvider>(context, listen: false);
    // _gameProvider = Provider.of<CrazyEightsGameProvider>(context, listen: false);
    _gameProvider = Provider.of<WhotGameProvider>(context, listen: false);
    print(_gameProvider.junk);
    _gameProvider.listGames();
    // await _gameProvider._channel.ready;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _gameProvider = Provider.of<WhotGameProvider>(context, listen: true);
    // // print(_gameProvider.junk);
    // _gameProvider.listGames();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await _gameProvider.listGames();
      //   },
      //   foregroundColor: Colors.white,
      //   backgroundColor: Color(0xff6d3935),
      //   shape: CircleBorder(),
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: _gameProvider.currentGame != null
            ? Text("Game ${_gameProvider.currentGame!.game_id}")
            : const Text(
                "Cha Cha Games",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          TextButton(
            onPressed: () async {
              // final players = [
              //   PlayerModel(name: "Tyler", isHuman: true),
              //   PlayerModel(name: "Bot", isHuman: false),
              // ];

              // await _gameProvider.newGame(players);
              await _gameProvider.listGames();
            },
            child: GestureDetector(
              onTap: () async {
                await _gameProvider.createNewGame();
              },
              child: const Text(
                "New Game",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: const GameBoard(),
    );
  }
}
