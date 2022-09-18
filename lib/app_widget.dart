import 'package:flutter/material.dart';
import 'package:nabos_mtg/app_controller.dart';
import 'package:nabos_mtg/pages/home.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.istance,
        builder: (context, child) {
          return MaterialApp(home: HomePage());
        });
  }
}
