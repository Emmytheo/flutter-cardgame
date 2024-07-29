import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/whot_card_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WhotPlayerModel {
  final String name;
  late int? id;
  final bool isHuman;
  List<WhotCardModel> cards;
  int score;
  late WebSocketChannel channel;
  WebSocketChannel get _channel => channel;


  WhotPlayerModel({
    required this.name,
    required this.id,
    this.cards = const [],
    this.isHuman = false,
    this.score = 0, 
    required this.channel,
  });

  addCards(List<WhotCardModel> newCards) {
    cards = [...cards, ...newCards];
  }

  removeCard(WhotCardModel card) {
    cards.removeWhere((c) => c.value == card.value && c.shape == card.shape);
  }

  bool get isBot {
    return !isHuman;
  }
}
