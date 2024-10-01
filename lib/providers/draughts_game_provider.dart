import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class DraughtsGameProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  String? gameId;
  bool yourTurn = false;
  List<List<String>> board = List.generate(8, (_) => List.filled(8, ''));
  bool isGameStarted = false;
  bool gameJoined = false;

  // List to hold available games
  List<Map<String, dynamic>> _availableGames = [];

  List<Map<String, dynamic>> get availableGames => _availableGames;

  // Connect to the WebSocket server
  void connectToServer(String serverUrl) {
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));

    _channel!.stream.listen((message) {
      handleServerMessages(message);
    });
  }

  // Send messages to the WebSocket server
  void sendMessage(Map<String, dynamic> data) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(data));
    }
  }

  // Handle server messages
  void handleServerMessages(String message) {
    final data = jsonDecode(message);

    switch (data['type']) {
      case 'gameCreated':
        gameId = data['gameId'];
        notifyListeners();
        break;
      case 'gameJoined':
        gameJoined = true;
        notifyListeners();
        break;
      case 'start':
        isGameStarted = true;
        yourTurn = data['yourTurn'];
        print('Game Created');
        notifyListeners();
        break;
      case 'availableGames':
        // Update available games when the listGames response is received
        _availableGames = List<Map<String, dynamic>>.from(data['games']);
        notifyListeners();
        break;
      case 'opponentMove':
        applyMove(data['move']);
        yourTurn = true;
        notifyListeners();
        break;
      case 'opponentLeft':
        notifyListeners();
        break;
    }
  }

  // Create a new game
  void createGame() {
    sendMessage({
      "type": "createGame",
      "gameType": "draughts",
    });
  }

  // Join an existing game
  void joinGame(String gameId) {
    print(gameJoined);
    sendMessage({
      "type": "joinGame",
      "gameId": gameId,
    });
  }

  // Request available games from the server
  void listAvailableGames() {
    sendMessage({
      "type": "listGames",
    });
  }

  // Make a move
  void makeMove(int row, int col) {
    if (!yourTurn) {
      print("It's not your turn");
      return;
    }

    // Send the move to the server
    sendMessage({
      "type": "move",
      "move": {"row": row, "col": col},
    });

    // Update board locally
    board[row][col] = "your_piece";
    yourTurn = false; // Now it's opponent's turn
    notifyListeners();
  }

  // Apply opponent's move to the board
  void applyMove(Map<String, dynamic> move) {
    int row = move['row'];
    int col = move['col'];
    board[row][col] = "opponent_piece";
  }

  // Dispose and close WebSocket connection
  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}
