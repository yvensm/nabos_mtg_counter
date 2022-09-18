import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';

class PlayerWidget extends StatefulWidget {
  double? width;
  double? height;
  int? rotation;
  PlayerWidget({Key? key, this.width, this.height, this.rotation})
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

  _onLifeChange(String type) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        counterIsShowing = false;
        counter = 0;
      });
    });
    if (type == 'add') {
      setState(() {
        ++life;
        ++counter;
      });
    } else {
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
        if (counterDelay > 50) counterDelay = counterDelay - 50;
        log('$counterDelay');
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
    return Container(
        width: this.widget.width,
        height: this.widget.height,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Color.fromARGB(255, 192, 0, 0)),
        child: RotatedBox(
            quarterTurns: this.widget.rotation as int,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 192, 0, 0)),
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
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
                            '$life',
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          )),
                        )
                      ],
                    ),
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
}
