import 'package:cardgame/models/men.dart';

class Killed {
  late bool isKilled;
  late Men? men;

  Killed({this.isKilled = false, required this.men});

  Killed.none(){
    isKilled = false;
  }
}