import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nabos_mtg/app_controller.dart';
import 'package:nabos_mtg/widgets/menu/menu_persons_widget.dart';
import 'package:nabos_mtg/widgets/menu_button_widget.dart';
import 'package:nabos_mtg/widgets/menu_widget.dart';
import 'package:nabos_mtg/widgets/player_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  bool menuAnimationEnd = false;
  List keys = List.generate(
      AppController.istance.numberOfPlayers, (index) => GlobalKey());

  changeNumberOfKeys(int number) {
    keys = List.generate(number, (index) => GlobalKey());
  }

  getMenuActivated(String menuName) {
    switch (menuName) {
      case 'person':
        return MenuPersonWidget(
            onChangePersons: (number) => changeNumberOfKeys(number));
      case 'none':
        return Menu(
          onReset: () => keys.forEach((element) {
            element.currentState.resetLife();
          }),
        );
      default:
        return null;
    }
  }

  listOfPlayers(int players) {
    int length = ((players / 2).floor()) + (players % 2);

    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    if (players <= 2)
      return [
        Row(children: [
          Column(children: [
            PlayerWidget(
              width: width,
              height: heigth / 2,
              rotation: getRotationByIndex(players, 0),
              playerNumber: 0,
            )
          ])
        ]),
        Row(children: [
          Column(children: [
            PlayerWidget(
              width: width,
              height: heigth / 2,
              rotation: getRotationByIndex(players, 1),
              playerNumber: 1,
            )
          ])
        ]),
      ];
    int index = 0;

    final list = List.generate(length, (listIndex) {
      int sublistLength = players % 2 == 0
          ? 2
          : listIndex == length - 1
              ? 1
              : 2;

      double subwidth = sublistLength == 2 ? width / 2 : width;
      double subheigth =
          sublistLength == 2 ? heigth / length : (heigth - 20) / length;

      final sublist = List.generate(sublistLength, (subListIndex) {
        index++;
        return Column(children: [
          PlayerWidget(
            key: keys[index - 1],
            width: subwidth,
            height: subheigth,
            rotation: getRotationByIndex(players, index - 1),
            playerNumber: index - 1,
          )
        ]);
      });

      return Row(
        children: sublist,
      );
    });

    // list.insert(1, Row(children: [Flexible(flex: 1, child: Menu())]));
    return list;
  }

  calculateWidth(context, int numberOfPlayers) {
    return ({
      'width': MediaQuery.of(context).size.width - 10,
      'height': (MediaQuery.of(context).size.height - 10) / 2
    });
  }

  getRotationByIndex(int players, int index) {
    if (AppController.istance.numberOfPlayers == 2) {
      return [2, 0][index];
    }
    final list = List<int>.generate(players, (index) {
      if (index % 2 == 0) {
        if (players % 2 != 0 && index == players - 1) {
          return 0;
        }
        return 1;
      } else {
        return 3;
      }
    });

    return list[index];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listToRender =
        listOfPlayers(AppController.istance.numberOfPlayers);
    return Scaffold(
        backgroundColor: Colors.black,
        // body: Stack(children: [listToRender[0], listToRender[1]]),
        body: Stack(children: [
          ListView.builder(
            itemCount: listToRender.length,
            itemBuilder: (context, index) => listToRender[index],
          ),
          AnimatedPositioned(
              top: AppController.istance.menuOpened
                  ? MediaQuery.of(context).size.height / listToRender.length -
                      60
                  : MediaQuery.of(context).size.height / listToRender.length,
              child: AnimatedContainer(
                onEnd: () => {
                  setState(() {
                    menuAnimationEnd = true;
                  })
                },
                duration: Duration(milliseconds: 300),
                child: AppController.istance.menuOpened && this.menuAnimationEnd
                    ? getMenuActivated(AppController.istance.menuSelected)
                    : null,
                width: MediaQuery.of(context).size.width,
                height: AppController.istance.menuOpened ? 80 : 0,
                decoration: BoxDecoration(color: Colors.black),
              ),
              duration: Duration(milliseconds: 300)),
          AnimatedPositioned(
              duration: Duration(
                milliseconds: 300,
              ),
              top: AppController.istance.menuOpened
                  ? MediaQuery.of(context).size.height / listToRender.length -
                      80
                  : MediaQuery.of(context).size.height / listToRender.length -
                      20,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: MenuButton())
          //
          ,
        ]));
  }
}
