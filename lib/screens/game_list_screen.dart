import 'package:cardgame/constants.dart';
import 'package:flutter/material.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    const List<Widget> _pages = <Widget>[
      GamesHomePage(),
      Icon(
        Icons.camera,
        size: 150,
      ),
      Icon(
        Icons.chat,
        size: 150,
      ),
      Icon(
        Icons.chat,
        size: 150,
      ),
    ];

    return Container(
      decoration: chachaBackground(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Select a Game',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: chachaAppBarColor(),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: chachaBottomAppBarColor(),
            elevation: 0,
            iconSize: 26,
            selectedFontSize: 12,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 26),
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedIconTheme: IconThemeData(
              color: chachaLightColor().withAlpha(125),
            ),
            unselectedItemColor: chachaLightColor().withAlpha(125),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.casino),
              //   label: 'Casino',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped, //New
          ),
          drawer: Drawer(
            child: Container(
              decoration: chachaBackground(),
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: chachaAppBarColor(),
                    ),
                    child: Center(
                      child: Image.asset(
                        "images/logo.png",
                        width: 128,
                        height: 128,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(246, 198, 237, 0.36),
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 2),
                      //   ),
                      // ],
                    ),
                    child: ListTile(
                      title: const Text(
                        'Item 1',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(246, 198, 237, 0.36),
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 2),
                      //   ),
                      // ],
                    ),
                    child: ListTile(
                      title: const Text(
                        'Item 2',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          )),
    );
  }
}

class GamesHomePage extends StatelessWidget {
  const GamesHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            title: const Text('Draughts'),
            subtitle: const Text('Game Type: Multiplayer'),
            onTap: () {
              Navigator.pushNamed(context, '/draughtsMenu');
            },
          ),
        ),
      ],
    );
  }
}
