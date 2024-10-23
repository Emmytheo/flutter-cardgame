import 'package:cardgame/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardgame/providers/draughts_game_provider.dart';

class DraughtsMenuScreen extends StatefulWidget {
  const DraughtsMenuScreen({Key? key}) : super(key: key);

  @override
  _DraughtsMenuScreenState createState() => _DraughtsMenuScreenState();
}

class _DraughtsMenuScreenState extends State<DraughtsMenuScreen> {
  @override
  void initState() {
    super.initState();

    final draughtsProvider =
        Provider.of<DraughtsGameProvider>(context, listen: false);

    // Connect to the WebSocket server here when the menu screen loads
    draughtsProvider.connectToServer("ws://localhost:8080");

    // Request the list of available games
    WidgetsBinding.instance.addPostFrameCallback((_) {
      draughtsProvider.listAvailableGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: chachaBackground(),
      child: Scaffold(
        floatingActionButton:
            Consumer<DraughtsGameProvider>(builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: () =>
                {provider.createGame(), provider.listAvailableGames()},
            child: const Icon(Icons.add),
          );
        }),
        appBar: AppBar(
          title: const Text(
            'Draughts Menu',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: chachaAppBarColor(),
          actions: [
            Consumer<DraughtsGameProvider>(builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.replay_outlined),
                onPressed: () => {provider.listAvailableGames()},
              );
            })
          ],
        ),
        body: Consumer<DraughtsGameProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // ElevatedButton(
                //   onPressed: () =>
                //       {provider.createGame(), provider.listAvailableGames()},
                //   child: const Text('Create New Game'),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: provider.availableGames.isNotEmpty
                        ? ListView.builder(
                            itemCount: provider.availableGames.length,
                            itemBuilder: (context, index) {
                              final game = provider.availableGames[index];
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
                                  title: Text(
                                      'Game ID: ${game['gameId'].toString().split('-')[0]}-*****-${game['gameId'].toString().split('-')[game['gameId'].toString().split('-').length - 1]}'),
                                  subtitle:
                                      Text('Game Type: ${game['gameType']}'),
                                  trailing: provider.gameId == game['gameId']
                                      ? TextButton(
                                          onPressed: () async {
                                            Navigator.pushNamed(
                                                context, '/draughtsGame');
                                          },
                                          child: const Text('Resume Game'),
                                        )
                                      : TextButton(
                                          onPressed: () async {
                                            provider.joinGame(game['gameId']);
                                            Navigator.pushNamed(
                                                context, '/draughtsGame');
                                          },
                                          child: const Text('Join Game'),
                                        ),
                                  // onTap: () {
                                  //   if(provider.gameId != game['gameId']){
                                  //     provider.joinGame(game['gameId']);
                                  //   }
                                  //   Navigator.pushNamed(context, '/draughtsGame');
                                  // },
                                ),
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
