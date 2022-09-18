import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nabos_mtg/app_controller.dart';

class MenuPersonWidget extends StatelessWidget {
  final Function(int number) onChangePersons;
  const MenuPersonWidget({Key? key, required this.onChangePersons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        scrollDirection: Axis.horizontal,
        children: List.generate(8, (index) {
          return SizedBox(
            width: 60,
            height: 50,
            child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                    onTap: () {
                      AppController.istance.changeMenuSelected('none');
                      onChangePersons(index + 1);
                      AppController.istance.changeNumberOfPlayers(index + 1);
                    },
                    onTapCancel: () => {},
                    onTapDown: (TapDownDetails) => {},
                    onTapUp: (TapDownDetails) => {},
                    child: Center(
                      child: Text('${index + 1}',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ))),
          );
        }),
      ),
    );
  }
}
