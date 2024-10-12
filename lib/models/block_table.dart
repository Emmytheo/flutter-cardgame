import 'package:cardgame/models/killing.dart';
import 'package:cardgame/models/men.dart';

class BlockTable {
  int row;
  int col;
  Men? men;
  bool isHighlight;
  bool isHighlightAfterKilling;
  Killed victim = Killed.none();
  bool killableMore = false;

  BlockTable(
      {this.row = 0,
      this.col = 0,
      required this.men,
      this.isHighlight = false,
      this.isHighlightAfterKilling = false,
      this.killableMore = false});
}
