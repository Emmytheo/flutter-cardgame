import 'dart:convert';

import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/models/whot_player_model.dart';

class WhotTurn {
  final List<WhotPlayerModel>? players;
  WhotPlayerModel? currentPlayer;

  WhotTurn({
    required this.players,
    required this.currentPlayer,
  });

  void playCard(int index, bool iNeed) {
    print(
        "${currentPlayer!.name} played ${currentPlayer!.cards[index].shape} ${currentPlayer!.cards[index].value}");
    // Send a message to the current player's channel to play a card
    currentPlayer!.channel.sink.add(json.encode({
      'message': 'player:play',
      'index': index,
      'iNeed': iNeed
    }).codeUnits);
  }

  void drawCard() {
    // Send a message to the current player's channel to draw a card
    currentPlayer!.channel.sink
        .add(json.encode({'message': 'market:pick'}).codeUnits);
  }

  WhotPlayerModel? get otherPlayer {
    return players!.firstWhere((p) => p != currentPlayer);
  }
}
