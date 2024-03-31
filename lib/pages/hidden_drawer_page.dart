
import 'package:project_m/ext_package/hidden_drawer_menu/hidden_drawer_menu.dart';

import 'package:flutter/material.dart';
import 'package:project_m/pages/home_page.dart';


class HiddenDrawerPage extends StatefulWidget {
  const HiddenDrawerPage({super.key});


  @override
  State<HiddenDrawerPage> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawerPage> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Coding Junior',
          baseStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        const HomePage(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Profile',
          baseStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        const HomePage(),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorAppBar: const Color(0xff464646),
      elevationAppBar: 0,
      disableAppBarDefault: false,

      // backgroundColorMenu: const Color(0xFF1E1E1E),
      screens: _pages,

      initPositionSelected: 0,
      slidePercent: 50,
      leadingAppBar: const Icon(
        Icons.menu,
        // color: Colors.white,
      ),
      contentCornerRadius: 25,
      boxShadow: const [],

      // verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0,
      //  elevationAppBar: 100.0
    );
  }
}
