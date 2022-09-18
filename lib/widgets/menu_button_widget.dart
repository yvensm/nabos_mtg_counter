import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nabos_mtg/app_controller.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        height: 40,
        child: Material(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      AppController.istance.toggleMenu();
                    },
                    onTapCancel: () => {},
                    onTapDown: (TapDownDetails) => {},
                    onTapUp: (TapDownDetails) => {},
                    child: Image(
                      image: AssetImage('assets/nabo.png'),
                    )))));
  }
}
