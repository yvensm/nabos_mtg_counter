import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nabos_mtg/app_controller.dart';
import 'package:nabos_mtg/helpers/rotation_helper.dart';

class PlayerWidget extends StatefulWidget {
  double? width;
  double? height;
  int? rotation;
  int playerNumber;
  PlayerWidget(
      {Key? key,
      this.width,
      this.height,
      this.rotation,
      required this.playerNumber})
      : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  int life = 40;
  int counter = 0;
  bool counterIsShowing = false;
  Timer? timerNextCounter;
  int counterDelay = 500;
  Timer? _debounce;
  Color color = Colors.red;
  RotationHelper rotationHelper = RotationHelper();
  resetLife() {
    setState(() {
      life = 40;
    });
  }

  listOfPlayers(int players) {
    // log('Width: ${widget.width}, Heigth:${widget.height}');
    int length = ((players / 2).floor()) + (players % 2);

    double width = (widget.width! * 0.7) > 150.0 ? 150.0 : widget.width! * 0.7;
    double heigth = widget.height! * 0.15;

    if (players <= 2)
      return [
        Row(children: [
          Column(children: [Text('1')])
        ]),
        Row(children: [
          Column(children: [Text('2')])
        ]),
      ];
    int index = 0;

    final list = List.generate(length, (listIndex) {
      int sublistLength = players % 2 == 0
          ? 2
          : listIndex == length - 1
              ? 1
              : 2;

      // double subwidth = sublistLength == 2 ? width / 2 : width;
      double subwidth =
          sublistLength == 2 ? width / length : (width - 20) / length;
      double subheigth = sublistLength == 2 ? heigth / 2 : heigth;

      final sublist = List.generate(sublistLength, (subListIndex) {
        index++;
        return SizedBox(
            width: subwidth,
            height: subheigth,
            child: Center(
                child: Text(
                    index == widget.playerNumber + 1 ? 'Me' : '${index}')));
      });

      return Column(
          children: widget.rotation! > 2 ? sublist : sublist.reversed.toList());
    });

    // list.insert(1, Row(children: [Flexible(flex: 1, child: Menu())]));
    return widget.rotation! > 2 ? list.reversed.toList() : list;
  }

  _onLifeChange(String type) {
    // log('Player: ${this.widget.playerNumber}');
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        counterIsShowing = false;
        counter = 0;
      });
    });
    if (type == 'add') {
      // AppController.istance.lifeChange('add', widget.playerNumber);
      setState(() {
        ++life;
        ++counter;
      });
    } else {
      // AppController.istance.lifeChange('minus', widget.playerNumber);
      setState(() {
        --life;
        --counter;
      });
    }

    counterIsShowing = true;
  }

  _onHoldLifeChange(String type) {
    if (timerNextCounter?.isActive ?? false) timerNextCounter?.cancel();
    timerNextCounter = Timer(Duration(milliseconds: counterDelay), () {
      setState(() {
        _onHoldLifeChange(type);
        if (counterDelay > 50)
          counterDelay = counterDelay - 50;
        else if (counterDelay > 10) counterDelay = counterDelay - 10;
        // log('$counterDelay');
      });
    });
    _onLifeChange(type);
  }

  _onLeaveHoudLifeChange() {
    if (timerNextCounter?.isActive ?? false) timerNextCounter?.cancel();
    setState(() {
      counterDelay = 500;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listToRender =
        listOfPlayers(AppController.istance.numberOfPlayers);

    return Container(
        width: widget.width,
        height: widget.height,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Color.fromARGB(255, 192, 0, 0)),
        child: RotatedBox(
            quarterTurns: this.widget.rotation as int,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppController
                        .istance.playersColor[this.widget.playerNumber]),
                margin: EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Positioned(
                          child: SizedBox(
                              width: 40,
                              height: this.widget.height,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    // onTap: () {
                                    //   _onLifeChange('minus');
                                    // },
                                    onTapCancel: () => _onLeaveHoudLifeChange(),
                                    onTapDown: (TapDownDetails) =>
                                        _onHoldLifeChange('minus'),
                                    onTapUp: (TapDownDetails) =>
                                        _onLeaveHoudLifeChange(),
                                    child: Center(
                                        child: Text(
                                      '-',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ))),
                              )))
                    ]),
                    Expanded(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: 5,
                            right: 20,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Material(
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: () => {openDialogChangeColor()},
                                    onTapCancel: () => {},
                                    onTapDown: (TapDownDetails) => {},
                                    onTapUp: (TapDownDetails) => {},
                                    child: Icon(
                                      Icons.palette,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  )),
                            )),
                        Positioned(
                          top: 10,
                          child: Center(
                              child: Text(
                            counterIsShowing
                                ? '${counter > 0 ? '+' : ''}$counter'
                                : '',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            '${life}',
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          )),
                        ),
                        Positioned(
                            bottom: 10,
                            child: LimitedBox(
                                maxWidth: 150,
                                maxHeight: widget.height! * 0.15,
                                child: SizedBox(
                                    width: widget.width! * 0.7,
                                    height: widget.height! * 0.15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Row(
                                        children: listToRender,
                                      ),
                                    ))))
                      ],
                    )),
                    Stack(alignment: Alignment.center, children: [
                      Positioned(
                          child: SizedBox(
                              width: 40,
                              height: this.widget.height! - 0,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    // onTap: () {
                                    //   _onLifeChange('minus');
                                    // },
                                    onTapDown: (TapDownDetails) =>
                                        _onHoldLifeChange('add'),
                                    onTapUp: (TapDownDetails) =>
                                        _onLeaveHoudLifeChange(),
                                    onTapCancel: () => _onLeaveHoudLifeChange(),
                                    child: Center(
                                        child: Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ))),
                              )))
                    ]),
                  ],
                ))));
  }

  Future openDialogChangeColor() => showDialog(
      context: context,
      builder: (context) => RotatedBox(
          quarterTurns: widget.rotation as int,
          child: AlertDialog(
            title: Text('Jogador ${widget.playerNumber + 1}'),
            content: BlockPicker(
                pickerColor: color,
                onColorChanged: ((value) {
                  AppController.istance
                      .changePlayerColor(value, widget.playerNumber);
                })),
          )));
}
