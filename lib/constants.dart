import 'package:flutter/material.dart';

const CARD_WIDTH = 226 / 2;
const CARD_HEIGHT = 314 / 2;

const GS_LAST_SUIT = 'GS_LAST_SUIT';
const GS_LAST_VALUE = 'GS_LAST_VALUE';


Color chachaAppBarColor() => const Color.fromRGBO(116, 3, 106, 1);

Color chachaBottomAppBarColor() => const Color.fromRGBO(48, 0, 44, 1);

Color chachaLightColor() => const Color.fromRGBO(246, 198, 237, 1);



BoxDecoration chachaBackground() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromRGBO(116, 3, 106, 1), Color.fromRGBO(48, 0, 44, 1)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
