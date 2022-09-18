import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nabos_mtg/app_controller.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  onTap: () => {log('tap people')},
                  onTapCancel: () => {},
                  onTapDown: (TapDownDetails) => {},
                  onTapUp: (TapDownDetails) => {},
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 40.0,
                  ),
                )),
          )
        ],
      ),
    );
  }
}


// Container(
//           width: MediaQuery.of(context).size.width,
//           height: 120,
//           decoration: BoxDecoration(color: Colors.transparent),
//           child: Center(
//               child: AnimatedContainer(
//             width: MediaQuery.of(context).size.width,
//             height: AppController.istance.menuOpened ? 80 : 2,
//             decoration: BoxDecoration(color: Colors.black),
//             duration: Duration(
//               milliseconds: 500,
//             ),
//             child: Text('teste'),
//             curve: Curves.fastOutSlowIn,
//           ))),