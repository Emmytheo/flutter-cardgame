// ignore_for_file: non_constant_identifier_names

class GameModel {
  final int game_id;
  late final int players;
  late final int listeners;

  GameModel({
    required this.game_id,
    required this.players,
    required this.listeners,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return GameModel(
      game_id: json['id'],
      players: json['players'],
      listeners: json['listeners'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': game_id, 'players': players, 'listeners': listeners};
  }
}
