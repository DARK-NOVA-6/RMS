import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class CustomeAppBar extends StatelessWidget with PreferredSizeWidget {
   const CustomeAppBar({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.redAccent,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.redAccent,
              ),
              onPressed: () {
                SimpleHiddenDrawerController.of(context).toggle();
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
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}