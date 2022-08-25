import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/theme.dart';

import '../../../../provider/theme_notifier.dart';
import 'menu_items.dart' as mi;

// ignore: must_be_immutable
class MenuPage extends StatefulWidget {
  MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  mi.MenuItem currentItem;
  final ValueChanged<mi.MenuItem> onSelectedItem;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _val = false;

  bool get val => _val;

  set val(bool value) {
    _val = value;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildMenuItem(mi.MenuItem item) {
      return ListTile(
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon, color: Colors.white),
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white),
        ),
        onLongPress: () => widget.onSelectedItem(item),
        onTap: () {
          widget.onSelectedItem(item);
          ZoomDrawer.of(context)!.close();
        },
      );
    }

    return Consumer(builder: (context, ThemeNotifier themeNotifier, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(flex: 1),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: ScalableImageWidget.fromSISource(
                  si: ScalableImageSource.fromSvg(
                    rootBundle,
                    themeNotifier.darkTheme
                        ? 'assets/svg/Asset 6.svg'
                        : 'assets/svg/Asset 7.svg',
                  ),
                ),
                // child: SvgPicture.asset(
                //   width: 100,
                //   height: 100,
                //
                //   'assets/svg/Asset 9.svg',
                // ),
              ),
              const Spacer(flex: 2),
              ...mi.MenuItems.group1.map(buildMenuItem).toList(),
              Divider(
                color: Colors.white,
                thickness: 2,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                indent: MediaQuery.of(context).size.width * 0.03,
              ),
              ...mi.MenuItems.group2.map(buildMenuItem).toList(),
              const Spacer(flex: 3),
              Consumer(
                builder: (context, ThemeNotifier themeNotifier, child) {
                  return Center(
                    child: Transform.scale(
                      scale: 2,
                      child: Switch(
                        activeTrackColor: CustomeTheme.c2.withAlpha(100),
                        activeColor: CustomeTheme.c2,
                        inactiveTrackColor: CustomeTheme.c1.withAlpha(100),
                        inactiveThumbColor: CustomeTheme.c1,
                        onChanged: (bool value) => setState(
                          () {
                            themeNotifier.toggleTheme();
                            val = value;
                          },
                        ),
                        value: val,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      );
    });
  }
}
