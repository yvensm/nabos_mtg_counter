import 'dart:ffi';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  static AppController istance = AppController();

  int numberOfPlayers = 3;
  List playersLifeTotal = List.generate(3, (index) => 40);
  List playersColor = List.generate(
      3,
      (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0));
  bool menuOpened = false;
  String menuSelected = 'none';

  toggleMenu() {
    menuOpened = !menuOpened;
    notifyListeners();
  }

  changeNumberOfPlayers(int number) {
    numberOfPlayers = number;
    playersLifeTotal = List.generate(number, (index) => 40);
    playersColor = List.generate(
        number,
        (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0));
    notifyListeners();
  }

  changeMenuSelected(String option) {
    menuSelected = option;
    notifyListeners();
  }

  lifeChange(String type, int playerNumber) {
    if (type == 'add') {
      playersLifeTotal[playerNumber] = ++playersLifeTotal[playerNumber];
    } else {
      playersLifeTotal[playerNumber] = --playersLifeTotal[playerNumber];
    }
    notifyListeners();
  }

  changePlayerColor(Color color, int playerNumber) {
    playersColor[playerNumber] = color;
    notifyListeners();
  }

  resetLife() {
    playersLifeTotal = List.generate(numberOfPlayers, (index) => 40);
    notifyListeners();
  }
}
