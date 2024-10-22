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
    return Scaffold(
      floatingActionButton:
          Consumer<DraughtsGameProvider>(builder: (context, provider, child) {
        return FloatingActionButton(
          onPressed: () =>
              {provider.createGame(), provider.listAvailableGames()},
          child: const Icon(Icons.add),
        );
      }),
      appBar: AppBar(
        title: const Text('Draughts Menu'),
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.availableGames.length,
                  itemBuilder: (context, index) {
                    final game = provider.availableGames[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        subtitle: Text('Game Type: ${game['gameType']}'),
                        onTap: () {
                          provider.joinGame(game['gameId']);
                          Navigator.pushNamed(context, '/draughtsGame');
                        },
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
