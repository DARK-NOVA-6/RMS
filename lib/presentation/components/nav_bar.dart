import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
    required this.changeIndex,
    required this.index,
    required this.icons,
  }) : super(key: key);
  final void Function(int) changeIndex;
  int index;
  final List<Widget> icons;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          iconTheme: const IconThemeData(
        color: Colors.white,
      )),
      child: CurvedNavigationBar(
        height: 50,
        onTap: widget.changeIndex,
        index: widget.index,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).backgroundColor,
        items: widget.icons,
      ),
    );
  }
}
