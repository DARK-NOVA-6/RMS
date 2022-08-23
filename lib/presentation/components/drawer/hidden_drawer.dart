import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:untitled/presentation/Pages/home/home.dart';

import '../../pages/home/test.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List <ScreenHiddenDrawer> _pages = [];

  TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
  );


  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: textStyle,
          selectedStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
          colorLineSelected: Colors.redAccent,
        ),
        const Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Test',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        const Test(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      disableAppBarDefault: true,
      slidePercent: 40,
      screens: _pages,
      backgroundColorMenu: Colors.red.shade200,
      initPositionSelected: 0,
    );
  }

}
