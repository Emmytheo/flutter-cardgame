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
      appBar: AppBar(
        title: const Text('Draughts Menu'),
      ),
      body: Consumer<DraughtsGameProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => {
                  provider.createGame(),
                  provider.listAvailableGames()
                },
                child: const Text('Create New Game'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.availableGames.length,
                  itemBuilder: (context, index) {
                    final game = provider.availableGames[index];
                    return ListTile(
                      title: Text('Game ID: ${game['gameId']}'),
                      subtitle: Text('Game Type: ${game['gameType']}'),
                      onTap: () {
                        provider.joinGame(game['gameId']);
                        Navigator.pushNamed(context, '/draughtsGame');
                      },
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
