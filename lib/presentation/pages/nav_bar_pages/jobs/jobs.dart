import 'package:flutter/material.dart';

import '../pages.dart';

class Jobs extends StatefulWidget implements Pages{
  const Jobs({Key? key}) : super(key: key);

  @override
  String get label => 'Jobs';

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.label),
    );
  }
}
