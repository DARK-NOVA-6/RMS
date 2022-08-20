import 'package:flutter/material.dart';

import '../Pages.dart';

class MainHome extends StatefulWidget implements Pages{
  const MainHome({Key? key}) : super(key: key);

  @override
  String get label => 'MainHome';

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.label),
    );
  }
}
