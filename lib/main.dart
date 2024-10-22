import 'package:cardgame/providers/crazy_eights_game_provider.dart';
import 'package:cardgame/providers/thirty_one_game_provider.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:cardgame/providers/draughts_game_provider.dart';
import 'package:cardgame/screens/game_screen.dart';
import 'package:cardgame/screens/whot_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cardgame/screens/game_list_screen.dart';
import 'package:cardgame/screens/draughts_menu_screen.dart';
import 'package:cardgame/screens/draughts_game_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CrazyEightsGameProvider()),
        ChangeNotifierProvider(create: (_) => ThirtyOneGameProvider()),
        ChangeNotifierProvider(create: (_) => WhotGameProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                DraughtsGameProvider()), // Added DraughtsGameProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Game',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffeec295),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff9a6851)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GameListScreen(),
        '/draughtsMenu': (context) =>
            const DraughtsMenuScreen(), // Route to DraughtsMenuScreen
        '/draughtsGame': (context) =>
            const DraughtsGameScreen(), // Route to DraughtsGameScreen
        '/whotMenu': (context) =>
            const WhotMenuScreen(), // Route to DraughtsMenuScreen
        '/whotGame': (context) =>
            const GameScreen(), // Route to DraughtsMenuScreen
      },
    );
  }
}
