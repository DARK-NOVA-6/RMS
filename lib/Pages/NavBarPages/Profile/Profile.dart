import 'package:flutter/material.dart';

import '../Pages.dart';


class Profile extends StatefulWidget implements Pages {
  const Profile({Key? key}) : super(key: key);

  @override
  String get label => 'Profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Text(widget.label),
    );
  }
}
