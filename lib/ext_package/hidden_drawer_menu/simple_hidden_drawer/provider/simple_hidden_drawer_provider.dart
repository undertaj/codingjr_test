import 'package:project_m/ext_package/hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:flutter/material.dart';

class MyProvider extends InheritedWidget {
  final SimpleHiddenDrawerController controller;

  const MyProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
