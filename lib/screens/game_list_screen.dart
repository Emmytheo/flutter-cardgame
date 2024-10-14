import 'package:flutter/material.dart';

class GameListScreen extends StatelessWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Game'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Crazy Eights'),
            onTap: () {
              // Add navigation to Crazy Eights game
            },
          ),
          ListTile(
            title: const Text('Thirty-One'),
            onTap: () {
              // Add navigation to Thirty-One game
            },
          ),
          ListTile(
            title: const Text('Whot'),
             onTap: () {
              Navigator.pushNamed(context, '/whotMenu');
            },
          ),
          ListTile(
            title: const Text('Draughts'),
            onTap: () {
              Navigator.pushNamed(context, '/draughtsMenu');
            },
          ),
        ],
      ),
    );
  }
}
