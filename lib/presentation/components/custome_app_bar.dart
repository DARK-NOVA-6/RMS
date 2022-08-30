import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

// ignore: must_be_immutable
class CustomeAppBar extends StatefulWidget with PreferredSizeWidget {
  CustomeAppBar({
    Key? key,
    required this.label,
    this.actions = const [],
    this.actions1 = const [],
    this.actions2 = const [],
  }) : super(key: key);

  final String label;
  List<Widget> actions, actions1, actions2;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomeAppBar> createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: (widget.actions.isNotEmpty)
          ? widget.actions
          : (Provider.of<UpdateActionBarActions>(context).edit)
              ? widget.actions1
              : widget.actions2,
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
        widget.label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      centerTitle: true,
    );
  }
}
