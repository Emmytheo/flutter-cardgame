import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DraughtsGameScreen extends StatefulWidget {
  const DraughtsGameScreen({Key? key}) : super(key: key);

  @override
  _DraughtsGameScreenState createState() => _DraughtsGameScreenState();
}

class _DraughtsGameScreenState extends State<DraughtsGameScreen> {
  WebSocketChannel? channel;
  String? gameId;
  int? playerNumber;
  bool yourTurn = false;

  @override
  void initState() {
    super.initState();
    // Connection will be handled in didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if there are any arguments passed, and ensure they are of type Map
    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    if (channel == null && args != null) {
      // Connect to the WebSocket server once dependencies are ready
      connectToServer(args);
    }
  }

  void connectToServer(Map args) {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

    channel!.stream.listen((message) {
      final data = jsonDecode(message);
      switch (data['type']) {
        case 'gameCreated':
          setState(() {
            gameId = data['gameId'];
          });
          break;
        case 'gameJoined':
          setState(() {
            playerNumber = data['playerNumber'];
          });
          break;
        case 'start':
          setState(() {
            yourTurn = data['yourTurn'];
          });
          break;
        case 'opponentMove':
          handleOpponentMove(data['move']);
          break;
        case 'opponentLeft':
          handleOpponentLeft();
          break;
      }
    });

    if (args['action'] == 'create') {
      createGame();
    } else if (args['action'] == 'join') {
      joinGame(args['gameId']);
    }
  }

  void createGame() {
    channel!.sink.add(jsonEncode({'type': 'createGame'}));
  }

  void joinGame(String gameId) {
    channel!.sink.add(jsonEncode({'type': 'joinGame', 'gameId': gameId}));
  }

  void handleOpponentMove(move) {
    setState(() {
      yourTurn = true;
    });
  }


  void handleOpponentLeft() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Opponent left'),
              content: const Text('The game has ended.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draughts Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gameId != null ? 'Game ID: $gameId' : 'Connecting...'),
            Text(playerNumber != null ? 'Player $playerNumber' : ''),
            Text(yourTurn ? 'Your turn!' : 'Waiting for opponent...'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }
}
