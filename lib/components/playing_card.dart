import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardgame/components/card_back.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/whot_card_model.dart';
import 'package:cardgame/models/whot_turn_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayingCard extends StatelessWidget {
  final WhotCardModel card;
  final double size;
  final bool visible;
  final Function(CardModel)? onPlayCard;
  WhotTurn? turn;
  final int index;

  PlayingCard(
      {Key? key,
      required this.card,
      this.size = 1,
      this.visible = false,
      this.onPlayCard,
      required this.index,
      this.turn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (onPlayCard != null) onPlayCard!(card);
        turn!.playCard(
            index, card.shape == 'Whot' && card.value == 20 ? true : false);
      },
      child: Container(
          width: CARD_WIDTH * size,
          height: CARD_HEIGHT * size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAlias,
          // child: Center(
          //     child: SvgPicture.asset(card.image,
          //         colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
          //         semanticsLabel: card.shape)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(card.shape),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("${card.value}"),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("${card.value}"),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("${card.value}"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text("${card.value}"),
                ),
              ],
            ),
          )
          // child: visible
          //     ? CachedNetworkImage(
          //         imageUrl: card.image,
          //         width: CARD_WIDTH * size / 2,
          //         height: CARD_HEIGHT * size / 2,
          //       )
          //     : CardBack(size: size),
          ),
    );
  }
}
