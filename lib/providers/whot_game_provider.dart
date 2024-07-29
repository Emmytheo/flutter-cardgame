import 'dart:convert';

import 'package:cardgame/components/suit_chooser_modal.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/main.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/deck_model.dart';
import 'package:cardgame/models/game_model.dart';
import 'package:cardgame/models/games_model.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/models/turn_model.dart';
import 'package:cardgame/models/whot_card_model.dart';
import 'package:cardgame/models/whot_player_model.dart';
import 'package:cardgame/models/whot_turn_model.dart';
import 'package:cardgame/providers/game_provider.dart';
import 'package:cardgame/services/whot_game_service.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WhotGameProvider extends GameProvider {
  final WhotGameService _service = WhotGameService();
  late WebSocketChannel _channel;

  final String junk = "Booyahhhh";

  GamesModel? gameList;

  GameModel? currentGame;

  WhotPlayerModel? player;

  DeckModel? _currentDeck;
  DeckModel? get currentDeck => _currentDeck;

  List<WhotPlayerModel>? playerz = [];
  // @override
  // List<WhotPlayerModel>? get playerz => _playerz;

  late final WhotTurn whot_turn =
      WhotTurn(players: playerz, currentPlayer: null);
  // @override
  // WhotTurn get whot_turn => _whot_turn;

  List<WhotCardModel>? _discardz = [];
  @override
  List<WhotCardModel>? get discardz => _discardz;
  @override
  WhotCardModel? get discardTopp => _discardz!.isEmpty ? null : _discardz?.last;

  bool gameStart = false;

  Future<void> setupListeners(GameModel game) async {
    _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8800/game/${game.game_id}'));
    await _channel.ready;

    _channel.stream.listen((message) async {
      Map<String, dynamic> _message =
          Map<String, dynamic>.from(jsonDecode(message) as Map);

      switch (_message['message']) {
        case 'game:create':
          player = WhotPlayerModel(
              name: 'You',
              id: _message['playerId'],
              isHuman: true,
              channel: _channel);
          final games = await _service.listGames();
          gameList = games;
          if (currentGame!.game_id == _message['id']) {
            currentGame!.players = _message['players'];
            currentGame!.listeners = _message['listeners'];
          }
          break;

        case 'game:start':
          gameStart = true;
          WhotCardModel discardd = WhotCardModel.fromJson(_message['pile']);
          _discardz = [discardd];

          break;

        case 'player:hand':
          print(_message);
          player?.cards = List<WhotCardModel>.from(_message['hand']
              .map((cardJson) => WhotCardModel.fromJson(cardJson)));

          break;

        case 'turn:switch':
          // Switch to Player
          whot_turn.currentPlayer = player;
          break;

        case 'pile:top':
          break;

        default:
      }

      notifyListeners();
      // _channel.sink.add('received!');
      // _channel.sink.close(status.goingAway);
    });
  }

  // Function to create a player and set up its channel listener
  Future<void> createPlayer(
      String name, bool isHuman, WebSocketChannel channel) async {
    WhotPlayerModel player = WhotPlayerModel(
      name: name,
      isHuman: isHuman,
      channel: channel,
      id: null,
    );
    playerz!.add(player);
    int idx = playerz!.indexWhere((p) => p.name == name);
    playerz![idx].channel.stream.listen((message) async {
      Map<String, dynamic> _message =
          Map<String, dynamic>.from(jsonDecode(message) as Map);
      WhotPlayerModel player = playerz![idx];

      switch (_message['message']) {
        case 'game:create':
          print('Creating ${name}');
          player.id = _message['playerId'];
          final games = await _service.listGames();
          gameList = games;
          if (currentGame!.game_id == _message['id']) {
            currentGame!.players = _message['players'];
            currentGame!.listeners = _message['listeners'];
          }
          // game.players = [player];
          break;

        case 'game:start':
          gameStart = true;
          WhotCardModel discardd = WhotCardModel.fromJson(_message['pile']);
          _discardz = [discardd];
          break;

        case 'player:hand':
          player.cards = List<WhotCardModel>.from(_message['hand']
              .map((cardJson) => WhotCardModel.fromJson(cardJson)));
          break;

        case 'turn:switch':
          whot_turn.currentPlayer = player;
          break;

        case 'pile:top':
          // Handle pile:top message if needed
          print('Pile Top');
          print(_message);
          WhotCardModel discardd = WhotCardModel.fromJson(_message['card']);
          _discardz = [discardd];
          break;

        default:
        // Handle any other messages if needed
      }

      notifyListeners();
    });
  }

  // Function to create a player and set up its channel listener
  Future<void> createBot(
      String name, bool isHuman, WebSocketChannel channel) async {
    WhotPlayerModel player = WhotPlayerModel(
      name: name,
      isHuman: isHuman,
      channel: channel,
      id: null,
    );
    playerz!.add(player);
    int idx = playerz!.indexWhere((p) => p.name == name);
    playerz![idx].channel.stream.listen((message) async {
      Map<String, dynamic> _message =
          Map<String, dynamic>.from(jsonDecode(message) as Map);
      WhotPlayerModel player = playerz![idx];
      switch (_message['message']) {
        case 'game:create':
          print('Creating ${name}');
          player.id = _message['playerId'];
          final games = await _service.listGames();
          gameList = games;
          if (currentGame!.game_id == _message['id']) {
            currentGame!.players = _message['players'];
            currentGame!.listeners = _message['listeners'];
          }
          // game.players = [player];
          break;

        case 'game:start':
          // gameStart = true;
          WhotCardModel discardd = WhotCardModel.fromJson(_message['pile']);
          _discardz = [discardd];
          break;

        case 'player:hand':
          player.cards = List<WhotCardModel>.from(_message['hand']
              .map((cardJson) => WhotCardModel.fromJson(cardJson)));
          break;

        case 'turn:switch':
          whot_turn.currentPlayer = player;
          break;

        case 'pile:top':
          // Handle pile:top message if needed
          WhotCardModel discardd = WhotCardModel.fromJson(_message['card']);
          _discardz = [discardd];
          break;

        default:
        // Handle any other messages if needed
      }

      notifyListeners();
    });
  }

  Future<void> setupGameWithBots(GameModel game, {int maxPlayers = 4}) async {
    // Set up the main player (human)
    WebSocketChannel mainChannel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8800/game/${game.game_id}'));
    await mainChannel.ready;
    await createPlayer('You', true, mainChannel);

    // Create bot players
    for (int i = 1; i < maxPlayers; i++) {
      WebSocketChannel botChannel = WebSocketChannel.connect(
          Uri.parse('ws://localhost:8800/game/${game.game_id}'));
      await botChannel.ready;
      await createBot('Bot $i', false, botChannel);
    }
  }

  Future<void> listGames() async {
    final games = await _service.listGames();
    gameList = games;
    notifyListeners();
  }

  Future<void> setCurrentGame(GameModel game) async {
    currentGame = game;
    notifyListeners();
  }

  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCards(p, count: 8, allowAnyTime: true);
    }

    await drawCardToDiscardPile();

    setLastPlayed(discardTop!);

    turn.drawCount = 0;
    turn.actionCount = 0;
  }

  @override
  bool get canEndTurn {
    if (turn.drawCount > 0 || turn.actionCount > 0) {
      return true;
    }

    return false;
  }

  @override
  bool canPlayCard(CardModel card) {
    bool canPlay = false;

    if (gameState[GS_LAST_SUIT] == null || gameState[GS_LAST_VALUE] == null) {
      return false;
    }

    if (gameState[GS_LAST_SUIT] == card.suit) {
      canPlay = true;
    }

    if (gameState[GS_LAST_VALUE] == card.value) {
      canPlay = true;
    }

    if (card.value == "8") {
      canPlay = true;
    }

    return canPlay;
  }

  @override
  Future<void> applyCardSideEffects(CardModel card) async {
    if (card.value == "8") {
      Suit suit;

      if (turn.currentPlayer.isHuman) {
        suit = await showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => const SuitChooserModal(),
          barrierDismissible: false,
        );
      } else {
        suit = turn.currentPlayer.cards.first.suit;
      }

      gameState[GS_LAST_SUIT] = suit;
      setTrump(suit);
      showToast(
          "${turn.currentPlayer.name} has changed it to ${CardModel.suitToString(suit)}");
    } else if (card.value == "2") {
      await drawCards(turn.otherPlayer, count: 2, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 2 cards!");
    } else if (card.value == "QUEEN" && card.suit == Suit.Spades) {
      await drawCards(turn.otherPlayer, count: 5, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 5 cards!");
    } else if (card.value == "JACK") {
      showToast("${turn.otherPlayer.name} misses a turn!");
      skipTurn();
    }

    notifyListeners();
  }

  @override
  bool get gameIsOver {
    if (turn.currentPlayer.cards.isEmpty) {
      return true;
    }

    return false;
  }

  @override
  void finishGame() {
    showToast("Game over! ${turn.currentPlayer.name} WINS!");
    notifyListeners();
  }

  @override
  Future<void> botTurn() async {
    final p = turn.currentPlayer;

    await Future.delayed(const Duration(milliseconds: 500));

    for (final c in p.cards) {
      if (canPlayCard(c)) {
        await playCard(player: p, card: c);
        endTurn();
        return;
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    await drawCards(p);
    await Future.delayed(const Duration(milliseconds: 500));

    if (canPlayCard(p.cards.last)) {
      await playCard(player: p, card: p.cards.last);
    }

    endTurn();
  }
}
