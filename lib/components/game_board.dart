import 'package:cardgame/components/card_list.dart';
import 'package:cardgame/components/deck_pile.dart';
import 'package:cardgame/components/discard_pile.dart';
import 'package:cardgame/components/player_info.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/providers/crazy_eights_game_provider.dart';
import 'package:cardgame/providers/thirty_one_game_provider.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WhotGameProvider>(
      builder: (context, model, child) {
        if (model.gameStart && model.whot_turn.currentPlayer != null) {
          return Column(
            children: [
              PlayerInfo(turn: model.whot_turn),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // GestureDetector(
                              //   onTap: () async {
                              //     await model
                              //         .drawCards(model.turn.currentPlayer);
                              //   },
                              //   child: DeckPile(
                              //     remaining: model.currentDeck!.remaining,
                              //   ),
                              // ),
                              const SizedBox(width: 8),
                              DiscardPile(
                                cards: model.discardz,
                                // onPressed: (card) {
                                //   model.drawCardsFromDiscard(
                                //       model.turn.currentPlayer);
                                // },
                              ),
                            ],
                          ),
                          if (model.bottomWidget != null &&
                              model.showBottomWidget)
                            model.bottomWidget!
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CardList(
                        player: model.whot_turn.currentPlayer,
                        turn: model.whot_turn,
                        botCard: true,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (model.whot_turn.currentPlayer ==
                                    model.playerz![0])
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ...model.additionalButtons
                                          .map((button) => Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: ElevatedButton(
                                                    onPressed: button.enabled
                                                        ? button.onPressed
                                                        : null,
                                                    child: Text(button.label)),
                                              ))
                                          .toList(),
                                      const ElevatedButton(
                                          onPressed: null,
                                          // onPressed: model.canEndTurn
                                          //     ? () {
                                          //         model.endTurn();
                                          //       }
                                          //     : null,
                                          child: Text("Your Turn"))
                                    ],
                                  )
                                : Container(),
                          ),
                          CardList(
                            player: model.playerz![0],
                            turn: model.whot_turn
                            // onPlayCard: (CardModel card) {
                            //   model.playCard(
                            //       player: model.players[0], card: card);
                            // },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        } else if (model.gameList != null && model.gameList?.isNotEmpty) {
          return Center(
            child: ListView.builder(
              itemCount: model.gameList!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                      title: Text('Game #${model.gameList![index].game_id}'),
                      subtitle:
                          Text('(${model.gameList![index].players} / 4) Players - ${model.gameList![index].listeners} Listeners'),
                      trailing: TextButton(
                        onPressed: () async {
                          await model.setCurrentGame(model.gameList![index]);
                          // await model.setupListeners(model.gameList![index]);
                          await model.setupGameWithBots(model.gameList![index],
                              maxPlayers: 4);
                        },
                        child: Text(
                            'Start Game'),
                      )),
                );
              },
            ),
          );
        } else {
          return Center(
            child: TextButton(
              child: Text("New Game?"),
              onPressed: () {
                // final players = [
                //   PlayerModel(name: "Tyler", isHuman: true),
                //   PlayerModel(name: "Bot", isHuman: false),
                // ];
                // model.newGame(players);
              },
            ),
          );
        }
      },
    );
  }
}
