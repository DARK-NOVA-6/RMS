import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'menu_items.dart' as mi;

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  mi.MenuItem currentItem;
  final ValueChanged<mi.MenuItem> onSelectedItem;

  @override
  Widget build(BuildContext context) {

    Widget buildMenuItem(mi.MenuItem item) {
      return ListTileTheme(
        selectedColor: Colors.white,
        selectedTileColor: Colors.black12,
        child: ListTile(
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onLongPress: ()=> onSelectedItem(item),
          onTap: () {
            onSelectedItem(item);
            ZoomDrawer.of(context)!.close();
          },
        ),
      );
    }

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              ...mi.MenuItems.group1.map(buildMenuItem).toList(),
              Divider(
                color: Colors.white,
                thickness: 2,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                indent: MediaQuery.of(context).size.width * 0.03,
              ),
              ...mi.MenuItems.group2.map(buildMenuItem).toList(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
