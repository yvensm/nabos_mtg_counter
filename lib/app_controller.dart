import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  static AppController istance = AppController();

  int numberOfPlayers = 3;
  bool menuOpened = false;

  toggleMenu() {
    menuOpened = !menuOpened;
    notifyListeners();
  }

  changeNumberOfPlayers(int number) {
    numberOfPlayers = number;
    notifyListeners();
  }
}
