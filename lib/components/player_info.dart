import 'package:cardgame/models/turn_model.dart';
import 'package:cardgame/models/whot_player_model.dart';
import 'package:cardgame/models/whot_turn_model.dart';
import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {
  final WhotTurn? turn;
  final List<WhotPlayerModel>? players;
  const PlayerInfo({Key? key, required this.turn, required this.players})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            players!.length > 1 &&
                    players!.indexWhere((plyr) => plyr.nowPlaying == true) != -1
                ? (players!.indexWhere((plyr) => plyr.nowPlaying == true) == 0
                    ? ("Your turn")
                    : ("Player ${players![players!.indexWhere((plyr) => plyr.nowPlaying == true)].id}'s turn"))
                : turn!.currentPlayer == players![0]
                    ? ("Your turn")
                    : ('Loading Players...'),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ]

            // turn!.players!.map((p) {
            //   final isCurrent = turn!.currentPlayer == p;
            //   return Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(3),
            //       color: isCurrent ? Colors.white : Colors.transparent,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(3.0),
            //       child: Text(
            //         "${p!.name} (${p.cards.length})",
            //         style: TextStyle(
            //             color: isCurrent ? Colors.black : Colors.white,
            //             fontWeight: FontWeight.w700),
            //       ),
            //     ),
            //   );
            // }).toList(),
            ),
      ),
    );
  }
}
