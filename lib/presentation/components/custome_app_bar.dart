import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CustomeAppBar extends StatelessWidget with PreferredSizeWidget {
   const CustomeAppBar({
    Key? key,
    required this.label,
    required this.actions,
  }) : super(key: key);

  final String label;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}