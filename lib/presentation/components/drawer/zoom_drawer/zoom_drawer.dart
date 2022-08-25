import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../Pages/home/home.dart';
import '../../../Pages/nav_bar_pages/pages.dart';

import 'menu_page.dart';
import 'menu_items.dart' as mi;

class CustomeZoomDrawer extends StatefulWidget {
  const CustomeZoomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomeZoomDrawer> createState() => _CustomeZoomDrawerState();
}

class _CustomeZoomDrawerState extends State<CustomeZoomDrawer> {
  mi.MenuItem currentItem = mi.MenuItems.jobs;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 30,
      angle:  0,
      androidCloseOnBackTap: true,
      clipMainScreen: true,
      mainScreenTapClose: true,
      menuBackgroundColor: Colors.redAccent.shade100,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.5,
      moveMenuScreen: false,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.white,
      menuScreen: MenuPage(
        currentItem: currentItem,
        onSelectedItem: (item) => setState(
          () => currentItem = item,
        ),
      ),
      mainScreen: getScreen(),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case mi.MenuItems.jobs:
        return const Home();
      case mi.MenuItems.profile:
        return const Profile();
      case mi.MenuItems.mailBox:
        return const Home();
      case mi.MenuItems.reports:
        return const Profile();
      case mi.MenuItems.aboutUs:
        return const Home();
      case mi.MenuItems.rateUs:
        return const Profile();
      default:
        return const Home();
    }
  }
}


