import 'package:cardgame/components/dragged_playing_card.dart';
import 'package:cardgame/components/player_card.dart';
import 'package:cardgame/components/playing_card.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/models/whot_card_model.dart';
import 'package:cardgame/models/whot_player_model.dart';
import 'package:cardgame/models/whot_turn_model.dart';
import 'package:flutter/material.dart';

class PlayerList extends StatelessWidget {
  final double size;
  final WhotPlayerModel? player;
  final Function(CardModel)? onPlayCard;
  WhotTurn? turn;
  bool? botCard;
  final List<WhotPlayerModel> otherPlayers;

  PlayerList({
    Key? key,
    required this.player,
    this.size = 1,
    this.onPlayCard,
    this.turn,
    this.botCard = false,
    required this.otherPlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CARD_HEIGHT * size,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: otherPlayers.length,
        itemBuilder: (context, index) {
          // final card = player!.cards[index];
          final isDraggable = turn!.currentPlayer == player;

          return PlayerCard(
                  // card: card,
                  size: size,
                  // visible: player!.isHuman,
                  visible:  true,
                  onPlayCard: onPlayCard,
                  index: index,
                  turn: turn,
                  player: otherPlayers[index],
                );
        },
      ),
    );
  }
}
