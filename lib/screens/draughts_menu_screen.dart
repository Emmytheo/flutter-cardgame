import 'package:flutter/material.dart';

class DraughtsMenuScreen extends StatelessWidget {
  const DraughtsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController gameIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draughts Menu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/draughtsGame',
                  arguments: {'action': 'create'});
            },
            child: const Text('Create Game'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: gameIdController,
              decoration:
                  const InputDecoration(hintText: 'Enter Game ID to Join'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (gameIdController.text.isNotEmpty) {
                Navigator.pushNamed(context, '/draughtsGame', arguments: {
                  'action': 'join',
                  'gameId': gameIdController.text
                });
              }
            },
            child: const Text('Join Game'),
          ),
        ],
      ),
    );
  }
}
