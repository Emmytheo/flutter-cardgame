import 'package:cardgame/constants.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhotMenuScreen extends StatefulWidget {
  const WhotMenuScreen({Key? key}) : super(key: key);

  @override
  _WhotMenuScreenState createState() => _WhotMenuScreenState();
}

class _WhotMenuScreenState extends State<WhotMenuScreen> {
  @override
  void initState() {
    super.initState();

    final whotProvider = Provider.of<WhotGameProvider>(context, listen: false);

    // Connect to the WebSocket server here when the menu screen loads
    // whotProvider.connectToServer("ws://localhost:8080");

    // Request the list of available games
    WidgetsBinding.instance.addPostFrameCallback((_) {
      whotProvider.listGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: chachaBackground(),
      child: Scaffold(
        floatingActionButton:
            Consumer<WhotGameProvider>(builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: () => {provider.createNewGame(), provider.listGames()},
            child: const Icon(Icons.add),
          );
        }),
        appBar: AppBar(
          title: const Text(
            'Whot Menu',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: chachaAppBarColor(),
          actions: [
            Consumer<WhotGameProvider>(builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.replay_outlined),
                onPressed: () => {provider.listGames()},
              );
            })
          ],
        ),
        body: Consumer<WhotGameProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // ElevatedButton(
                //   onPressed: () =>
                //       {provider.createNewGame(), provider.listGames()},
                //   child: const Text('Create New Game'),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: provider.gameList!.isNotEmpty
                        ? ListView.builder(
                            itemCount: provider.gameList!.length,
                            itemBuilder: (context, index) {
                              final game = provider.gameList![index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: chachaLightColor(),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                    // tileColor: const Color(0xffc16c34),
                                    title: Text('Game #${game.game_id}'),
                                    subtitle: Text(
                                        '(${game.players} / ${game.noOfPlayers}) Players - ${game.listeners} Listeners'),
                                    trailing: provider.currentGame != null &&
                                            provider.currentGame!.game_id ==
                                                game.game_id
                                        ? TextButton(
                                            onPressed: () async {
                                              Navigator.pushNamed(
                                                  context, '/whotGame');
                                            },
                                            child: const Text('Resume Game'),
                                          )
                                        : TextButton(
                                            onPressed: () async {
                                              await provider
                                                  .setCurrentGame(game);
                                              // await model.setupListeners(game);
                                              await provider.setupGame(game);
                                              print(provider.currentGame);
                                              print(provider.gameStart);
                                              Navigator.pushNamed(
                                                  context, '/whotGame');
                                            },
                                            child: const Text('Start Game'),
                                          )),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                                'No Available Games, Use + icon to create one'),
                          )),
              ],
            );
          },
        ),
      ),
    );
  }
}
