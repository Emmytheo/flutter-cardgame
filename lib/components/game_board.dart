import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cardgame/components/card_list.dart';
import 'package:cardgame/components/deck_pile.dart';
import 'package:cardgame/components/discard_pile.dart';
import 'package:cardgame/components/player_info.dart';
import 'package:cardgame/components/player_list.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/game_model.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:cardgame/providers/crazy_eights_game_provider.dart';
import 'package:cardgame/providers/thirty_one_game_provider.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int acceptedData = 0;
  bool drag = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WhotGameProvider>(
      builder: (context, model, child) {
        if (model.gameStart) {
          return Column(
            children: [
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
                              // const SizedBox(width: 8),
                              DragTarget<int>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return DiscardPile(
                                    cards: model.whot_turn.discardz,
                                    // onPressed: (card) {
                                    //   model.drawCardsFromDiscard(
                                    //       model.turn.currentPlayer);
                                    // },
                                  );
                                },
                                onAcceptWithDetails:
                                    (DragTargetDetails<int> details) {
                                  setState(() {
                                    model.whot_turn.playCard(details.data);
                                  });
                                },
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
                        child: model.playerz!.length > 1
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PlayerInfo(
                                      turn: model.whot_turn,
                                      players: model.playerz),
                                  PlayerList(
                                    player: model.whot_turn.currentPlayer,
                                    turn: model.whot_turn,
                                    botCard: true,
                                    otherPlayers: model.playerz!
                                        .where((p) => p.isHuman == false)
                                        .toList(),
                                  ),
                                ],
                              )
                            : Container()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (model.whot_turn.currentPlayer ==
                                    model.primaryPlayer)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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

                                      Row(
                                        children: [
                                          model.whot_turn.draggable!
                                              ? const Icon(
                                                  Icons.swipe_left,
                                                )
                                              : const Icon(
                                                  Icons.do_not_touch,
                                                ),
                                          Switch(
                                            // thumb color (round icon)
                                            activeColor: Colors.cyan,
                                            activeTrackColor: Colors.white,
                                            inactiveThumbColor:
                                                Colors.blueGrey.shade600,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            splashRadius: 50.0,
                                            // boolean variable value
                                            value: model.whot_turn.draggable!,
                                            // changes the state of the switch
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                model.whot_turn.draggable =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      // const ElevatedButton(
                                      //     onPressed: null,
                                      //     // onPressed: model.canEndTurn
                                      //     //     ? () {
                                      //     //         model.endTurn();
                                      //     //       }
                                      //     //     : null,
                                      //     child: Text("Your Turn"))
                                    ],
                                  )
                                : Container(),
                          ),
                          CardList(
                              player: model.playerz![0], turn: model.whot_turn
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
        } else if (!model.gameStart &&
            model.gameList != null &&
            model.gameList?.isNotEmpty &&
            model.currentGame == null) {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  // color: Colors.black87,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Whot - Available Games (${model.gameList!.length})',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.gameList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                          // tileColor: const Color(0xffc16c34),
                          title:
                              Text('Game #${model.gameList![index].game_id}'),
                          subtitle: Text(
                              '(${model.gameList![index].players} / ${model.gameList![index].noOfPlayers}) Players - ${model.gameList![index].listeners} Listeners'),
                          trailing: TextButton(
                            onPressed: () async {
                              await model
                                  .setCurrentGame(model.gameList![index]);
                              // await model.setupListeners(model.gameList![index]);
                              await model.setupGame(model.gameList![index]);
                              print(model.currentGame);
                              print(model.gameStart);
                            },
                            child: const Text('Start Game'),
                          )),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (!model.gameStart && model.currentGame != null) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                // color: Colors.black87,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Whot - Game #(${model.currentGame!.game_id}) Lobby',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome to the Game #${model.currentGame!.game_id} Lobby',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'You and ${model.currentGame!.players! - 1} Players Joined - Waiting for ${model.currentGame!.noOfPlayers! - model.currentGame!.players!} More',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                                child: TextButton(
                                  onPressed: () async {
                                    await model.setCurrentGame(
                                        GameModel.fromJson(model.gameList!
                                            .toJson()
                                            .firstWhere((game) =>
                                                GameModel.fromJson(game)
                                                    .game_id ==
                                                model.currentGame!.game_id)));
                                    // await model.setupListeners(model.gameList![index]);
                                    await model.setupGameWithBots(
                                        model.currentGame!,
                                        maxPlayers:
                                            model.currentGame!.noOfPlayers! -
                                                model.currentGame!.players! +
                                                1);
                                  },
                                  child: const Text('Start Game with Bots'),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                                child: TextButton(
                                  child: const Text("Leave Game"),
                                  onPressed: () {
                                    // final players = [
                                    //   PlayerModel(name: "Tyler", isHuman: true),
                                    //   PlayerModel(name: "Bot", isHuman: false),
                                    // ];
                                    // model.newGame(players);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: TextButton(
              child: const Text("New Game?"),
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
