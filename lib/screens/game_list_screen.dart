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
          // ListTile(
          //   title: const Text('Crazy Eights'),
          //   onTap: () {
          //     // Add navigation to Crazy Eights game
          //   },
          // ),
          // ListTile(
          //   title: const Text('Thirty-One'),
          //   onTap: () {
          //     // Add navigation to Thirty-One game
          //   },
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              title: const Text('Whot'),
              subtitle: const Text('Game Type: Multiplayer'),
              onTap: () {
                Navigator.pushNamed(context, '/whotMenu');
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              title: const Text('Draughts'),
              subtitle: const Text('Game Type: Multiplayer'),
              onTap: () {
                Navigator.pushNamed(context, '/draughtsMenu');
              },
            ),
          ),
        ],
      ),
    );
  }
}
