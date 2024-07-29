import 'package:cardgame/models/deck_model.dart';
import 'package:cardgame/models/draw_model.dart';
import 'package:cardgame/models/game_model.dart';
import 'package:cardgame/models/games_model.dart';
import 'package:cardgame/services/api_service.dart';
import 'package:cardgame/services/whot_api_service.dart';

class WhotGameService extends WhotApiService {
  Future<GameModel> newGame([int deckCount = 1]) async {
    final data = await httpGet(
      '/games',
      // params: {'deck_count': deckCount},
    );

    return GameModel.fromJson(data);
  }

  Future<GamesModel> listGames() async {
    final data = await httpGetList(
      '/games',
      // params: {'deck_count': deckCount},
    );

    
    return GamesModel.fromJson(data);
  }

  Future<DrawModel> drawCards(DeckModel deck, {int count = 1}) async {
    final data = await httpGet(
      '/deck/${deck.deck_id}/draw',
      params: {'count': count},
    );

    return DrawModel.fromJson(data);
  }
}
